/* *********************************
*  client related functions
 ***********************************/
drop function if exists view_customer(int) cascade;
create function view_customer(id int)
returns record as
  $$
  declare
    profile record;
  begin
    select fname, lname, street, town, postal into profile from express_railway.customers where pid = $1;
    return profile;
  end
  $$ language plpgsql;

drop function if exists add_customer(varchar, varchar, varchar, varchar, char) cascade;
create function add_customer(fname varchar, lname varchar, street varchar, town varchar, postal char)
returns int as
  $$
  declare
    max_id int;
  begin
    select max(pid) into max_id from express_railway.customers;
    insert into express_railway.customers VALUES(max_id + 1, $1, $2, $3, $4, $5);
    return max_id + 1;
  end
  $$ language plpgsql;


drop function if exists edit_customer(int, varchar, varchar, varchar, varchar, char) cascade;
create function edit_customer(id int, fname varchar, lname varchar, street varchar, town varchar, postal char)
returns record as
  $$
  declare
    new_profile record;
  begin
    update express_railway.customers
    set fname = $2,
        lname = $3,
        street = $4,
        town = $5,
        postal = $6
    where pid = $1;
    select view_customer($1) into new_profile;
    return new_profile;
  end
  $$ language plpgsql;

drop function if exists reserve_route(int, int, varchar) cascade;
create function reserve_route(pid int, route_id int, day varchar)
returns table(trip int, t time, train int) as
  $$
  begin
    select s.tid, s.time into train, t from express_railway.schedules s
    where s.route_id = $2 and s.day = $3 and s.available_seats > 0 limit 1;
    insert into express_railway.trips(pid) VALUES($1) returning trip_id into trip;
    insert into express_railway.itinerary VALUES(trip, $2, train, $3, t);
    return next;
  end;
  $$ language plpgsql;




/* *********************************
*  helper functions to calculate price, distance, and time
 ***********************************/
drop function if exists get_distance(int, int, int) cascade;
create function get_distance(route int, start_position int, end_position int)
returns integer as
  $$
  declare
    distance int;
    next_position int;
    current_station int;
    next_station int;
    rail int;
  begin
    distance := 0;
    next_position := $2 + 1;
    while next_position <= $3 loop
      select l.sid, l.rid into next_station, rail from express_railway.legs l
      where l.route_id = $1 and l.position = next_position;

      select l.sid into current_station from express_railway.legs l
      where l.route_id = $1 and l.position = next_position - 1;

      distance:= distance + (
          select t.distance from express_railway.trails t
          where t.rid = rail and t.position = (
            select max(position) from express_railway.trails
            where rid = rail and (sid = current_station or sid = next_station)));

      next_position := next_position + 1;
    end loop;
    return distance;
  end;
  $$ language plpgsql;

drop function if exists get_price(int, int, int, int) cascade;
create function get_price(route int, start_position int, end_position int, train_id int)
returns integer as
  $$
  declare
    unit_price float;
  begin
    select t.cost_km into unit_price from express_railway.trains t where t.tid = $4;
    return unit_price * get_distance($1, $2, $3);
  end;
  $$ language plpgsql;


drop function if exists get_time(int, int, int, int) cascade;
create function get_time(route int, start_position int, end_position int, train_id int)
returns interval as
  $$
  declare
    time_needed float;
    train_speed float;
    rail_speed float;
    distance int;
    next_position int;
    current_station int;
    next_station int;
    rail int;
  begin
    time_needed := 0;
    next_position := $2 + 1;
    while next_position <= $3 loop
      select l.sid, l.rid into next_station, rail from express_railway.legs l
      where l.route_id = $1 and l.position = next_position;

      select l.sid into current_station from express_railway.legs l
      where l.route_id = $1 and l.position = next_position - 1;

      select t.distance into distance from express_railway.trails t
      where t.rid = rail and t.position = (
        select max(position) from express_railway.trails
        where rid = rail and (sid = current_station or sid = next_station));

      select t.speed_kmh into train_speed from express_railway.trains t where t.tid = $4;
      select r.speed_limit into rail_speed from express_railway.rails r where r.rid = rail;

      time_needed := time_needed + distance / least(train_speed, rail_speed);
      next_position := next_position + 1;
    end loop;
    return (time_needed * 60 * 60)::varchar::interval;
  end;
  $$ language plpgsql;

drop function if exists get_transfer_table() cascade;
create function get_transfer_table()
returns table(r1 int, r2 int, transfer_station int, r1_position int, r2_position int, r1_stop int, r2_stop int) as
  $$
  begin
    return query
      select r1.route_id, r2.route_id, transfer.sid, r1.position, r2.position, r1.stop, r2.stop
      from express_railway.stations transfer
        join express_railway.legs r1 on transfer.sid = r1.sid
        join express_railway.legs r2 on transfer.sid = r2.sid
      where r1.route_id <> r2.route_id and r1.stop is not null and r2.stop is not null
      order by r1.route_id, r2.route_id, transfer.sid;
  end;
  $$ language plpgsql;
/* *********************************
*  route search functions
 ***********************************/

-- single route trip search
drop function if exists find_single_route(int, int, varchar) cascade;
create function find_single_route(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time) as
  $$
  begin
    return query
      select s.route_id, s.tid, s.time from express_railway.schedules s
      join express_railway.legs arrival on s.route_id = arrival.route_id
      join express_railway.legs destination on s.route_id = destination.route_id
      where s.day = $3 and s.available_seats > 0
       and (arrival.sid = $1 and arrival.stop is not null )
       and (destination.sid = $2 and destination.stop is not null)
       and (arrival.position <= destination.position);
  end;
  $$ language plpgsql;

drop function if exists find_route_fewest_stops(int, int, varchar) cascade;
create function find_route_fewest_stops(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, counts integer) as
  $$
  begin
      return query
        select s.route_id, s.tid, s.time, (destination.stop - arrival.stop) as stop_counts
        from express_railway.schedules s
        join express_railway.legs arrival on s.route_id = arrival.route_id
        join express_railway.legs destination on s.route_id = destination.route_id
        where s.day = $3 and s.available_seats > 0
         and (arrival.sid = $1 and arrival.stop is not null )
         and (destination.sid = $2 and destination.stop is not null)
         and (arrival.position <= destination.position)
        order by stop_counts;
  end;
  $$ language plpgsql;

drop function if exists find_route_most_stations(int, int, varchar) cascade;
create function find_route_most_stations(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, counts integer) as
  $$
  begin
      return query
        select s.route_id, s.tid, s.time, (destination.position - arrival.position) as station_counts
        from express_railway.schedules s
        join express_railway.legs arrival on s.route_id = arrival.route_id
        join express_railway.legs destination on s.route_id = destination.route_id
        where s.day = $3 and s.available_seats > 0
         and (arrival.sid = $1 and arrival.stop is not null )
         and (destination.sid = $2 and destination.stop is not null)
         and (arrival.position <= destination.position)
        order by station_counts desc;
  end;
  $$ language plpgsql;

drop function if exists find_route_least_distance(int, int, varchar) cascade;
create function find_route_least_distance(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, distance integer) as
  $$
  begin
    return query
      select s.route_id, s.tid, s.time, get_distance(s.route_id, arrival.position, destination.position) as dist
      from express_railway.schedules s
      join express_railway.legs arrival on s.route_id = arrival.route_id
      join express_railway.legs destination on s.route_id = destination.route_id
      where s.day = $3 and s.available_seats > 0
       and (arrival.sid = $1 and arrival.stop is not null )
       and (destination.sid = $2 and destination.stop is not null)
       and (arrival.position <= destination.position)
      order by dist;
  end;
  $$ language plpgsql;

drop function if exists find_route_most_distance(int, int, varchar) cascade;
create function find_route_most_distance(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, distance integer) as
  $$
  begin
    return query
      select s.route_id, s.tid, s.time, get_distance(s.route_id, arrival.position, destination.position) as dist
      from express_railway.schedules s
      join express_railway.legs arrival on s.route_id = arrival.route_id
      join express_railway.legs destination on s.route_id = destination.route_id
      where s.day = $3 and s.available_seats > 0
       and (arrival.sid = $1 and arrival.stop is not null )
       and (destination.sid = $2 and destination.stop is not null)
       and (arrival.position <= destination.position)
      order by dist desc;
  end;
  $$ language plpgsql;

drop function if exists find_route_highest_price(int, int, varchar) cascade;
create function find_route_highest_price(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, price integer) as
  $$
  begin
    return query
      select s.route_id, s.tid, s.time,
             get_price(s.route_id, arrival.position, destination.position, s.tid) as price
      from express_railway.schedules s
      join express_railway.legs arrival on s.route_id = arrival.route_id
      join express_railway.legs destination on s.route_id = destination.route_id
      where s.day = $3 and s.available_seats > 0
       and (arrival.sid = $1 and arrival.stop is not null )
       and (destination.sid = $2 and destination.stop is not null)
       and (arrival.position <= destination.position)
      order by price desc;
  end;
  $$ language plpgsql;

drop function if exists find_route_lowest_price(int, int, varchar) cascade;
create function find_route_lowest_price(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, price integer) as
  $$
  begin
    return query
      select s.route_id, s.tid, s.time,
             get_price(s.route_id, arrival.position, destination.position, s.tid) as price
      from express_railway.schedules s
      join express_railway.legs arrival on s.route_id = arrival.route_id
      join express_railway.legs destination on s.route_id = destination.route_id
      where s.day = $3 and s.available_seats > 0
       and (arrival.sid = $1 and arrival.stop is not null )
       and (destination.sid = $2 and destination.stop is not null)
       and (arrival.position <= destination.position)
      order by price;
  end;
  $$ language plpgsql;

drop function if exists find_route_most_time(int, int, varchar) cascade;
create function find_route_most_time(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, travel_time interval) as
  $$
  begin
    return query
      select s.route_id, s.tid, s.time,
             get_time(s.route_id, arrival.position, destination.position, s.tid) as travel_time
      from express_railway.schedules s
      join express_railway.legs arrival on s.route_id = arrival.route_id
      join express_railway.legs destination on s.route_id = destination.route_id
      where s.day = $3 and s.available_seats > 0
       and (arrival.sid = $1 and arrival.stop is not null )
       and (destination.sid = $2 and destination.stop is not null)
       and (arrival.position <= destination.position)
      order by travel_time desc;
  end;
  $$ language plpgsql;

drop function if exists find_route_least_time(int, int, varchar) cascade;
create function find_route_least_time(sid1 int, sid2 int, target_day varchar)
returns table(route integer, train integer, t time, travel_time interval) as
  $$
  begin
    return query
      select s.route_id, s.tid, s.time,
             get_time(s.route_id, arrival.position, destination.position, s.tid) as travel_time
      from express_railway.schedules s
      join express_railway.legs arrival on s.route_id = arrival.route_id
      join express_railway.legs destination on s.route_id = destination.route_id
      where s.day = $3 and s.available_seats > 0
       and (arrival.sid = $1 and arrival.stop is not null )
       and (destination.sid = $2 and destination.stop is not null)
       and (arrival.position <= destination.position)
      order by travel_time;
  end;
  $$ language plpgsql;

-- route combo search
drop function if exists find_route_combo(int, int, varchar) cascade;
create function find_route_combo(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, transfer int, route2 integer, t2 time) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, t.transfer_station, pc.r2, pc.t2
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2);
  end;
  $$ language plpgsql;

drop function if exists find_combo_fewest_stops(int, int, varchar) cascade;
create function find_combo_fewest_stops(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, counts integer) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, (t.r1_stop - pc.r1_stop + pc.r2_stop - t.r2_stop) as counts
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by counts;
  end;
  $$ language plpgsql;

drop function if exists find_combo_most_stations(int, int, varchar) cascade;
create function find_combo_most_stations(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, counts integer) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, (t.r1_position - pc.p1 + pc.p2 - t.r2_position) as counts
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by counts desc;
  end;
  $$ language plpgsql;

drop function if exists find_combo_least_distance(int, int, varchar) cascade;
create function find_combo_least_distance(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, distance integer) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, get_distance(pc.r1, pc.p1, t.r1_position)
                                        + get_distance(pc.r2, t.r2_position, pc.p2) as dist
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by dist;
  end;
  $$ language plpgsql;

drop function if exists find_combo_most_distance(int, int, varchar) cascade;
create function find_combo_most_distance(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, distance integer) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, get_distance(pc.r1, pc.p1, t.r1_position)
                                        + get_distance(pc.r2, t.r2_position, pc.p2) as dist
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by dist desc;
  end;
  $$ language plpgsql;

drop function if exists find_combo_lowest_price(int, int, varchar) cascade;
create function find_combo_lowest_price(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, price integer) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, get_price(pc.r1, pc.p1, t.r1_position, pc.train1)
                                        + get_price(pc.r2, t.r2_position, pc.p2, pc.train2) as price
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by price;
  end;
  $$ language plpgsql;

drop function if exists find_combo_highest_price(int, int, varchar) cascade;
create function find_combo_highest_price(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, price integer) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, get_price(pc.r1, pc.p1, t.r1_position, pc.train1)
                                        + get_price(pc.r2, t.r2_position, pc.p2, pc.train2) as price
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by price desc;
  end;
  $$ language plpgsql;

drop function if exists find_combo_least_time(int, int, varchar) cascade;
create function find_combo_least_time(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, travel_time interval) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, get_time(pc.r1, pc.p1, t.r1_position, pc.train1)
                                        + get_time(pc.r2, t.r2_position, pc.p2, pc.train2) as travel_time
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by travel_time;
  end;
  $$ language plpgsql;

drop function if exists find_combo_most_time(int, int, varchar) cascade;
create function find_combo_most_time(sid1 int, sid2 int, target_day varchar)
returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, travel_time interval) as
  $$
  begin
    drop table if exists possible_combos;
    create temp table possible_combos on commit drop as
      select s1.route_id as r1, r1.position as p1, s1.time as t1, s1.tid as train1, r1.stop as r1_stop,
             s2.route_id as r2, r2.position as p2, s2.time as t2, s2.tid as train2, r2.stop as r2_stop
      from express_railway.schedules s1 join express_railway.legs r1 on s1.route_id = r1.route_id,
      express_railway.schedules s2 join express_railway.legs r2 on s2.route_id = r2.route_id
      where s1.day = $3 and s1.available_seats > 0 and r1.sid = $1 and r1.stop is not null
        and s2.day = $3 and s2.available_seats > 0 and r2.sid = $2 and r2.stop is not null
        and s1.route_id <> s2.route_id
        and s1.time < s2.time;

    return query
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2, get_time(pc.r1, pc.p1, t.r1_position, pc.train1)
                                        + get_time(pc.r2, t.r2_position, pc.p2, pc.train2) as travel_time
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2)
      order by travel_time desc;
  end;
  $$ language plpgsql;

/* *********************************
*  advanced query functions
 ***********************************/

-- train that pass through a specific station at a day/time
drop function if exists find_trains4station(integer, varchar, time) cascade;
create function find_trains4station(sid integer, day varchar, t time)
returns table(trains integer) as
  $$
  begin
    return query
      select s.tid from express_railway.schedules s
      where s.day = $2 and s.time = $3 and s.route_id in (
      select l.route_id from express_railway.legs l
      where l.sid = $1 and l.stop is not null);
  end;
$$ language plpgsql;

-- routes that have more than one rail line
drop function if exists find_routes_multi_railines() cascade;
create function find_routes_multi_railines()
returns table(route integer, rail_counts bigint) as
  $$
  begin
    return query
      select route_id, count(distinct rid) as rail_counts from express_railway.legs
      group by route_id
      order by rail_counts desc;
  end;
  $$ language plpgsql;

-- -- similar routes that have same stations but different stops
drop function if exists find_similar_routes() cascade;
create function find_similar_routes()
returns table(route1 integer, route2 integer) as
  $$
  declare
    id1 record;
    id2 record;
    unmatched_sid int;
    unmatched_stop int;
  begin
    for id1 in select * from express_railway.routes loop
      for id2 in select * from express_railway.routes loop
        if id2.route_id < id1.route_id
          then continue;
        end if;
        select count(*) into unmatched_sid from (
          select * from
            (select l.sid as r1_sid , l.stop as r1_stop from express_railway.legs l where l.route_id = id1.route_id) r1
            full outer join
            (select l.sid as r2_sid, l.stop as r2_stop from express_railway.legs l where l.route_id = id2.route_id) r2
            on r1.r1_sid = r2.r2_sid) r1r2
        where r1_sid is null or r2_sid is null;

        select count(*) into unmatched_stop from (
             select * from
            (select l.sid as r1_sid , l.stop as r1_stop from express_railway.legs l where l.route_id = id1.route_id) r1
            full outer join
            (select l.sid as r2_sid, l.stop as r2_stop from express_railway.legs l where l.route_id = id2.route_id) r2
            on r1.r1_sid = r2.r2_sid) r1r2
        where (r1_stop is not null and r2_stop is null) or (r1_stop is null and r2_stop is not null);

        if (unmatched_sid = 0 and unmatched_stop <> 0) then
          route1 := id1.route_id;
          route2 := id2.route_id;
          return next;
        else
          continue;
        end if;
      end loop;
    end loop;
  end;
  $$ language plpgsql;

-- stations that all train pass
drop function if exists find_stations_all_trains_pass() cascade;
create function find_stations_all_trains_pass()
returns table(sid integer, name varchar, open time, close time, street varchar, town varchar, postal char) as
  $$
  begin
    return query
      select * from express_railway.stations station
      where station.sid not in
            (select distinct l.sid from express_railway.schedules s
             join express_railway.legs l on s.route_id = l.route_id
             where l.stop is not null);
  end;
  $$ language plpgsql;

-- trains that do not pass the station
drop function if exists find_trains_not_pass(int) cascade;
create function find_trains_not_pass(sid int)
returns table(name varchar, desciption varchar) as
  $$
  begin
    return query
      select t.name, t.description from express_railway.trains t
      where tid not in
            (select distinct s.tid from express_railway.schedules s
             join express_railway.legs l on s.route_id = l.route_id
              where l.sid = $1 and l.stop is not null);
  end;
  $$ language plpgsql;

-- route that stops at least X% percent of the stations
drop function if exists find_routes_percent(int) cascade;
create function find_routes_percent(threshold int)
returns table(route integer, percent bigint) as
  $$
  begin
    return query
      select route_id, 100 * sum(case when stop is null then 0 else 1 end) / count(*) as percent
      from express_railway.legs
      group by route_id
      having 100 * sum(case when stop is null then 0 else 1 end) / count(*) > $1
      order by percent desc;
  end;
  $$ language plpgsql;

-- display route schedule
drop function if exists display_route_schedules(int) cascade;
create function display_route_schedules(route_id int)
returns table(train int, day varchar, t time) as
  $$
  begin
    return query
      select s.tid, s.day, s.time from express_railway.schedules s
      where s.route_id = $1;
  end;
  $$ language plpgsql;

-- find available seats
drop function if exists find_available_seats(int, varchar, time) cascade;
create function find_available_seats(route_id int, day varchar, t time)
returns table(train int, available_seats int) as
  $$
  begin
    return query
      select s.tid, s.available_seats from express_railway.schedules s
      where s.route_id = $1 and s.day = $2 and s.time = $3;
  end;
  $$ language plpgsql;
