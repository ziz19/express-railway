--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY express_railway.trips DROP CONSTRAINT IF EXISTS trips_pid_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.trails DROP CONSTRAINT IF EXISTS trails_sid_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.trails DROP CONSTRAINT IF EXISTS trails_rid_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.schedules DROP CONSTRAINT IF EXISTS schedules_tid_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.schedules DROP CONSTRAINT IF EXISTS schedules_route_id_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.legs DROP CONSTRAINT IF EXISTS legs_sid_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.legs DROP CONSTRAINT IF EXISTS legs_route_id_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.legs DROP CONSTRAINT IF EXISTS legs_rid_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.itinerary DROP CONSTRAINT IF EXISTS itinerary_trip_id_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.itinerary DROP CONSTRAINT IF EXISTS itinerary_tid_fkey;
ALTER TABLE IF EXISTS ONLY express_railway.itinerary DROP CONSTRAINT IF EXISTS itinerary_route_id_fkey;
DROP TRIGGER IF EXISTS add_reservation ON express_railway.itinerary;
ALTER TABLE IF EXISTS ONLY express_railway.trips DROP CONSTRAINT IF EXISTS trips_pkey;
ALTER TABLE IF EXISTS ONLY express_railway.trains DROP CONSTRAINT IF EXISTS trains_pkey;
ALTER TABLE IF EXISTS ONLY express_railway.trails DROP CONSTRAINT IF EXISTS trails_pk;
ALTER TABLE IF EXISTS ONLY express_railway.stations DROP CONSTRAINT IF EXISTS stations_pkey;
ALTER TABLE IF EXISTS ONLY express_railway.schedules DROP CONSTRAINT IF EXISTS schedules_pk;
ALTER TABLE IF EXISTS ONLY express_railway.routes DROP CONSTRAINT IF EXISTS routes_pkey;
ALTER TABLE IF EXISTS ONLY express_railway.rails DROP CONSTRAINT IF EXISTS rails_pkey;
ALTER TABLE IF EXISTS ONLY express_railway.legs DROP CONSTRAINT IF EXISTS paths_pk;
ALTER TABLE IF EXISTS ONLY express_railway.itinerary DROP CONSTRAINT IF EXISTS itinerary_pk;
ALTER TABLE IF EXISTS ONLY express_railway.customers DROP CONSTRAINT IF EXISTS customers_pkey;
ALTER TABLE IF EXISTS express_railway.trips ALTER COLUMN trip_id DROP DEFAULT;
ALTER TABLE IF EXISTS express_railway.itinerary ALTER COLUMN trip_id DROP DEFAULT;
DROP SEQUENCE IF EXISTS express_railway.trips_trip_id_seq;
DROP TABLE IF EXISTS express_railway.trips;
DROP TABLE IF EXISTS express_railway.trains;
DROP TABLE IF EXISTS express_railway.trails;
DROP TABLE IF EXISTS express_railway.stations;
DROP TABLE IF EXISTS express_railway.schedules;
DROP TABLE IF EXISTS express_railway.routes;
DROP TABLE IF EXISTS express_railway.rails;
DROP TABLE IF EXISTS express_railway.legs;
DROP SEQUENCE IF EXISTS express_railway.itinerary_trip_id_seq;
DROP TABLE IF EXISTS express_railway.itinerary;
DROP TABLE IF EXISTS express_railway.customers;
DROP FUNCTION IF EXISTS public.view_customer(id integer);
DROP FUNCTION IF EXISTS public.update_seats();
DROP FUNCTION IF EXISTS public.time_addition(t double precision);
DROP FUNCTION IF EXISTS public.reserve_route(pid integer, route_id integer, day character varying);
DROP FUNCTION IF EXISTS public.increase_n(num integer, n integer);
DROP FUNCTION IF EXISTS public.get_transfer_table();
DROP FUNCTION IF EXISTS public.get_time(route integer, start_position integer, end_position integer, train_id integer);
DROP FUNCTION IF EXISTS public.get_price(route integer, start_position integer, end_position integer, train_id integer);
DROP FUNCTION IF EXISTS public.get_distance(route integer, start_position integer, end_position integer);
DROP FUNCTION IF EXISTS public.find_trains_not_pass(sid integer);
DROP FUNCTION IF EXISTS public.find_trains4station(sid integer, day character varying, t time without time zone);
DROP FUNCTION IF EXISTS public.find_stations_all_trains_pass();
DROP FUNCTION IF EXISTS public.find_single_route(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_similar_routes();
DROP FUNCTION IF EXISTS public.find_routes_percent(threshold integer);
DROP FUNCTION IF EXISTS public.find_routes_multi_railines();
DROP FUNCTION IF EXISTS public.find_route_most_time(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_most_stations(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_most_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_lowest_price(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_lowest_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_least_time(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_least_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_highest_price(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_highest_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_fewest_stops(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_route_combo(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_most_time(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_most_stations(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_most_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_lowest_price(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_lowest_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_least_time(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_least_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_highest_price(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_highest_distance(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_combo_fewest_stops(sid1 integer, sid2 integer, target_day character varying);
DROP FUNCTION IF EXISTS public.find_available_seats(route_id integer, day character varying, t time without time zone);
DROP FUNCTION IF EXISTS public.edit_customer(id integer, fname character varying, lname character varying, street character varying, town character varying, postal character);
DROP FUNCTION IF EXISTS public.display_route_schedules(route_id integer);
DROP FUNCTION IF EXISTS public.add_customer(fname character varying, lname character varying, street character varying, town character varying, postal character);
DROP SCHEMA IF EXISTS express_railway;
--
-- Name: express_railway; Type: SCHEMA; Schema: -; Owner: zinan
--

CREATE SCHEMA express_railway;


ALTER SCHEMA express_railway OWNER TO zinan;

--
-- Name: add_customer(character varying, character varying, character varying, character varying, character); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.add_customer(fname character varying, lname character varying, street character varying, town character varying, postal character) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
  declare
    max_id int;
  begin
    select max(pid) into max_id from express_railway.customers;
    insert into express_railway.customers VALUES(max_id + 1, $1, $2, $3, $4, $5);
    return max_id + 1;
  end
  $_$;


ALTER FUNCTION public.add_customer(fname character varying, lname character varying, street character varying, town character varying, postal character) OWNER TO zinan;

--
-- Name: display_route_schedules(integer); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.display_route_schedules(route_id integer) RETURNS TABLE(train integer, day character varying, t time without time zone)
    LANGUAGE plpgsql
    AS $_$
  begin
    return query
      select s.tid, s.day, s.time from express_railway.schedules s
      where s.route_id = $1;
  end;
  $_$;


ALTER FUNCTION public.display_route_schedules(route_id integer) OWNER TO zinan;

--
-- Name: edit_customer(integer, character varying, character varying, character varying, character varying, character); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.edit_customer(id integer, fname character varying, lname character varying, street character varying, town character varying, postal character) RETURNS record
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.edit_customer(id integer, fname character varying, lname character varying, street character varying, town character varying, postal character) OWNER TO zinan;

--
-- Name: find_available_seats(integer, character varying, time without time zone); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_available_seats(route_id integer, day character varying, t time without time zone) RETURNS TABLE(train integer, available_seats integer)
    LANGUAGE plpgsql
    AS $_$
  begin
    return query
      select s.tid, s.available_seats from express_railway.schedules s
      where s.route_id = $1 and s.day = $2 and s.time = $3;
  end;
  $_$;


ALTER FUNCTION public.find_available_seats(route_id integer, day character varying, t time without time zone) OWNER TO zinan;

--
-- Name: find_combo_fewest_stops(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_fewest_stops(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, counts integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_fewest_stops(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_combo_highest_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_combo_highest_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_highest_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO postgres;

--
-- Name: find_combo_highest_price(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_highest_price(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_highest_price(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_combo_least_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_least_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, distance integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_least_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_combo_least_time(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_least_time(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, travel_time interval)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_least_time(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_combo_lowest_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_combo_lowest_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_lowest_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO postgres;

--
-- Name: find_combo_lowest_price(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_lowest_price(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_lowest_price(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_combo_most_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_most_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, distance integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_most_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_combo_most_stations(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_most_stations(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, counts integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_most_stations(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_combo_most_time(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_combo_most_time(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer, travel_time interval)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_combo_most_time(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_combo(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_combo(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route1 integer, t1 time without time zone, train1 integer, transfer integer, route2 integer, t2 time without time zone, train2 integer)
    LANGUAGE plpgsql
    AS $_$
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
      select pc.r1, pc.t1, pc.train1, t.transfer_station,
             pc.r2, pc.t2, pc.train2
      from possible_combos pc join get_transfer_table() t on pc.r1 = t.r1 and pc.r2 = t.r2
      where pc.p1 < t.r1_position and pc.p2 > t.r2_position
        and pc.t1 + get_time(pc.r1, 0, t.r1_position, pc.train1)
              < pc.t2 + get_time(pc.r2, 0, t.r2_position, pc.train2);
  end;
  $_$;


ALTER FUNCTION public.find_route_combo(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_fewest_stops(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_fewest_stops(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, counts integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_fewest_stops(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_highest_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_route_highest_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_highest_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO postgres;

--
-- Name: find_route_highest_price(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_highest_price(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_highest_price(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_least_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_least_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, distance integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_least_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_least_time(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_least_time(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, travel_time interval)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_least_time(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_lowest_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_route_lowest_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_lowest_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO postgres;

--
-- Name: find_route_lowest_price(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_lowest_price(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, price integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_lowest_price(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_most_distance(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_most_distance(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, distance integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_most_distance(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_most_stations(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_most_stations(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, counts integer)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_most_stations(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_route_most_time(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_route_most_time(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone, travel_time interval)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_route_most_time(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_routes_multi_railines(); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_routes_multi_railines() RETURNS TABLE(route integer, rail_counts bigint)
    LANGUAGE plpgsql
    AS $$
  begin
    return query
      select route_id, count(distinct rid) as rail_counts from express_railway.legs
      group by route_id
      order by rail_counts desc;
  end;
  $$;


ALTER FUNCTION public.find_routes_multi_railines() OWNER TO zinan;

--
-- Name: find_routes_percent(integer); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_routes_percent(threshold integer) RETURNS TABLE(route integer, percent bigint)
    LANGUAGE plpgsql
    AS $_$
  begin
    return query
      select route_id, 100 * sum(case when stop is null then 0 else 1 end) / count(*) as percent
      from express_railway.legs
      group by route_id
      having 100 * sum(case when stop is null then 0 else 1 end) / count(*) > $1
      order by percent desc;
  end;
  $_$;


ALTER FUNCTION public.find_routes_percent(threshold integer) OWNER TO zinan;

--
-- Name: find_similar_routes(); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_similar_routes() RETURNS TABLE(route1 integer, route2 integer)
    LANGUAGE plpgsql
    AS $$
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
  $$;


ALTER FUNCTION public.find_similar_routes() OWNER TO zinan;

--
-- Name: find_single_route(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_single_route(sid1 integer, sid2 integer, target_day character varying) RETURNS TABLE(route integer, train integer, t time without time zone)
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.find_single_route(sid1 integer, sid2 integer, target_day character varying) OWNER TO zinan;

--
-- Name: find_stations_all_trains_pass(); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_stations_all_trains_pass() RETURNS TABLE(sid integer, name character varying, open time without time zone, close time without time zone, street character varying, town character varying, postal character)
    LANGUAGE plpgsql
    AS $$
  begin
    return query
      select * from express_railway.stations station
      where station.sid not in
            (select distinct l.sid from express_railway.schedules s
             join express_railway.legs l on s.route_id = l.route_id
             where l.stop is not null);
  end;
  $$;


ALTER FUNCTION public.find_stations_all_trains_pass() OWNER TO zinan;

--
-- Name: find_trains4station(integer, character varying, time without time zone); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_trains4station(sid integer, day character varying, t time without time zone) RETURNS TABLE(trains integer)
    LANGUAGE plpgsql
    AS $_$
  begin
    return query
      select s.tid from express_railway.schedules s
      where s.day = $2 and s.time = $3 and s.route_id in (
      select l.route_id from express_railway.legs l
      where l.sid = $1 and l.stop is not null);
  end;
$_$;


ALTER FUNCTION public.find_trains4station(sid integer, day character varying, t time without time zone) OWNER TO zinan;

--
-- Name: find_trains_not_pass(integer); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.find_trains_not_pass(sid integer) RETURNS TABLE(train integer, name character varying, desciption character varying)
    LANGUAGE plpgsql
    AS $_$
  begin
    return query
      select t.tid, t.name, t.description from express_railway.trains t
      where tid not in
            (select distinct s.tid from express_railway.schedules s
             join express_railway.legs l on s.route_id = l.route_id
              where l.sid = $1 and l.stop is not null);
  end;
  $_$;


ALTER FUNCTION public.find_trains_not_pass(sid integer) OWNER TO zinan;

--
-- Name: get_distance(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.get_distance(route integer, start_position integer, end_position integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.get_distance(route integer, start_position integer, end_position integer) OWNER TO zinan;

--
-- Name: get_price(integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.get_price(route integer, start_position integer, end_position integer, train_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
  declare
    unit_price float;
  begin
    select t.cost_km into unit_price from express_railway.trains t where t.tid = $4;
    return unit_price * get_distance($1, $2, $3);
  end;
  $_$;


ALTER FUNCTION public.get_price(route integer, start_position integer, end_position integer, train_id integer) OWNER TO zinan;

--
-- Name: get_time(integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.get_time(route integer, start_position integer, end_position integer, train_id integer) RETURNS interval
    LANGUAGE plpgsql
    AS $_$
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
  $_$;


ALTER FUNCTION public.get_time(route integer, start_position integer, end_position integer, train_id integer) OWNER TO zinan;

--
-- Name: get_transfer_table(); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.get_transfer_table() RETURNS TABLE(r1 integer, r2 integer, transfer_station integer, r1_position integer, r2_position integer, r1_stop integer, r2_stop integer)
    LANGUAGE plpgsql
    AS $$
  begin
    return query
      select r1.route_id, r2.route_id, transfer.sid, r1.position, r2.position, r1.stop, r2.stop
      from express_railway.stations transfer
        join express_railway.legs r1 on transfer.sid = r1.sid
        join express_railway.legs r2 on transfer.sid = r2.sid
      where r1.route_id <> r2.route_id and r1.stop is not null and r2.stop is not null
      order by r1.route_id, r2.route_id, transfer.sid;
  end;
  $$;


ALTER FUNCTION public.get_transfer_table() OWNER TO zinan;

--
-- Name: increase_n(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.increase_n(num integer, n integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
  begin
    return num + n;
  end;
  $$;


ALTER FUNCTION public.increase_n(num integer, n integer) OWNER TO postgres;

--
-- Name: reserve_route(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.reserve_route(pid integer, route_id integer, day character varying) RETURNS TABLE(trip integer, t time without time zone, train integer)
    LANGUAGE plpgsql
    AS $_$
  begin
    select s.tid, s.time into train, t from express_railway.schedules s
    where s.route_id = $2 and s.day = $3 and s.available_seats > 0 limit 1;
    insert into express_railway.trips(pid) VALUES($1) returning trip_id into trip;
    insert into express_railway.itinerary VALUES(trip, $2, train, $3, t);
    return next;
  end;
  $_$;


ALTER FUNCTION public.reserve_route(pid integer, route_id integer, day character varying) OWNER TO zinan;

--
-- Name: time_addition(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.time_addition(t double precision) RETURNS time without time zone
    LANGUAGE plpgsql
    AS $_$
  declare
    base time;
  begin
    base := '02:30';
    return base + $1::varchar::interval;
  end;
  $_$;


ALTER FUNCTION public.time_addition(t double precision) OWNER TO postgres;

--
-- Name: update_seats(); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.update_seats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  begin
    update express_railway.schedules
    set available_seats = available_seats - 1
    where route_id = new.route_id and tid = new.tid and day = new.day and time = new.time;
    return new;
  end;
  $$;


ALTER FUNCTION public.update_seats() OWNER TO zinan;

--
-- Name: view_customer(integer); Type: FUNCTION; Schema: public; Owner: zinan
--

CREATE FUNCTION public.view_customer(id integer) RETURNS record
    LANGUAGE plpgsql
    AS $_$
  declare
    profile record;
  begin
    select fname, lname, street, town, postal into profile from express_railway.customers where pid = $1;
    return profile;
  end
  $_$;


ALTER FUNCTION public.view_customer(id integer) OWNER TO zinan;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: customers; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.customers (
    pid integer NOT NULL,
    fname character varying(20),
    lname character varying(20),
    street character varying(255),
    town character varying(255),
    postal character(13)
);


ALTER TABLE express_railway.customers OWNER TO zinan;

--
-- Name: itinerary; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.itinerary (
    trip_id integer NOT NULL,
    route_id integer NOT NULL,
    tid integer,
    day character varying(10) NOT NULL,
    "time" time without time zone
);


ALTER TABLE express_railway.itinerary OWNER TO zinan;

--
-- Name: itinerary_trip_id_seq; Type: SEQUENCE; Schema: express_railway; Owner: zinan
--

CREATE SEQUENCE express_railway.itinerary_trip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE express_railway.itinerary_trip_id_seq OWNER TO zinan;

--
-- Name: itinerary_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: express_railway; Owner: zinan
--

ALTER SEQUENCE express_railway.itinerary_trip_id_seq OWNED BY express_railway.itinerary.trip_id;


--
-- Name: legs; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.legs (
    route_id integer NOT NULL,
    rid integer NOT NULL,
    sid integer NOT NULL,
    "position" integer,
    stop integer
);


ALTER TABLE express_railway.legs OWNER TO zinan;

--
-- Name: rails; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.rails (
    rid integer NOT NULL,
    speed_limit integer
);


ALTER TABLE express_railway.rails OWNER TO zinan;

--
-- Name: routes; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.routes (
    route_id integer NOT NULL
);


ALTER TABLE express_railway.routes OWNER TO zinan;

--
-- Name: schedules; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.schedules (
    route_id integer NOT NULL,
    tid integer NOT NULL,
    day character varying(10) NOT NULL,
    "time" time without time zone NOT NULL,
    available_seats integer
);


ALTER TABLE express_railway.schedules OWNER TO zinan;

--
-- Name: stations; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.stations (
    sid integer NOT NULL,
    name character varying(50),
    open_hour time without time zone,
    close_hour time without time zone,
    street character varying(255),
    town character varying(255),
    postal character(13)
);


ALTER TABLE express_railway.stations OWNER TO zinan;

--
-- Name: trails; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.trails (
    rid integer NOT NULL,
    sid integer NOT NULL,
    "position" integer,
    distance integer
);


ALTER TABLE express_railway.trails OWNER TO zinan;

--
-- Name: trains; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.trains (
    tid integer NOT NULL,
    name character varying(50),
    description character varying(255),
    speed_kmh integer,
    seats integer,
    cost_km double precision
);


ALTER TABLE express_railway.trains OWNER TO zinan;

--
-- Name: trips; Type: TABLE; Schema: express_railway; Owner: zinan
--

CREATE TABLE express_railway.trips (
    trip_id integer NOT NULL,
    pid integer
);


ALTER TABLE express_railway.trips OWNER TO zinan;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE; Schema: express_railway; Owner: zinan
--

CREATE SEQUENCE express_railway.trips_trip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE express_railway.trips_trip_id_seq OWNER TO zinan;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: express_railway; Owner: zinan
--

ALTER SEQUENCE express_railway.trips_trip_id_seq OWNED BY express_railway.trips.trip_id;


--
-- Name: itinerary trip_id; Type: DEFAULT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.itinerary ALTER COLUMN trip_id SET DEFAULT nextval('express_railway.itinerary_trip_id_seq'::regclass);


--
-- Name: trips trip_id; Type: DEFAULT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.trips ALTER COLUMN trip_id SET DEFAULT nextval('express_railway.trips_trip_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.customers (pid, fname, lname, street, town, postal) FROM stdin;
100706	Janise	Heard	1734 la Mancia	San Antonio	TX 78258-4547
105518	Iakovos	Abdo	430 Broad Street	Bloomfield	NJ 07003-2779
106550	Fulk	Mullice	1018 Adams Ave, Apt 3C	Salisbury	MD 21804-6687
107280	Archilai	Roden	387 Woodville Hwy	Crawfordville	FL 32327-0608
109529	Lettice 	Corner	6414 Magnum Ln	Knoxville	TN 37918-4038
116645	Annita	Eisenhart	1901 Kylemore Dr	Greensboro	NC 27406-6440
117609	Lucy 	Chadder	971 Terrace Lake Dr	Aurora	IL 60504-8978
122879	Alice 	Chave	14950 W Mountain View Blvd	Surprise	AZ 85374-4700
122958	Felix	Edwards	4106 Tucson Dr	Greensboro	NC 27406-6333
124641	Lawrence	Munro	806 Ridgeway St	Marianna	AR 72360-1511
130405	Gayla	Clouse	4584 Crump Rd	Memphis	TN 38141-7640
135327	Janise	Andrews	300 Broadacres Drive	Bloomfield	NJ 07003-3153
135620	Ivy	Haycraft	63315 Chalwain Rd	Saint Ignatius	MT 59865-9017
141417	Ebulus	Rice	2531 S Limestone St	Springfield	OH 45505-4937
148442	Lucy 	Morcombe	736 S White Horse Pike	Audubon	NJ 08106-1346
149413	Ebulus	Puddicombe	3316 Trappers Cove Trl, Apt 2A	Lansing	MI 48910-8242
150155	Dionise 	Mudge	7742 14th St, Apt 2	Westminster	CA 92683-4402
152654	Jasper	Pulsford	6801 Northlake Mall Dr, Ste 19	Charlotte	NC 28216-0750
153043	Manie	Aaron	1201 S Ervay St	Dallas	TX 75215-1124
153784	Donnie	Cusack	310 Laurie Lynn Dr	Baton Rouge	LA 70819-3435
154871	Daysi	Williams	3517 Ellery Cir	Falls Church	VA 22041-3052
154954	Arthur	Williams	115 Keymar Dr	York	PA 17402-9552
155904	Cornelius	Puddicombe	4411 Gardendale St	San Antonio	TX 78240-1194
156573	Janise	Corner	26620 Beltrees Rd	Godfrey	IL 62035-3615
157253	Francene	Richards	3234 S Semoran Blvd, Apt 22	Orlando	FL 32822-2743
157661	Goughe	Kyle	612 Flatbush Ave	Brooklyn	NY 11225-4955
158824	Marinda	Dials	2900 E Lincoln Ave	Anaheim	CA 92806-4043
159102	Jocatta 	Aplin	550 Belmont St	Watertown	MA 02472-4910
161406	Jesper	Bodley	12314 Ashford Place Dr	Sugar Land	TX 77478-6180
162020	Janel	Cerniglia	365 Pineapple St	Englewood	FL 34223-2835
168791	Josias	Fowler	1043 Bergen Blvd	Fort Lee	NJ 07024-1656
168919	Dorothy 	Jones	1055 N Capitol Ave, Apt 161	San Jose	CA 95133-2729
170063	Jesse	Ackrell	4210 NE Seventh St	Renton	WA 98059-4746
173546	Freeman	Georges	4210 Fowler St	Fort Myers	FL 33901-2619
175192	Phillip	Glinn	10708 Kings Riding Way	Rockville	MD 20852-5409
178769	Freeman	Drake	5441 Western Ave, Ste 2	Boulder	CO 80301-2733
183370	Charlie	Luscombe	7541 Clementine Dr	Corona	CA 92880-9019
184411	Nestor	Flom	42473 Magellan Sq	Ashburn	VA 20148-5608
186584	Eduardo	Kawasaki	8612 76th St	Woodhaven	NY 11421-1031
195859	Lawrence	Farquharson	201 Railroad Ave	East Rutherford	NJ 07073-1943
197785	Beatrice 	Oates	57 W Church St	Selbyville	DE 19975     
198917	Margarete	Chapman	4115 Hale Ln	Island Lake	IL 60042-8200
199120	Ebulus	Neck	156 Mineola Boulevard	Mineola	NY 11501-3937
200082	Alexander	Chubb	3000 E Las Hermanas St	Compton	CA 90221-5511
203489	Keiko	Stlawrence	10309 Owen Brown Rd	Columbia	MD 21044-3833
205628	Colin	Stlawrence	134 Grove St	Chelsea	MA 02150-3317
218041	Freeman	Fines	7723 Frederick Rd	Hyattsville	MD 20784-1721
218571	Sarah 	Mudge	661 Clifton Park Ctr Rd	Clifton Park	NY 12065-1618
222727	Kristof	Bulley	112 Broad Street	Bloomfield	NJ 07003-2576
222938	Christa	Wilsey	1628 Fairway Dr	Johnson City	TN 37601-2614
223641	Arthur	Neck	520 Fourth Ave SW	Great Falls	MT 59404-2932
223984	Mikel	Swedberg	868 S Main St	Hollsopple	PA 15935-7014
228034	Shawanda	Georges	44 Steve Carmichael Rd	Hemingway	SC 29554-6157
231358	Lettice 	Waldeck	1456 Andrews Ln	East Meadow	NY 11554-3622
234315	Archilai	Stoneman	14981 Swenson St	San Leandro	CA 94579-1743
234385	Cyndi	Arroyo	2752 Kollmar Dr	San Jose	CA 95127-4062
244640	Margarete	Hymes	14057 Arthur Ave	Paramount	CA 90723-2207
247608	Sybil 	Grace	211 New Market Rd E	Immokalee	FL 34142-3506
251468	Sarah 	Shopland	25 South Raymond Avenue	Alhambra	CA 91801-3128
255794	Artie	Bennallack	16731 SE 49th St	Bellevue	WA 98006-5867
255864	Brian	Crook	310 Beecher Ave	Toledo	OH 43615-5704
257017	Marica	Soldner	185 Willis Avenue Suite 6	Mineola	NY 11501-2640
257547	Ginny	Ghee	371 Channelside Walk Way	Tampa	FL 33602-6766
257837	Charlie	Yeo	10 Wall St	Burlington	MA 01803-4749
257936	Jocatta 	Tolman	5808 Toebbe Ln	Louisville	KY 40229-1363
258977	Dagmar	May	1303 W Grant St	Phoenix	AZ 85007-3412
263685	Mable 	Pulsford	242 Hampden Ave	Narberth	PA 19072-1910
277702	Bartholomew	Wadham	32 Stovel Cir	Colorado Springs	CO 80916-4704
285052	Cornelius	Truscott	2846 Lebanon Pike	Nashville	TN 37214-2519
285268	Bevil	Oates	15251 Nordhoff St	North Hills	CA 91343-2249
285734	Zacharias	Daw	346 Charlton St	Southbridge	MA 01550-1356
286188	Jasper	Hatherly	3050 Bristol St	Costa Mesa	CA 92626-3036
291096	Jude	Heilig	10 W 33rd St, Rm 1221	New York	NY 10001-3306
291700	Agnes	Pawley	52 Stanford Rd E	Pennington	NJ 08534-5107
292689	Alice 	Sherard	28 Milford St	Medway	MA 02053-1631
295522	Williams	Wittle	1803 S Eighth St	Rogers	AR 72756-5912
303752	Alexander	Sherard	1017 Murray Dr	Santa Maria	CA 93454-5512
304281	Carola	Mudge	13702 Maplerow Ave	Garfield Heights	OH 44105-6804
307402	Dagmar	Abdo	2510 E Arkansas Ln, Ste 114	Arlington	TX 76014-1746
311792	Keiko	Meadows	2250 Jewel St	Longmont	CO 80501-1219
314062	Kristof	Daw	5419 N Fairhill St	Philadelphia	PA 19120-2710
315181	Nestor	Bento	102 Robinson St, Apt 2	Woonsocket	RI 02895-2154
318586	Diricus	Lawday	55 Washington Street	Bloomfield	NJ 07003-2483
321427	Jocatta 	Williams	4 Prescott Ave	Dix Hills	NY 11746-6925
321938	Francisco	Lipe	1 West Street	Mineola	NY 11501-4813
323221	Bobbi	Abdo	10824 Roycroft St, Apt 204	Sun Valley	CA 91352-1601
323672	Dagmar	Sherard	4840 Eastern Ave NE	Washington	DC 20017-3129
325499	Sherie	Waldeck	1224 W Historic Mitchell St	Milwaukee	WI 53204-3329
328140	Felipa	Parkes	1354 Waukegan Rd	Northbrook	IL 60062-4680
328869	Silvio	Bennallack	12812 Garden Grove Blvd, Ste I	Garden Grove	CA 92843-2009
329120	Lucas	Norrish	3135 Park Ave, Apt 13M	Bronx	NY 10451-4070
329752	Mable 	Georges	383 E Dunstable Rd	Nashua	NH 03062-4216
331686	Odell	Dunigan	2711 Grants Lake Blvd	Sugar Land	TX 77479-1378
333650	Henry	Clouse	9436 Highway 5	Douglasville	GA 30135-1510
335688	Lucas	Brooks	8407 Kearsarge Dr	Austin	TX 78745-7647
341633	Jeremy	Hocking	1201 Boynton Dr	Chattanooga	TN 37402-2144
342612	Stefanos	Bowden	1119 Burr St	Lake In The Hills	IL 60156-1122
344118	Daysi	Eisenhart	1250 Omega Circle Dr	Dekalb	IL 60115-5834
344729	Daniel	Down	130 E 18th St	New York	NY 10003-2416
348174	Bobbi	Stevens	2739 Westerwood Village Dr	Charlotte	NC 28214-2563
364091	Elsie	Gidley	5610 Old Fayetteville Rd	Sylacauga	AL 35151-4801
371633	Diricus	Tovar	3711 E Birchwood Ave	Cudahy	WI 53110-2703
377284	Gartheride 	Newcombe	2200 Oneida St	Joliet	IL 60435-6578
379471	Fulk	Daw	9473 SW 76th St	Miami	FL 33173-3366
379933	Dionisis	Holmes	1409 W Main St	Oklahoma City	OK 73106-5225
380037	Janise	Hanscom	6320 Boca Del Mar Dr	Boca Raton	FL 33433-5735
381855	Rees	Mcdowell	8448 Mayhews Landing Rd	Newark	CA 94560-2761
384504	Mikel	Stlawrence	74 Elm St	Potsdam	NY 13676-1813
392206	Keiko	Lamswood	1029 Georgetown Rd	Norfolk	VA 23502-2706
394992	Ely	Mcilrath	700 County Road 630a	Frostproof	FL 33843-9338
401762	Prudence 	Brooks	373 Tamarack Trl	Farmington	MN 55024-7119
402408	Kristof	Richards	7475 N First St, Ste 101	Fresno	CA 93720-2849
419890	Anchor	Slee	9225 Mira Mesa Blvd, Ste 103	San Diego	CA 92126-4810
420498	Agnes	Glatz	600 Laskin Rd	Virginia Beach	VA 23451-3976
424440	Bevil	Hodge	6301 Forbes Ave, Ste 301	Pittsburgh	PA 15217-1725
435289	Alexander	Drake	805 Johnston St	Greenville	NC 27858-2420
437115	Elinor	Farquharson	58 Madison Ave	Perth Amboy	NJ 08861-4623
438245	Helena	Yeo	80 2nd Street	Mineola	NY 11501-3008
438818	Mable 	Lipe	145 Jacks Mountain Rd	Mc Veytown	PA 17051-8003
440290	Gayla	Clardy	3170 S Jasmine Way	Denver	CO 80222-7628
444555	Jesse	Curtiss	13900 Tahiti Way	Marina Del Rey	CA 90292-6586
446054	Benedict	Clouse	24 Allentown Rd	Souderton	PA 18964-2228
447596	Winifred 	Jones	1000 Post Rd	Scarsdale	NY 10583-4301
450309	Brian	Parkes	429 Second Ave	New York	NY 10010-3101
451530	Julieann	Farquharson	102 E Johnson St	Cary	NC 27513-4615
457280	Elsie	Satchwill	3880 Rib Mountain Dr	Wausau	WI 54401-7482
457873	Cyndi	Shibley	3219 Granada St	Los Angeles	CA 90065-1701
460471	Gartheride 	Mudge	9 Circle High Dr	Little Rock	AR 72207-5130
461294	Anchor	Luscombe	2053 N Berendo St	Los Angeles	CA 90027-1906
462408	Anchor	Puddicombe	903 Remington Rd	Wynnewood	PA 19096-1606
463297	Florence 	Stevens	3536 Oakdale Rd	Modesto	CA 95357-0724
467052	Cuthbert	Bazley	6910 Melba Ave	West Hills	CA 91307-2413
468307	Lucas	Shibley	81 Grand St	Albany	NY 12202-1769
470064	Sibill	Diment	35746 Haley St	Newark	CA 94560-1161
472130	Elinor	Lovering	1108 West Valley Boulevard Sui	Alhambra	CA 91803-2479
472903	Dorotha	Bomgardner	1020 Thompson Pl	Nashville	TN 37217-1837
477363	Carola	Wardell	1607 Stoddard St	Rockford	IL 61108-6422
478219	Williams	Pawley	1603 Oneida St	Utica	NY 13501-4701
481687	Francisco	Mullice	6410 W Jefferson Blvd	Fort Wayne	IN 46804-6285
484755	Winifred 	Aplin	2006 Larkhall Rd	Dundalk	MD 21222-5605
485824	Miltiadis	Mullice	1906 Brassie Dr	Saint Louis	MO 63114-5730
495328	Sibill	Jillard	927 Hilton Rd	Ferndale	MI 48220-2522
496222	Arthur	Kyle	19319 Chamblee Ave	Cerritos	CA 90703-6750
496638	Marinda	Bowden	200 S Laurel Ave	Middletown	NJ 07748-1914
497952	Shanae	Waldeck	3 N 16th St, Apt 3E	Harrisburg	PA 17103-2352
504766	Lan	Rine	969 Patrick Henry Dr	Arlington	VA 22205-1457
504908	Ely	Knight	96 Notre Dame Dr	Vacaville	CA 95687     
506197	Denton	Puddicombe	1801 S Main St	Findlay	OH 45840-1324
509377	Winefred	Savage	PO Box 837	Patagonia	AZ 85624-0837
513185	Francene	Munro	410 Gardenia Ln	Buffalo Grove	IL 60089-1661
518881	Elsie	Shibley	2255 Satellite Blvd, Apt F103	Duluth	GA 30097-6226
521244	Eduardo	Sherard	820 South Garfield Avenue	Alhambra	CA 91801-5838
523254	Augustin	Shirley	505 Warwick Dr	Venice	FL 34293-4221
525830	Donetta	Rebelo	1524 NW 23rd Ave	Portland	OR 97210-2686
529612	Christa	Puddicombe	16501 Jamaica Ave	Jamaica	NY 11432-4900
538248	Kristof	Clardy	6333 Canoga Ave, Apt 119	Woodland Hills	CA 91367-7709
545067	Chet	Jillard	1760 E Horseshoe Ct	Gilbert	AZ 85296-2009
546499	Ellis	Collins	405 Fall Creek D	Richardson	TX 75080-2508
549007	Lucy 	Satchwill	2454 S Conway Rd	Orlando	FL 32812-456 
558488	Chet	Rice	1700 W New Haven Ave	Melbourne	FL 32904-3919
565899	Cyndi	Wardell	38778 Stonington Ter	Fremont	CA 94536-4278
572127	Zana	Reny	353 Pierpont Ave	Salt Lake City	UT 84101-1712
572825	Enoch	Heard	8025 Sierra Largo Dr	Las Vegas	NV 89128-7999
572874	Thomasina 	Luscombe	10477 Main St	New Middletown	OH 44442-8761
577715	Charlie	Curtiss	156 Willis Avenue	Mineola	NY 11501-2615
580793	Tory	Flom	2317 Dickens Ave	Charlotte	NC 28208-381 
584592	Carola	Haycraft	1721 Tacoma Ave	Berkeley	CA 94707-1828
585093	Erasmus	Glover	149 Watchung Ave	Montclair	NJ 07043-1712
593226	Mikel	Fowler	5031 N Lyman Ave	Covina	CA 91724-1328
596674	Colin	Chapman	2832 Amerson Way	Ellenwood	GA 30294-3833
600940	Brian	Little	315 N Ferry St	Ludington	MI 49431-1612
604003	Margerie	Seccombe	142 Willis Avenue	Mineola	NY 11501-2625
608505	Sherie	Swedberg	PO Box 1322	Saint Charles	IL 60174-7322
608911	Lawrence	Lopp	599 Bloomfield Avenue	Bloomfield	NJ 07003-2502
610039	Cuthbert	Hatherly	8423 Washington Blvd	Pico Rivera	CA 90660-3767
610605	Beatrice 	Gidley	1197 Lanier Blvd NE	Atlanta	GA 30306-3567
613472	Archilai	Puddicombe	999 E Valley Blvd	Alhambra	CA 91801-0900
613811	Donnie	Shopland	24881 Chernick St	Taylor	MI 48180-2113
614832	Odell	Pulsford	17878 Preston Rd	Dallas	TX 75252-5600
615656	Cher	Tovar	423 N Cleveland St	Arlington	VA 22201-1423
623809	Maria	Down	12401 W Okeechobee Rd	Hialeah	FL 33018-2924
624140	Ghislaine	Curtiss	565 Atlanta South Pkwy	Atlanta	GA 30349-5958
627040	Tabetha	Fuhrman	7540 Edinborough Way	Minneapolis	MN 55435-4770
628158	Thomasina 	Lamswood	726 South Garfield Avenue	Alhambra	CA 91801-4437
634935	Jeremy	Newcombe	6901 Valley Ave	Philadelphia	PA 19128-1545
636698	Felipa	Arroyo	1241 S New Ave	Springfield	MO 65807-1350
640925	Chet	Stebbins	6991 Petten Curv	Memphis	TN 38133-4878
642924	Lettice 	Couch	PO Box 320	Kahuku	HI 96731-0320
643578	Stefanos	Haycraft	2905 Aetna Way	San Jose	CA 95121-2304
647761	Dionisis	Williams	7225 Bellerive Dr	Houston	TX 77036-3100
647877	Dorotha	Wills	6258 Amesbury St	San Diego	CA 92114-6717
653407	Cornelius	Wills	1598 Rockville Pike	Rockville	MD 20852-5606
655384	Larry	Ferreira	24000 Edgehill Dr	Beachwood	OH 44122-1228
655563	Hellen	Bazley	100 East 2nd Street	Mineola	NY 11501-3502
657307	Georgette 	Jones	3309 Hazelwood Ave	Downingtown	PA 19335-2026
658649	Ely	Norrish	4600 Richmond Ave	Austin	TX 78745-1835
660528	Marian 	Reed	4665 Jefferson Township Ln	Marietta	GA 30066-1701
660925	Colin	Knight	9402 Bentridge Ave	Potomac	MD 20854-2870
664589	Lettice 	Jones	9105 Tyler Ave	Jacksonville	FL 32208-2356
666364	Margerie	Farmer	159 W Tuolumne Rd, Apt W	Turlock	CA 95382-1065
672668	Francisco	Haycraft	3749 W Oregon Ave	Phoenix	AZ 85019-3389
677775	Matthew	Knight	1518 Grand Dr	Dekalb	IL 60115-1090
678484	Brian	Reed	4470 NW 16th Ter	Oakland Park	FL 33309-4557
680837	Lawrence	Truscott	535 Pierce St, Apt 1206	Albany	CA 94706-1053
682308	David	Southcott	1140 Edmonds Ave NE, Apt 304	Renton	WA 98056-2963
683258	Gregory	Surridge	6063 N Sauganash Ave	Chicago	IL 60646-5240
686830	Henry	Beer	12314 Ashford Place D	Sugar Land	TX 77478-6180
694654	Ninion	Surridge	121 Kee Rd	Belmont	NC 28012-2810
697328	Alexander	Hanscom	38-08 Victoria Rd	Fair Lawn	NJ 07410-5033
698328	Judith 	Kingstone	PO Box 4155	Jackson	WY 83001-4155
698579	Peter	Thorn	160 Mineola Boulevard	Mineola	NY 11501-3937
699813	Artie	Mauricio	20401 Soledad Canyon Rd	Canyon Country	CA 91351-2556
702646	Felix	Crocker	5527 Saint Andrew Dr	Clarkston	MI 48348-4833
704137	Margareta	Tuckett	928 Calle Simpatico	Glendale	CA 91208-3031
711809	Felix	Fowler	3655 Millbranch Rd	Memphis	TN 38116-4817
716391	Jocatta 	Lee	2412 Hardie St	Greensboro	NC 27403-3710
717046	Malinda	Bento	1050 Buckingham St	Watertown	CT 06795-6602
722712	Leisa	Bagley	604 Paramus Rd	Paramus	NJ 07652-1711
724176	Elsie	Lovering	12421 Copperfield Dr	Austin	TX 78753-7082
724724	Bevil	Knight	3559 55th Ave	Hyattsville	MD 20784-1044
725412	Elsie	Stevens	100 North 1st Street	Alhambra	CA 91801-3531
733002	Janise	Aaron	25 Danny Rd	Hyde Park	MA 02136-1908
737490	Gartheride 	Stoneman	4510 W Capitol Dr	Milwaukee	WI 53216-1564
738950	Fulk	James	700 N Town East Blvd	Mesquite	TX 75150-4769
745584	Hellen	Mullice	4701 Randolph Rd, Ste 103	Rockville	MD 20852-2260
755242	Reginald	Kendall	315 Barr Elms Ave	Joliet	IL 60433-2125
759499	Sibill	Parkes	51 Everett Dr	Princeton Junction	NJ 08550-5374
765771	Everard	May	2447 30th St SW	Allentown	PA 18103-7082
768280	Howel	Seccombe	5604 Lafayette Rd	Medina	OH 44256-2466
768402	Xenofon	Turpin	5517 Winthrop Ave	Indianapolis	IN 46220-3248
769318	Odell	Holmes	7818 Liberty Rd	Windsor Mill	MD 21244-3863
770328	Marica	Grassi	554 S Bond St	Anaheim	CA 92805-4823
772077	Annita	Meadows	4057 Valderrama	Pleasant Grove	UT 84062-8547
772331	Alice 	Wadham	3500 NW Boca Raton Blvd	Boca Raton	FL 33431-5851
783978	Sherie	Puddicombe	14008 Casimir Ave	Gardena	CA 90249-2811
788669	Tabetha	Neck	8616 Ryan Dr	Fishers	IN 46038-5264
795087	Carola	Mcilrath	2237 Fernley Ave	Sacramento	CA 95815-2930
798067	Winefred	Norrish	224 S Milledge Ave	Athens	GA 30605-1046
805253	Pantelis	Ash	3434 S Longfellow Cir	Hollywood	FL 33021-4950
806104	Cornelius	Bento	4720 N Lockwood Ridge Rd	Sarasota	FL 34234-5020
806359	Jeremy	Wardell	1917 Summit Ave	Union City	NJ 07087-2023
807142	Matthew	Palmer	324 S Wayne St	Piqua	OH 45356-3519
811523	Susanna 	Haycraft	1 Birch Ct	Orangeburg	NY 10962-2829
815882	Francisco	Fuhrman	5209 Fruitridge Rd	Sacramento	CA 95820-5435
827508	Lawrence	Gidley	630 S Euclid St	Santa Ana	CA 92704-1712
828157	George	Mcdowell	1127 Walnut St	McKeesport	PA 15132-4230
828784	Reginald	Lee	7609 Roseland Dr	Urbandale	IA 50322-4162
830749	Samuel	Lee	12542 Rosslare Dr	Houston	TX 77066-3241
831021	Bobbi	Grassi	114 Old Country Road	Mineola	NY 11501-4400
831336	Iakovos	Bagley	3777 S Gessner Rd	Houston	TX 77063-5212
838313	Eduardo	Pawley	941 Dixie Hwy	Rossford	OH 43460-1332
838642	Tabitha 	Neck	410 W 23rd St	Merced	CA 95340-3723
839536	Cyndi	Lee	1823 W 236th St	Torrance	CA 90501-5742
846250	Cornelius	Diment	1522 Chukar Dr	Longmont	CO 80501-8602
846782	Ghislaine	Hymes	6020 Linden Ave	Long Beach	CA 90805-3093
852072	Jude	Clardy	1094 Happy Valley Ave	San Jose	CA 95129-3217
853021	Nestor	Ellen	13624 Livernois Ave	Detroit	MI 48238-2516
859084	Benedict	Abdo	7638 Barnhart Pl	Cupertino	CA 95014-5239
860790	Daysi	Aaron	164 Lightning Trl	Smithfield	NC 27577-7156
863719	Marcelle	Willcutt	244 Summer St	Rehoboth	MA 02769-1114
865129	Jordan	Palmer	831 Marina Village Pkwy	Alameda	CA 94501-1035
868590	Matthew	Grassi	200 Old Country Road	Mineola	NY 11501-4235
869443	Lucy 	Luscombe	281 Turner Rd	McDonough	GA 30252-2875
872109	Janel	Clardy	34462 Eighth Ave SW	Federal Way	WA 98023-8400
876348	Peter	Newcombe	14950 Zelma St, Apt 23	San Leandro	CA 94579-1477
881752	Bevil	Lipe	5590 Farnsley Knob Rd	Elizabeth	IN 47117-9602
887576	Benedict	Andrews	325 Main St	Frankfort	MI 49635-9047
893343	Ninion	Crocker	5405 Sandpiper Ln	Garland	TX 75043-4233
896475	Wombell	Corner	2640 Bowers Ave	Santa Clara	CA 95051-0916
901420	Leisa	Yeo	5302 Texoma Pkwy	Sherman	TX 75090-2112
901846	Johanna	Soper	1500 Osborn St	Burlington	IA 52601-4545
905945	Francisco	Tovar	2245 N Decatur Blvd	Las Vegas	NV 89108-2910
915615	Nestor	Wardell	6910 Melba Ave	Canoga Park	CA 91307-2413
916692	Donnie	Dials	2705 Cambridge St	Norcross	GA 30071-2609
918271	Jordan	Crook	10215 Aqueduct Ave	North Hills	CA 91343-1503
921482	Prudence 	Bulley	610 Cohen Way	Sarasota	FL 34236-4028
929177	Lewis	Steer	1001 E Grant St, Unit G2	Santa Ana	CA 92701-852 
930616	Brian	Dunigan	176 Mineola Boulevard	Mineola	NY 11501-2514
935956	Reginald	Bowden	188 Arrowrock Rd	Sacramento	CA 95838-4102
936623	Dimosthenis	Williams	1412 E Ninth St	Brooklyn	NY 11230-6405
937319	Erasmus	Puddicombe	6004 Oldham Dr	McKinney	TX 75070-9579
937665	George	Wadham	4003 233rd St	Little Neck	NY 11363-1544
938400	Iakovos	Western	1240 Bedford Rd	Grosse Pointe Park	MI 48230-1116
942511	Cornelius	Stebbins	200 Rock Ridge Rd	Hazard	KY 41701-9455
943560	Eduardo	Grassi	1523 Brady Creek Ln	Richmond	TX 77469-8264
945499	Mikel	Kawasaki	299 Glenwood Avenue	Bloomfield	NJ 07003-2445
947681	Cyndi	Collins	1076 Hampstead Pl	Augusta	GA 30907-6200
951491	Janise	Chubb	14307 Summer Tree Rd	Centreville	VA 20121-4021
951875	Annita	Clardy	6510 Harrison St	Garden City	MI 48135-2256
952154	Jeremy	Arroyo	531 McNeely Cir	Greer	SC 29651-2584
953661	Shawanda	Daw	308 Eddy St, Apt 206	San Francisco	CA 94102-6619
958265	Susanna 	Pawley	5226 W Hampton Ave	Milwaukee	WI 53218-5016
962527	George	Kendall	216 Glenmore Rd	Chapel Hill	NC 27516-1137
966844	Carola	James	3720 Waterton Leas Ct	Charlotte	NC 28269-1226
967873	Stavros	Richards	524 N Beverly St	Chandler	AZ 85225-6905
982170	Lucy 	Daw	928 E Mariposa St	Altadena	CA 91001-2018
983393	Denton	Wills	1511 E 86th St	Chicago	IL 60619-6518
988570	Miltiadis	Lipe	3284 Cove Way	Marina	CA 93933-2233
993941	Yajaira	Couvillion	3648 SW 13th Ter	Miami	FL 33145-1014
995506	Bevil	Grassi	500 E Sixth St, Apt 2	Prairie City	IA 50228-8608
\.


--
-- Data for Name: itinerary; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.itinerary (trip_id, route_id, tid, day, "time") FROM stdin;
\.


--
-- Data for Name: legs; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.legs (route_id, rid, sid, "position", stop) FROM stdin;
22	1	1	0	0
22	1	2	1	1
22	1	3	2	\N
22	1	4	3	\N
22	1	5	4	\N
22	1	6	5	2
22	1	7	6	3
22	1	8	7	\N
22	1	9	8	4
22	1	10	9	\N
22	1	11	10	5
22	4	38	11	\N
22	4	37	12	6
22	4	36	13	\N
22	4	39	14	\N
22	4	40	15	7
22	2	21	16	\N
22	2	20	17	8
36	1	1	0	0
36	1	2	1	\N
36	1	3	2	1
36	1	4	3	\N
36	1	5	4	\N
36	1	6	5	2
36	1	7	6	3
36	1	8	7	\N
36	1	9	8	\N
36	1	10	9	4
36	1	11	10	\N
36	4	39	11	5
36	4	40	12	6
36	2	21	13	7
36	4	41	14	\N
36	3	27	15	8
42	1	1	0	0
42	1	2	1	\N
42	1	3	2	1
42	1	4	3	\N
42	1	5	4	\N
42	1	6	5	2
42	1	7	6	\N
42	1	8	7	\N
42	3	27	8	3
42	3	26	9	4
42	3	28	10	5
42	3	29	11	6
42	2	21	12	7
42	2	20	13	8
50	1	1	0	0
50	1	2	1	1
50	1	3	2	\N
50	1	4	3	2
50	1	5	4	3
50	1	6	5	4
50	1	7	6	5
50	1	8	7	6
50	3	28	8	7
50	3	29	9	8
50	2	21	10	\N
50	2	22	11	9
50	2	23	12	\N
50	3	30	13	\N
50	3	31	14	\N
50	3	32	15	\N
50	3	33	16	10
85	1	1	0	0
85	1	2	1	1
85	1	3	2	2
85	1	4	3	\N
85	2	19	4	\N
85	2	20	5	\N
85	2	21	6	\N
85	3	29	7	3
85	3	28	8	4
85	1	8	9	5
85	1	7	10	\N
85	1	6	11	6
85	1	9	12	7
85	1	10	13	\N
85	1	11	14	8
85	1	12	15	9
91	1	1	0	0
91	1	2	1	1
91	1	3	2	\N
91	1	4	3	\N
91	2	19	4	2
91	2	20	5	3
91	2	21	6	\N
91	3	29	7	4
91	3	28	8	\N
91	1	8	9	5
91	1	9	10	6
91	1	10	11	\N
91	1	11	12	\N
91	1	12	13	\N
91	1	13	14	\N
91	1	14	15	7
91	4	38	16	\N
91	4	37	17	8
91	4	36	18	9
92	1	1	0	0
92	1	2	1	\N
92	1	3	2	\N
92	1	4	3	1
92	2	19	4	2
92	2	20	5	3
92	2	21	6	\N
92	3	29	7	4
92	3	28	8	\N
92	1	8	9	5
92	1	9	10	\N
92	1	10	11	6
92	1	11	12	\N
92	1	12	13	\N
92	1	13	14	\N
92	1	14	15	\N
92	4	38	16	\N
92	4	37	17	\N
92	4	36	18	7
92	4	35	19	8
105	1	1	0	0
105	1	2	1	1
105	1	3	2	\N
105	1	4	3	\N
105	2	19	4	\N
105	2	20	5	\N
105	2	21	6	2
105	3	30	7	\N
105	3	31	8	3
105	3	32	9	4
105	3	33	10	\N
105	4	40	11	\N
105	4	39	12	\N
105	1	11	13	5
114	1	1	0	0
114	1	2	1	1
114	1	3	2	\N
114	1	4	3	\N
114	2	19	4	\N
114	2	20	5	\N
114	2	21	6	\N
114	4	40	7	\N
114	4	39	8	2
114	1	11	9	\N
114	1	10	10	3
114	1	9	11	4
114	1	8	12	\N
114	1	7	13	\N
114	1	6	14	\N
114	3	27	15	5
114	3	26	16	\N
114	3	25	17	6
124	1	1	0	0
124	1	2	1	\N
124	1	3	2	1
124	1	4	3	\N
124	2	19	4	\N
124	2	20	5	2
124	2	21	6	\N
124	4	40	7	\N
124	4	39	8	3
124	1	11	9	\N
124	1	12	10	4
124	1	13	11	5
124	1	14	12	\N
124	4	38	13	\N
124	4	37	14	6
124	4	36	15	7
124	4	35	16	8
132	1	2	0	0
132	1	3	1	\N
132	1	4	2	1
132	1	5	3	2
132	1	6	4	3
132	1	7	5	4
134	1	2	0	0
134	1	3	1	1
134	1	4	2	\N
134	1	5	3	2
134	1	6	4	\N
134	1	7	5	3
134	1	8	6	4
134	1	9	7	5
135	1	2	0	0
135	1	3	1	\N
135	1	4	2	\N
135	1	5	3	1
135	1	6	4	2
135	1	7	5	\N
135	1	8	6	\N
135	1	9	7	\N
135	1	10	8	3
139	1	2	0	0
139	1	3	1	\N
139	1	4	2	\N
139	1	5	3	1
139	1	6	4	2
139	1	7	5	\N
139	1	8	6	3
139	1	9	7	4
139	1	10	8	\N
139	1	11	9	\N
139	1	12	10	\N
139	1	13	11	5
139	1	14	12	6
155	1	2	0	0
155	1	3	1	1
155	1	4	2	\N
155	1	5	3	2
155	1	6	4	\N
155	1	7	5	3
155	1	8	6	\N
155	1	9	7	\N
155	1	10	8	4
155	1	11	9	5
155	4	39	10	\N
155	4	40	11	6
155	2	21	12	\N
155	3	29	13	7
155	3	30	14	8
157	1	2	0	0
157	1	3	1	1
157	1	4	2	2
157	1	5	3	3
157	1	6	4	\N
157	1	7	5	4
157	1	8	6	\N
157	1	9	7	\N
157	1	10	8	5
157	1	11	9	6
157	4	39	10	7
157	4	40	11	\N
157	2	21	12	8
157	3	29	13	\N
157	3	30	14	9
157	3	31	15	\N
157	3	32	16	10
158	1	2	0	0
158	1	3	1	1
158	1	4	2	2
158	1	5	3	3
158	1	6	4	\N
158	1	7	5	4
158	1	8	6	5
158	1	9	7	6
158	1	10	8	\N
158	1	11	9	7
158	4	39	10	\N
158	4	40	11	\N
158	2	21	12	\N
158	3	29	13	8
158	3	30	14	9
158	3	31	15	10
158	3	32	16	11
158	3	33	17	12
167	1	2	0	0
167	1	3	1	\N
167	1	4	2	\N
167	1	5	3	1
167	1	6	4	2
167	1	7	5	3
167	1	8	6	4
167	3	27	7	5
167	3	26	8	\N
167	3	28	9	\N
167	3	29	10	\N
167	2	21	11	6
171	1	2	0	0
171	1	3	1	1
171	1	4	2	2
171	1	5	3	\N
171	1	6	4	\N
171	1	7	5	\N
171	1	8	6	\N
171	3	28	7	\N
171	3	29	8	3
171	2	21	9	\N
171	2	20	10	4
171	2	22	11	5
171	2	23	12	6
178	1	2	0	0
178	1	3	1	\N
178	1	4	2	1
178	1	5	3	\N
178	1	6	4	2
178	1	7	5	\N
178	1	8	6	\N
178	3	28	7	\N
178	3	29	8	\N
178	2	21	9	3
178	3	30	10	4
178	3	31	11	\N
178	3	32	12	5
178	3	33	13	6
178	4	40	14	7
206	1	2	0	0
206	1	3	1	\N
206	1	4	2	\N
206	2	19	3	\N
206	2	20	4	\N
206	2	21	5	\N
206	2	22	6	1
206	2	23	7	\N
206	3	29	8	\N
206	3	28	9	2
206	1	8	10	\N
206	1	7	11	3
206	1	6	12	4
208	1	2	0	0
208	1	3	1	1
208	1	4	2	\N
208	2	19	3	\N
208	2	20	4	\N
208	2	21	5	2
208	3	29	6	3
208	3	28	7	4
208	1	8	8	5
208	1	7	9	6
208	1	6	10	\N
208	1	9	11	7
239	1	2	0	0
239	1	3	1	\N
239	1	4	2	1
239	2	19	3	\N
239	2	20	4	2
239	2	21	5	\N
239	4	40	6	3
239	4	39	7	\N
239	1	11	8	4
239	1	10	9	5
239	1	9	10	\N
239	1	8	11	6
239	1	7	12	\N
239	1	6	13	\N
239	3	27	14	\N
239	3	26	15	7
262	1	3	0	0
262	1	2	1	\N
262	1	4	2	\N
262	1	5	3	1
262	1	6	4	\N
262	1	7	5	2
262	1	8	6	3
262	1	9	7	4
262	1	10	8	\N
262	1	11	9	5
276	1	3	0	0
276	1	4	1	1
276	1	5	2	\N
276	1	6	3	2
276	1	7	4	3
276	1	8	5	\N
276	1	9	6	\N
276	1	10	7	\N
276	1	11	8	4
276	4	39	9	\N
276	4	40	10	5
276	2	21	11	\N
276	2	20	12	6
276	2	22	13	7
301	1	3	0	0
301	1	4	1	1
301	1	5	2	2
301	1	6	3	3
301	1	7	4	\N
301	1	8	5	\N
301	3	28	6	\N
301	3	29	7	4
301	2	21	8	5
301	2	22	9	6
301	2	23	10	\N
301	3	30	11	7
301	3	31	12	8
301	3	32	13	9
313	1	3	0	0
313	1	4	1	\N
313	1	5	2	\N
313	1	6	3	\N
313	1	7	4	\N
313	1	8	5	1
313	3	28	6	\N
313	3	29	7	2
313	2	21	8	3
313	4	40	9	4
313	4	39	10	\N
313	1	11	11	\N
313	1	12	12	\N
313	1	13	13	5
313	1	14	14	\N
313	4	38	15	6
315	1	3	0	0
315	1	4	1	\N
315	1	5	2	1
315	1	6	3	2
315	1	7	4	3
315	1	8	5	\N
315	3	28	6	\N
315	3	29	7	\N
315	2	21	8	\N
315	4	40	9	4
315	4	39	10	5
315	1	11	11	\N
315	1	12	12	6
315	1	13	13	\N
315	1	14	14	\N
315	4	38	15	\N
315	4	37	16	\N
315	4	36	17	7
339	1	3	0	0
339	1	4	1	\N
339	2	19	2	\N
339	2	20	3	\N
339	2	21	4	\N
339	3	29	5	\N
339	3	28	6	1
339	1	8	7	2
339	1	7	8	3
339	1	6	9	\N
339	1	9	10	4
339	1	10	11	\N
339	1	11	12	\N
339	1	12	13	\N
339	1	13	14	\N
339	1	14	15	5
369	1	3	0	0
369	1	4	1	\N
369	2	19	2	\N
369	2	20	3	1
369	2	21	4	\N
369	4	40	5	\N
369	4	39	6	\N
369	1	11	7	2
369	1	10	8	3
369	1	9	9	\N
369	1	8	10	4
369	3	28	11	\N
369	1	12	12	5
376	1	3	0	0
376	1	4	1	\N
376	2	19	2	1
376	2	20	3	\N
376	2	21	4	\N
376	4	40	5	\N
376	4	39	6	2
376	1	11	7	\N
376	1	12	8	3
376	1	13	9	\N
376	1	14	10	\N
376	4	38	11	\N
376	4	37	12	4
376	4	36	13	\N
376	4	35	14	5
380	1	4	0	0
380	1	3	1	1
380	1	2	2	2
384	1	4	0	0
384	1	3	1	\N
384	1	2	2	1
384	1	5	3	\N
384	1	6	4	2
384	1	7	5	3
387	1	4	0	0
387	1	3	1	1
387	1	2	2	\N
387	1	5	3	2
387	1	6	4	3
387	1	7	5	4
387	1	8	6	5
387	1	9	7	6
387	1	10	8	7
397	1	4	0	0
397	1	5	1	\N
397	1	6	2	\N
397	1	7	3	1
397	1	8	4	2
397	1	9	5	\N
397	1	10	6	\N
397	1	11	7	\N
397	4	38	8	\N
397	4	37	9	\N
397	4	36	10	3
397	4	39	11	4
410	1	4	0	0
410	1	5	1	\N
410	1	6	2	1
410	1	7	3	\N
410	1	8	4	\N
410	1	9	5	2
410	1	10	6	3
410	1	11	7	4
410	4	39	8	5
410	4	40	9	\N
410	2	21	10	\N
410	3	29	11	6
410	3	30	12	7
410	3	31	13	8
410	3	32	14	9
410	3	33	15	10
422	1	4	0	0
422	1	5	1	1
422	1	6	2	2
422	1	7	3	\N
422	1	8	4	\N
422	3	28	5	\N
422	3	29	6	\N
422	2	21	7	\N
422	2	20	8	\N
422	2	22	9	3
424	1	4	0	0
424	1	5	1	1
424	1	6	2	\N
424	1	7	3	\N
424	1	8	4	\N
424	3	28	5	\N
424	3	29	6	\N
424	2	21	7	2
424	2	20	8	3
424	2	22	9	\N
424	2	23	10	\N
424	2	24	11	4
427	1	4	0	0
427	1	5	1	\N
427	1	6	2	1
427	1	7	3	2
427	1	8	4	3
427	3	28	5	4
427	3	29	6	\N
427	2	21	7	5
427	2	22	8	\N
427	2	23	9	\N
427	3	30	10	\N
427	3	31	11	6
427	3	32	12	7
431	1	4	0	0
431	1	5	1	1
431	1	6	2	2
431	1	7	3	3
431	1	8	4	\N
431	3	28	5	4
431	3	29	6	5
431	2	21	7	\N
431	3	30	8	6
431	3	31	9	7
431	3	32	10	\N
431	3	33	11	8
431	4	40	12	9
431	4	39	13	10
455	1	4	0	0
455	2	19	1	1
455	2	20	2	\N
455	2	21	3	2
455	2	22	4	\N
455	2	23	5	\N
455	3	29	6	\N
455	3	28	7	3
467	1	4	0	0
467	2	19	1	\N
467	2	20	2	\N
467	2	21	3	1
467	3	29	4	\N
467	3	28	5	\N
467	1	8	6	2
467	1	9	7	3
467	1	10	8	\N
467	1	11	9	\N
467	1	12	10	\N
467	1	13	11	4
467	1	14	12	5
467	4	38	13	6
468	1	4	0	0
468	2	19	1	\N
468	2	20	2	1
468	2	21	3	2
468	3	29	4	3
468	3	28	5	4
468	1	8	6	5
468	1	9	7	\N
468	1	10	8	6
468	1	11	9	7
468	1	12	10	8
468	1	13	11	\N
468	1	14	12	\N
468	4	38	13	\N
468	4	37	14	9
477	1	4	0	0
477	2	19	1	1
477	2	20	2	2
477	2	21	3	3
477	3	29	4	\N
477	3	28	5	\N
477	1	8	6	4
477	3	27	7	5
477	3	26	8	6
477	3	30	9	\N
477	3	31	10	7
483	1	4	0	0
483	2	19	1	1
483	2	20	2	\N
483	2	21	3	\N
483	3	30	4	2
483	3	31	5	\N
483	3	32	6	\N
483	3	33	7	3
483	4	40	8	\N
483	4	39	9	\N
483	1	11	10	4
487	1	4	0	0
487	2	19	1	1
487	2	20	2	2
487	2	21	3	3
487	3	30	4	4
487	3	31	5	5
487	3	32	6	\N
487	3	33	7	\N
487	4	40	8	6
487	4	39	9	\N
487	1	11	10	7
487	1	10	11	\N
487	1	9	12	\N
487	1	8	13	\N
487	1	7	14	8
488	1	4	0	0
488	2	19	1	1
488	2	20	2	2
488	2	21	3	3
488	3	30	4	4
488	3	31	5	\N
488	3	32	6	\N
488	3	33	7	\N
488	4	40	8	5
488	4	39	9	6
488	1	11	10	\N
488	1	10	11	7
488	1	9	12	\N
488	1	8	13	\N
488	1	7	14	\N
488	1	6	15	8
495	1	4	0	0
495	2	19	1	1
495	2	20	2	\N
495	2	21	3	2
495	4	40	4	\N
495	4	39	5	3
495	1	11	6	\N
495	1	10	7	\N
495	1	9	8	\N
495	1	8	9	\N
495	3	28	10	4
495	1	12	11	5
497	1	4	0	0
497	2	19	1	\N
497	2	20	2	1
497	2	21	3	\N
497	4	40	4	2
497	4	39	5	\N
497	1	11	6	3
497	1	10	7	4
497	1	9	8	\N
497	1	8	9	\N
497	3	28	10	5
497	1	12	11	\N
497	1	13	12	6
497	1	14	13	7
516	1	5	0	0
516	1	4	1	\N
516	2	18	2	\N
516	2	17	3	\N
516	2	19	4	1
516	2	20	5	\N
516	2	21	6	\N
516	2	22	7	2
516	2	23	8	3
519	1	5	0	0
519	1	4	1	1
519	2	19	2	2
519	2	20	3	\N
519	2	21	4	3
519	2	22	5	4
519	2	23	6	5
519	3	29	7	6
519	3	28	8	7
536	1	5	0	0
536	1	4	1	1
536	2	19	2	\N
536	2	20	3	\N
536	2	21	4	2
536	3	29	5	\N
536	3	28	6	3
536	1	8	7	4
536	1	9	8	5
536	1	10	9	\N
536	1	11	10	\N
536	4	39	11	6
536	3	27	12	7
542	1	5	0	0
542	1	4	1	\N
542	2	19	2	\N
542	2	20	3	1
542	2	21	4	2
542	3	29	5	\N
542	3	28	6	3
542	1	8	7	\N
542	3	27	8	4
542	3	26	9	5
542	3	30	10	6
542	3	31	11	\N
542	3	32	12	\N
542	3	33	13	7
554	1	5	0	0
554	1	4	1	\N
554	2	19	2	1
554	2	20	3	\N
554	2	21	4	2
554	4	40	5	\N
554	4	39	6	3
554	1	11	7	4
554	1	10	8	5
554	1	9	9	6
554	1	8	10	7
554	1	7	11	\N
554	3	27	12	\N
554	3	26	13	8
554	3	25	14	9
580	1	5	0	0
580	1	6	1	1
580	1	7	2	2
580	1	8	3	\N
580	1	9	4	3
580	1	10	5	\N
580	1	11	6	\N
580	1	12	7	4
580	1	13	8	\N
580	1	14	9	\N
580	4	38	10	5
580	4	37	11	\N
580	4	36	12	6
580	4	35	13	7
590	1	5	0	0
590	1	6	1	\N
590	1	7	2	\N
590	1	8	3	\N
590	1	9	4	1
590	1	10	5	\N
590	1	11	6	\N
590	4	39	7	2
590	4	40	8	\N
590	2	21	9	\N
590	2	20	10	3
590	2	19	11	4
590	1	4	12	\N
590	1	3	13	\N
590	1	2	14	5
590	2	18	15	6
634	1	5	0	0
634	1	6	1	\N
634	1	7	2	1
634	1	8	3	2
634	3	28	4	\N
634	3	29	5	3
634	2	21	6	4
634	4	40	7	\N
634	4	39	8	5
634	1	11	9	\N
634	1	10	10	\N
634	1	12	11	6
634	1	13	12	7
635	1	5	0	0
635	1	6	1	\N
635	1	7	2	\N
635	1	8	3	\N
635	3	28	4	1
635	3	29	5	2
635	2	21	6	3
635	4	40	7	\N
635	4	39	8	\N
635	1	11	9	\N
635	1	10	10	\N
635	1	12	11	4
635	1	13	12	5
635	1	14	13	6
637	1	5	0	0
637	1	6	1	1
637	1	7	2	\N
637	1	8	3	2
637	3	28	4	3
637	3	29	5	\N
637	2	21	6	\N
637	4	40	7	4
637	4	39	8	\N
637	1	11	9	\N
637	1	12	10	\N
637	1	13	11	\N
637	1	14	12	\N
637	4	38	13	5
649	1	6	0	0
649	1	5	1	1
649	1	4	2	2
649	1	3	3	3
649	1	2	4	4
649	2	18	5	5
649	2	17	6	6
655	1	6	0	0
655	1	5	1	1
655	1	4	2	\N
655	2	18	3	\N
655	2	17	4	\N
655	2	19	5	\N
655	2	20	6	\N
655	2	21	7	\N
655	2	22	8	\N
655	2	23	9	2
683	1	6	0	0
683	1	5	1	1
683	1	4	2	\N
683	2	19	3	2
683	2	20	4	3
683	2	21	5	4
683	3	30	6	\N
683	3	31	7	\N
683	3	32	8	5
683	3	33	9	\N
683	4	40	10	\N
683	4	39	11	6
684	1	6	0	0
684	1	5	1	\N
684	1	4	2	1
684	2	19	3	\N
684	2	20	4	2
684	2	21	5	3
684	3	30	6	\N
684	3	31	7	\N
684	3	32	8	\N
684	3	33	9	4
684	4	40	10	\N
684	4	39	11	\N
684	1	11	12	5
685	1	6	0	0
685	1	5	1	\N
685	1	4	2	1
685	2	19	3	\N
685	2	20	4	\N
685	2	21	5	2
685	3	30	6	\N
685	3	31	7	\N
685	3	32	8	3
685	3	33	9	4
685	4	40	10	\N
685	4	39	11	\N
685	1	11	12	\N
685	1	10	13	5
689	1	6	0	0
689	1	5	1	1
689	1	4	2	\N
689	2	19	3	\N
689	2	20	4	2
689	2	21	5	\N
689	4	40	6	3
689	4	39	7	\N
689	1	11	8	\N
689	1	10	9	4
689	1	9	10	5
689	1	8	11	6
689	3	27	12	7
690	1	6	0	0
690	1	5	1	1
690	1	4	2	2
690	2	19	3	\N
690	2	20	4	3
690	2	21	5	\N
690	4	40	6	4
690	4	39	7	5
690	1	11	8	\N
690	1	10	9	\N
690	1	9	10	6
690	1	8	11	7
690	3	27	12	8
690	3	26	13	9
695	1	6	0	0
695	1	5	1	\N
695	1	4	2	1
695	2	19	3	2
695	2	20	4	\N
695	2	21	5	3
695	4	40	6	4
695	4	39	7	\N
695	1	11	8	\N
695	1	10	9	\N
695	1	9	10	\N
695	1	8	11	5
695	3	28	12	\N
695	1	12	13	6
695	1	13	14	7
696	1	6	0	0
696	1	5	1	\N
696	1	4	2	1
696	2	19	3	\N
696	2	20	4	2
696	2	21	5	3
696	4	40	6	\N
696	4	39	7	\N
696	1	11	8	4
696	1	10	9	5
696	1	9	10	6
696	1	8	11	\N
696	3	28	12	7
696	1	12	13	\N
696	1	13	14	8
696	1	14	15	9
714	1	6	0	0
714	1	7	1	\N
714	1	8	2	\N
714	1	9	3	1
714	1	10	4	\N
714	1	11	5	2
714	1	12	6	\N
714	1	13	7	3
714	1	14	8	\N
714	4	38	9	\N
714	4	37	10	4
728	1	6	0	0
728	1	7	1	\N
728	1	8	2	\N
728	1	9	3	\N
728	1	10	4	\N
728	1	11	5	\N
728	4	39	6	\N
728	4	40	7	1
728	2	21	8	2
728	2	20	9	\N
728	2	19	10	3
728	1	4	11	\N
728	2	18	12	4
728	2	17	13	5
732	1	6	0	0
732	1	7	1	1
732	1	8	2	2
732	1	9	3	3
732	1	10	4	4
732	1	11	5	5
732	4	39	6	6
732	4	40	7	\N
732	2	21	8	7
732	2	20	9	8
732	2	19	10	9
732	1	4	11	\N
732	2	18	12	10
732	2	17	13	11
732	2	22	14	12
732	2	23	15	13
732	2	24	16	14
734	1	6	0	0
734	1	7	1	1
734	1	8	2	\N
734	1	9	3	2
734	1	10	4	\N
734	1	11	5	3
734	4	39	6	\N
734	4	40	7	4
734	2	21	8	\N
734	2	22	9	5
734	2	23	10	6
734	3	29	11	7
734	3	28	12	8
741	1	6	0	0
741	1	7	1	\N
741	1	8	2	\N
741	1	9	3	1
741	1	10	4	\N
741	1	11	5	\N
741	4	39	6	2
741	4	40	7	\N
741	2	21	8	\N
741	3	30	9	\N
741	3	31	10	\N
741	3	32	11	\N
741	3	33	12	3
741	4	41	13	\N
741	4	42	14	4
745	1	6	0	0
745	1	7	1	\N
745	1	8	2	1
745	3	27	3	\N
745	3	26	4	2
745	3	28	5	3
746	1	6	0	0
746	1	7	1	1
746	1	8	2	2
746	3	27	3	\N
746	3	26	4	\N
746	3	28	5	3
746	3	29	6	4
747	1	6	0	0
747	1	7	1	1
747	1	8	2	\N
747	3	27	3	2
747	3	26	4	\N
747	3	28	5	3
747	3	29	6	\N
747	2	21	7	4
753	1	6	0	0
753	1	7	1	1
753	1	8	2	\N
753	3	27	3	2
753	3	26	4	\N
753	3	28	5	3
753	3	29	6	\N
753	2	21	7	4
753	2	20	8	\N
753	2	19	9	5
753	1	4	10	\N
753	1	3	11	6
753	1	2	12	\N
753	1	1	13	7
761	1	6	0	0
761	1	7	1	1
761	1	8	2	2
761	3	28	3	\N
761	3	29	4	3
761	2	21	5	4
761	2	22	6	5
761	2	23	7	6
761	3	30	8	7
768	1	6	0	0
768	1	7	1	1
768	1	8	2	\N
768	3	28	3	\N
768	3	29	4	\N
768	2	21	5	\N
768	3	30	6	\N
768	3	31	7	2
768	3	32	8	\N
768	3	33	9	3
768	4	40	10	4
768	4	39	11	5
768	1	11	12	6
771	1	6	0	0
771	1	7	1	1
771	1	8	2	\N
771	3	28	3	2
771	3	29	4	3
771	2	21	5	\N
771	4	40	6	4
771	4	39	7	\N
771	1	11	8	\N
771	1	10	9	5
771	1	12	10	6
795	1	7	0	0
795	1	6	1	\N
795	1	5	2	\N
795	1	4	3	\N
795	2	18	4	\N
795	2	17	5	1
795	2	19	6	2
795	2	20	7	\N
795	2	21	8	\N
795	2	22	9	\N
795	2	23	10	3
795	2	24	11	4
823	1	7	0	0
823	1	6	1	1
823	1	5	2	\N
823	1	4	3	\N
823	2	19	4	\N
823	2	20	5	\N
823	2	21	6	\N
823	3	30	7	2
823	3	31	8	\N
823	3	32	9	3
823	3	33	10	\N
823	4	40	11	\N
823	4	39	12	\N
823	1	11	13	\N
823	1	10	14	4
824	1	7	0	0
824	1	6	1	1
824	1	5	2	2
824	1	4	3	\N
824	2	19	4	\N
824	2	20	5	\N
824	2	21	6	3
824	3	30	7	\N
824	3	31	8	\N
824	3	32	9	4
824	3	33	10	\N
824	4	40	11	5
824	4	39	12	6
824	1	11	13	7
824	1	10	14	8
824	1	9	15	9
835	1	7	0	0
835	1	6	1	\N
835	1	5	2	1
835	1	4	3	2
835	2	19	4	3
835	2	20	5	4
835	2	21	6	\N
835	4	40	7	5
835	4	39	8	6
835	1	11	9	7
835	1	12	10	8
835	1	13	11	9
835	1	14	12	10
835	4	38	13	11
842	1	7	0	0
842	1	6	1	\N
842	1	5	2	\N
842	1	4	3	\N
842	2	19	4	1
842	2	20	5	2
842	2	21	6	3
842	4	41	7	4
842	1	8	8	\N
842	1	9	9	5
866	1	7	0	0
866	1	8	1	1
866	1	9	2	2
866	1	10	3	3
866	1	11	4	\N
866	4	39	5	4
866	4	40	6	5
866	2	21	7	\N
866	2	20	8	6
866	2	19	9	7
866	1	4	10	\N
866	1	5	11	\N
866	2	18	12	\N
866	2	17	13	8
866	2	16	14	9
869	1	7	0	0
869	1	8	1	1
869	1	9	2	\N
869	1	10	3	\N
869	1	11	4	2
869	4	39	5	\N
869	4	40	6	3
869	2	21	7	\N
869	2	20	8	4
869	2	19	9	5
869	1	4	10	\N
869	2	18	11	6
869	2	17	12	\N
869	2	22	13	\N
869	2	23	14	7
869	2	24	15	8
872	1	7	0	0
872	1	8	1	\N
872	1	9	2	\N
872	1	10	3	\N
872	1	11	4	1
872	4	39	5	\N
872	4	40	6	\N
872	2	21	7	\N
872	3	29	8	2
872	3	30	9	3
906	1	7	0	0
906	1	8	1	\N
906	3	28	2	1
906	3	29	3	2
906	2	21	4	\N
906	3	30	5	3
906	3	31	6	4
906	3	32	7	5
906	3	33	8	\N
906	4	40	9	6
906	4	39	10	\N
906	1	11	11	7
916	1	7	0	0
916	1	8	1	1
916	3	28	2	2
916	3	29	3	3
916	2	21	4	\N
916	4	40	5	4
916	4	39	6	5
916	1	11	7	6
916	1	12	8	\N
916	1	13	9	\N
916	1	14	10	\N
916	4	38	11	\N
916	4	37	12	\N
916	4	36	13	7
916	4	35	14	8
923	1	8	0	0
923	1	7	1	\N
923	1	6	2	\N
923	1	5	3	\N
923	1	4	4	1
923	1	3	5	2
964	1	8	0	0
964	1	9	1	\N
964	1	10	2	1
964	1	11	3	\N
964	1	12	4	\N
964	1	13	5	\N
964	1	14	6	\N
964	4	38	7	2
981	1	8	0	0
981	1	9	1	1
981	1	10	2	2
981	1	11	3	\N
981	4	39	4	\N
981	4	40	5	3
981	2	21	6	\N
981	2	20	7	4
981	2	19	8	\N
981	1	4	9	\N
981	1	5	10	\N
981	1	6	11	\N
981	2	18	12	5
981	2	17	13	6
983	1	8	0	0
983	1	9	1	1
983	1	10	2	2
983	1	11	3	3
983	4	39	4	\N
983	4	40	5	\N
983	2	21	6	\N
983	2	20	7	\N
983	2	19	8	4
983	1	4	9	\N
983	2	18	10	5
983	2	17	11	\N
983	2	22	12	6
989	1	8	0	0
989	1	9	1	1
989	1	10	2	2
989	1	11	3	3
989	4	39	4	\N
989	4	40	5	4
989	2	21	6	5
989	3	29	7	6
989	3	30	8	7
989	3	31	9	8
992	1	8	0	0
992	1	9	1	\N
992	1	10	2	\N
992	1	11	3	\N
992	4	39	4	\N
992	4	40	5	1
992	2	21	6	\N
992	3	29	7	2
992	3	30	8	\N
992	3	31	9	3
992	3	32	10	4
992	3	33	11	5
992	3	34	12	6
998	1	8	0	0
998	3	27	1	1
998	3	26	2	2
998	3	28	3	3
1002	1	8	0	0
1002	3	27	1	1
1002	3	26	2	\N
1002	3	28	3	\N
1002	3	29	4	\N
1002	2	21	5	2
1002	2	20	6	\N
1002	2	19	7	3
1008	1	8	0	0
1008	3	28	1	\N
1008	3	29	2	1
1008	2	21	3	\N
1008	2	20	4	\N
1008	2	19	5	\N
1008	1	4	6	2
1008	1	3	7	\N
1008	1	2	8	3
1008	1	5	9	\N
1008	1	6	10	4
1013	1	8	0	0
1013	3	28	1	\N
1013	3	29	2	\N
1013	2	21	3	1
1013	2	20	4	\N
1013	2	19	5	\N
1013	1	4	6	2
1013	2	18	7	\N
1013	2	17	8	3
1013	2	22	9	4
1022	1	8	0	0
1022	3	28	1	1
1022	3	29	2	2
1022	2	21	3	\N
1022	3	30	4	\N
1022	3	31	5	3
1022	3	32	6	\N
1022	3	33	7	\N
1022	4	40	8	4
1022	4	39	9	5
1029	1	8	0	0
1029	3	28	1	1
1029	3	29	2	2
1029	2	21	3	\N
1029	4	40	4	3
1029	4	39	5	4
1029	1	11	6	\N
1029	1	10	7	5
1029	1	12	8	6
1029	1	13	9	7
1029	1	14	10	\N
1029	1	15	11	8
1033	1	8	0	0
1033	3	28	1	\N
1033	3	29	2	\N
1033	2	21	3	1
1033	4	40	4	\N
1033	4	39	5	\N
1033	1	11	6	\N
1033	1	12	7	2
1033	1	13	8	\N
1033	1	14	9	\N
1033	4	38	10	3
1033	4	37	11	\N
1033	4	36	12	4
1033	4	35	13	5
1035	1	8	0	0
1035	3	28	1	1
1035	3	29	2	2
1035	2	21	3	3
1035	4	40	4	\N
1035	4	39	5	4
1035	1	11	6	5
1035	4	38	7	6
1035	4	37	8	7
1035	4	36	9	\N
1035	4	41	10	\N
1035	4	42	11	8
1041	1	9	0	0
1041	1	8	1	\N
1041	1	7	2	\N
1041	1	6	3	\N
1041	1	5	4	\N
1041	1	4	5	\N
1041	1	3	6	1
1044	1	9	0	0
1044	1	8	1	\N
1044	1	7	2	\N
1044	1	6	3	1
1044	1	5	4	2
1044	1	4	5	3
1044	1	3	6	4
1044	1	2	7	\N
1044	2	18	8	5
1049	1	9	0	0
1049	1	8	1	\N
1049	1	7	2	1
1049	1	6	3	2
1049	1	5	4	3
1049	1	4	5	\N
1049	2	18	6	\N
1049	2	17	7	\N
1049	2	19	8	\N
1049	2	20	9	\N
1049	2	21	10	4
1070	1	9	0	0
1070	1	8	1	\N
1070	1	7	2	1
1070	1	6	3	\N
1070	1	5	4	2
1070	1	4	5	\N
1070	2	19	6	3
1070	2	20	7	4
1070	2	21	8	5
1070	4	40	9	\N
1070	4	39	10	6
1070	1	11	11	\N
1070	1	12	12	\N
1070	1	13	13	\N
1070	1	14	14	7
1070	4	38	15	8
1070	4	37	16	9
1070	4	36	17	10
1081	1	9	0	0
1081	1	8	1	1
1081	3	27	2	\N
1081	3	26	3	2
1081	3	28	4	\N
1081	3	29	5	\N
1081	2	21	6	3
1081	2	20	7	4
1081	2	19	8	5
1088	1	9	0	0
1088	1	8	1	\N
1088	3	28	2	1
1088	3	29	3	\N
1088	2	21	4	2
1088	2	20	5	\N
1088	2	19	6	\N
1088	1	4	7	\N
1088	1	3	8	\N
1088	1	2	9	3
1088	1	5	10	\N
1088	1	6	11	4
1088	1	7	12	5
1091	1	9	0	0
1091	1	8	1	\N
1091	3	28	2	1
1091	3	29	3	\N
1091	2	21	4	2
1091	2	20	5	\N
1091	2	19	6	\N
1091	1	4	7	3
1091	1	5	8	\N
1091	1	6	9	\N
1091	2	18	10	4
1091	2	17	11	5
1091	2	16	12	6
1095	1	9	0	0
1095	1	8	1	\N
1095	3	28	2	\N
1095	3	29	3	1
1095	2	21	4	2
1095	2	22	5	3
1095	2	23	6	\N
1095	3	30	7	4
1110	1	9	0	0
1110	1	8	1	1
1110	3	28	2	\N
1110	3	29	3	2
1110	2	21	4	\N
1110	4	40	5	\N
1110	4	39	6	3
1110	1	11	7	4
1110	1	12	8	5
1110	1	13	9	\N
1110	1	14	10	6
1110	4	38	11	\N
1110	4	37	12	\N
1110	4	36	13	7
1112	1	9	0	0
1112	1	8	1	1
1112	3	28	2	2
1112	3	29	3	\N
1112	2	21	4	\N
1112	4	40	5	\N
1112	4	39	6	\N
1112	1	11	7	\N
1112	4	38	8	\N
1112	4	37	9	3
1112	4	36	10	\N
1112	4	41	11	4
1113	1	9	0	0
1113	1	8	1	\N
1113	3	28	2	\N
1113	3	29	3	\N
1113	2	21	4	\N
1113	4	40	5	1
1113	4	39	6	\N
1113	1	11	7	2
1113	4	38	8	3
1113	4	37	9	4
1113	4	36	10	5
1113	4	41	11	\N
1113	4	42	12	6
1125	1	9	0	0
1125	1	10	1	\N
1125	1	11	2	1
1125	4	38	3	\N
1125	4	37	4	2
1125	4	36	5	\N
1125	4	39	6	3
1125	4	40	7	4
1126	1	9	0	0
1126	1	10	1	1
1126	1	11	2	\N
1126	4	38	3	2
1126	4	37	4	\N
1126	4	36	5	\N
1126	4	39	6	3
1126	4	40	7	\N
1126	2	21	8	4
1128	1	9	0	0
1128	1	10	1	\N
1128	1	11	2	1
1128	4	38	3	\N
1128	4	37	4	\N
1128	4	36	5	\N
1128	4	39	6	\N
1128	4	40	7	\N
1128	2	21	8	\N
1128	2	20	9	2
1128	2	19	10	3
1158	1	9	0	0
1158	1	10	1	1
1158	1	11	2	\N
1158	4	39	3	2
1158	4	40	4	\N
1158	2	21	5	\N
1158	3	29	6	3
1158	3	28	7	4
1158	1	8	8	5
1158	1	7	9	6
1158	1	6	10	\N
1158	1	5	11	\N
1158	1	4	12	7
1158	1	3	13	\N
1158	1	2	14	8
1158	2	18	15	9
1184	1	10	0	0
1184	1	9	1	\N
1184	1	8	2	1
1184	1	7	3	\N
1184	1	6	4	2
1184	1	5	5	\N
1184	1	4	6	3
1184	1	3	7	\N
1184	1	2	8	\N
1184	2	18	9	4
1184	2	17	10	\N
1184	2	16	11	5
1191	1	10	0	0
1191	1	9	1	\N
1191	1	8	2	\N
1191	1	7	3	\N
1191	1	6	4	1
1191	1	5	5	\N
1191	1	4	6	\N
1191	2	19	7	\N
1191	2	20	8	\N
1191	2	21	9	2
1191	2	22	10	3
1191	2	23	11	\N
1191	3	29	12	4
1199	1	10	0	0
1199	1	9	1	\N
1199	1	8	2	1
1199	1	7	3	2
1199	1	6	4	3
1199	1	5	5	4
1199	1	4	6	\N
1199	2	19	7	\N
1199	2	20	8	5
1199	2	21	9	\N
1199	3	30	10	6
1199	3	31	11	7
1199	3	32	12	8
1199	3	33	13	\N
1199	4	40	14	\N
1199	4	39	15	9
1205	1	10	0	0
1205	1	9	1	1
1205	1	8	2	\N
1205	1	7	3	2
1205	1	6	4	\N
1205	1	5	5	\N
1205	1	4	6	3
1205	2	19	7	\N
1205	2	20	8	4
1205	2	21	9	5
1205	4	40	10	\N
1205	4	39	11	\N
1205	1	11	12	\N
1205	1	12	13	\N
1205	1	13	14	\N
1205	1	14	15	6
1205	4	38	16	7
1207	1	10	0	0
1207	1	9	1	1
1207	1	8	2	2
1207	1	7	3	3
1207	1	6	4	\N
1207	1	5	5	4
1207	1	4	6	5
1207	2	19	7	\N
1207	2	20	8	\N
1207	2	21	9	\N
1207	4	40	10	\N
1207	4	39	11	6
1207	1	11	12	7
1207	1	12	13	8
1207	1	13	14	9
1207	1	14	15	10
1207	4	38	16	11
1207	4	37	17	\N
1207	4	36	18	12
1212	1	10	0	0
1212	1	9	1	1
1212	1	8	2	\N
1212	1	7	3	\N
1212	1	6	4	2
1212	1	5	5	3
1212	1	4	6	4
1212	2	19	7	\N
1212	2	20	8	\N
1212	2	21	9	5
1212	4	41	10	\N
1212	3	27	11	6
1212	3	26	12	7
1213	1	10	0	0
1213	1	9	1	1
1213	1	8	2	\N
1213	1	7	3	\N
1213	1	6	4	2
1213	1	5	5	\N
1213	1	4	6	\N
1213	2	19	7	\N
1213	2	20	8	\N
1213	2	21	9	3
1213	4	41	10	\N
1213	3	27	11	4
1213	3	26	12	5
1213	3	25	13	6
1220	1	10	0	0
1220	1	9	1	\N
1220	1	8	2	1
1220	3	27	3	\N
1220	3	26	4	2
1220	3	28	5	\N
1220	3	29	6	\N
1220	2	21	7	\N
1220	2	20	8	\N
1220	2	19	9	3
1220	1	4	10	4
1220	1	3	11	5
1241	1	10	0	0
1241	1	9	1	\N
1241	1	8	2	1
1241	3	28	3	\N
1241	3	29	4	2
1241	2	21	5	\N
1241	3	30	6	3
1241	3	31	7	\N
1241	3	32	8	4
1241	3	33	9	\N
1241	4	40	10	5
1241	4	39	11	\N
1241	1	11	12	6
1241	1	12	13	7
1241	1	13	14	8
1251	1	10	0	0
1251	1	9	1	\N
1251	1	8	2	\N
1251	3	28	3	1
1251	3	29	4	\N
1251	2	21	5	2
1251	4	41	6	\N
1251	1	11	7	3
1251	1	12	8	4
1266	1	10	0	0
1266	1	11	1	1
1266	4	38	2	\N
1266	4	37	3	2
1266	4	36	4	\N
1266	4	39	5	3
1266	4	40	6	4
1266	2	21	7	\N
1266	2	20	8	5
1266	2	19	9	6
1266	1	4	10	\N
1266	1	3	11	\N
1266	1	2	12	7
1278	1	10	0	0
1278	1	11	1	\N
1278	4	39	2	1
1278	4	40	3	\N
1278	2	21	4	\N
1278	2	20	5	\N
1278	2	19	6	\N
1278	1	4	7	\N
1278	1	5	8	\N
1278	1	6	9	\N
1278	1	7	10	\N
1278	1	8	11	2
1278	3	28	12	3
1278	2	18	13	4
1280	1	10	0	0
1280	1	11	1	1
1280	4	39	2	2
1280	4	40	3	3
1280	2	21	4	\N
1280	2	20	5	\N
1280	2	19	6	\N
1280	1	4	7	\N
1280	1	5	8	4
1280	1	6	9	\N
1280	1	7	10	5
1280	1	8	11	\N
1280	3	28	12	6
1280	2	18	13	\N
1280	2	17	14	\N
1280	2	16	15	7
1284	1	10	0	0
1284	1	11	1	\N
1284	4	39	2	1
1284	4	40	3	2
1284	2	21	4	\N
1284	2	22	5	\N
1284	2	23	6	\N
1284	3	29	7	3
1290	1	10	0	0
1290	1	11	1	\N
1290	4	39	2	\N
1290	4	40	3	1
1290	2	21	4	2
1290	2	22	5	3
1290	2	23	6	\N
1290	3	29	7	\N
1290	3	28	8	4
1290	1	8	9	5
1290	1	7	10	6
1290	1	6	11	7
1290	1	5	12	8
1290	1	4	13	9
1317	1	11	0	0
1317	1	10	1	1
1317	1	9	2	\N
1317	1	8	3	2
1317	1	7	4	3
1317	1	6	5	\N
1317	1	5	6	\N
1317	1	4	7	4
1317	1	3	8	5
1364	1	11	0	0
1364	1	10	1	1
1364	1	9	2	2
1364	1	8	3	3
1364	3	28	4	4
1364	3	29	5	\N
1364	2	21	6	\N
1364	2	22	7	5
1364	2	23	8	\N
1364	3	30	9	\N
1364	3	31	10	6
1364	3	32	11	7
1364	3	33	12	8
1370	1	11	0	0
1370	1	10	1	\N
1370	1	9	2	1
1370	1	8	3	2
1370	3	28	4	3
1370	3	29	5	4
1370	2	21	6	\N
1370	4	41	7	\N
1370	1	12	8	5
1380	1	11	0	0
1380	4	38	1	1
1380	4	37	2	2
1380	4	36	3	\N
1380	4	39	4	3
1380	4	40	5	4
1380	2	21	6	5
1393	1	11	0	0
1393	4	39	1	1
1393	4	40	2	\N
1393	2	21	3	2
1393	2	20	4	3
1393	2	19	5	4
1393	1	4	6	5
1393	1	5	7	6
1393	1	6	8	\N
1393	1	7	9	7
1393	1	8	10	8
1393	1	9	11	9
1393	3	27	12	10
1402	1	11	0	0
1402	4	39	1	1
1402	4	40	2	2
1402	2	21	3	\N
1402	2	20	4	3
1402	2	19	5	4
1402	1	4	6	\N
1402	2	18	7	\N
1402	2	17	8	5
1402	2	22	9	6
1402	2	23	10	7
1407	1	11	0	0
1407	4	39	1	\N
1407	4	40	2	\N
1407	2	21	3	\N
1407	2	22	4	1
1407	2	23	5	2
1407	3	29	6	3
1407	3	28	7	4
1407	1	8	8	\N
1407	1	7	9	5
1410	1	11	0	0
1410	4	39	1	1
1410	4	40	2	\N
1410	2	21	3	\N
1410	2	22	4	2
1410	2	23	5	3
1410	3	29	6	\N
1410	3	28	7	4
1410	1	8	8	\N
1410	1	7	9	\N
1410	1	6	10	5
1410	1	5	11	\N
1410	1	4	12	6
1412	1	11	0	0
1412	4	39	1	1
1412	4	40	2	2
1412	2	21	3	3
1412	2	22	4	\N
1412	2	23	5	\N
1412	3	29	6	4
1412	3	28	7	5
1412	1	8	8	\N
1412	1	7	9	\N
1412	1	6	10	\N
1412	1	5	11	\N
1412	1	4	12	6
1412	1	3	13	7
1412	1	2	14	8
1418	1	11	0	0
1418	4	39	1	1
1418	4	40	2	\N
1418	2	21	3	2
1418	3	29	4	3
1418	3	28	5	4
1418	1	8	6	5
1418	1	7	7	\N
1418	1	6	8	6
1418	1	5	9	7
1418	1	4	10	\N
1418	2	18	11	8
1418	2	17	12	\N
1418	2	19	13	\N
1418	2	20	14	9
1432	1	12	0	0
1432	1	11	1	\N
1432	1	10	2	1
1448	1	12	0	0
1448	1	11	1	1
1448	1	10	2	\N
1448	1	9	3	2
1448	1	8	4	\N
1448	1	7	5	\N
1448	1	6	6	3
1448	1	5	7	\N
1448	1	4	8	4
1448	2	18	9	\N
1448	2	17	10	\N
1448	2	19	11	\N
1448	2	20	12	5
1448	2	21	13	\N
1448	2	22	14	6
1451	1	12	0	0
1451	1	11	1	1
1451	1	10	2	\N
1451	1	9	3	\N
1451	1	8	4	2
1451	1	7	5	\N
1451	1	6	6	3
1451	1	5	7	\N
1451	1	4	8	\N
1451	2	19	9	4
1451	2	20	10	\N
1451	2	21	11	\N
1451	2	22	12	\N
1451	2	23	13	5
1451	3	29	14	6
1463	1	12	0	0
1463	1	11	1	\N
1463	1	10	2	1
1463	1	9	3	\N
1463	1	8	4	2
1463	1	7	5	\N
1463	1	6	6	\N
1463	1	5	7	\N
1463	1	4	8	3
1463	2	19	9	4
1463	2	20	10	5
1463	2	21	11	\N
1463	4	41	12	6
1463	3	27	13	\N
1463	3	26	14	7
1464	1	12	0	0
1464	1	11	1	\N
1464	1	10	2	\N
1464	1	9	3	\N
1464	1	8	4	1
1464	1	7	5	\N
1464	1	6	6	\N
1464	1	5	7	\N
1464	1	4	8	\N
1464	2	19	9	\N
1464	2	20	10	\N
1464	2	21	11	2
1464	4	41	12	3
1464	3	27	13	4
1464	3	26	14	5
1464	3	25	15	6
1487	1	12	0	0
1487	1	11	1	1
1487	1	10	2	\N
1487	1	9	3	\N
1487	1	8	4	2
1487	3	28	5	3
1487	3	29	6	\N
1487	2	21	7	4
1487	2	22	8	\N
1487	2	23	9	5
1487	3	30	10	6
1487	3	31	11	\N
1487	3	32	12	\N
1487	3	33	13	7
1487	3	34	14	8
1488	1	12	0	0
1488	1	11	1	1
1488	1	10	2	\N
1488	1	9	3	2
1488	1	8	4	3
1488	3	28	5	\N
1488	3	29	6	\N
1488	2	21	7	4
1488	3	30	8	5
1488	3	31	9	\N
1488	3	32	10	6
1488	3	33	11	\N
1488	4	40	12	7
1494	1	12	0	0
1494	1	11	1	1
1494	1	10	2	2
1494	1	9	3	3
1494	1	8	4	4
1494	3	28	5	5
1494	3	29	6	6
1494	2	21	7	\N
1494	4	41	8	7
1494	4	38	9	\N
1494	4	37	10	8
1494	4	36	11	9
1506	1	12	0	0
1506	1	11	1	\N
1506	4	39	2	\N
1506	4	40	3	\N
1506	2	21	4	\N
1506	2	20	5	1
1506	2	19	6	2
1506	1	4	7	3
1506	1	3	8	4
1506	1	2	9	5
1506	1	5	10	\N
1506	1	6	11	6
1508	1	12	0	0
1508	1	11	1	1
1508	4	39	2	\N
1508	4	40	3	2
1508	2	21	4	3
1508	2	20	5	\N
1508	2	19	6	\N
1508	1	4	7	4
1508	1	3	8	5
1508	1	2	9	\N
1508	1	5	10	\N
1508	1	6	11	\N
1508	1	7	12	6
1508	1	8	13	7
1515	1	12	0	0
1515	1	11	1	1
1515	4	39	2	2
1515	4	40	3	\N
1515	2	21	4	\N
1515	2	20	5	3
1515	2	19	6	4
1515	1	4	7	5
1515	1	5	8	\N
1515	1	6	9	6
1515	1	7	10	7
1515	1	8	11	\N
1515	3	27	12	8
1515	3	26	13	9
1515	3	28	14	\N
1515	3	29	15	10
1522	1	12	0	0
1522	1	11	1	\N
1522	4	39	2	\N
1522	4	40	3	1
1522	2	21	4	2
1522	2	22	5	\N
1522	2	23	6	3
1522	3	29	7	4
1535	1	12	0	0
1535	1	11	1	\N
1535	4	39	2	1
1535	4	40	3	\N
1535	2	21	4	\N
1535	3	29	5	2
1535	3	28	6	\N
1535	1	8	7	\N
1535	1	7	8	\N
1535	1	6	9	3
1535	1	5	10	4
1535	1	4	11	\N
1535	2	18	12	5
1535	2	17	13	6
1535	2	19	14	7
1536	1	12	0	0
1536	1	11	1	\N
1536	4	39	2	\N
1536	4	40	3	\N
1536	2	21	4	\N
1536	3	29	5	\N
1536	3	28	6	\N
1536	1	8	7	1
1536	1	7	8	2
1536	1	6	9	3
1536	1	5	10	4
1536	1	4	11	\N
1536	2	18	12	\N
1536	2	17	13	5
1536	2	19	14	6
1536	2	20	15	7
1546	1	12	0	0
1546	1	11	1	1
1546	4	39	2	\N
1546	4	40	3	2
1546	2	21	4	3
1546	3	29	5	4
1546	3	28	6	\N
1546	1	8	7	\N
1546	3	27	8	5
1546	3	26	9	\N
1546	3	30	10	6
1546	3	31	11	\N
1546	3	32	12	\N
1546	3	33	13	\N
1546	3	34	14	7
1547	1	12	0	0
1547	1	11	1	1
1547	4	39	2	\N
1547	4	40	3	2
1547	2	21	4	3
1547	3	30	5	4
1547	3	31	6	5
1547	3	32	7	\N
1547	3	33	8	\N
1547	4	41	9	6
1552	1	13	0	0
1552	1	12	1	1
1556	1	13	0	0
1556	1	12	1	1
1556	1	11	2	2
1556	1	10	3	3
1556	1	9	4	4
1556	1	8	5	5
1562	1	13	0	0
1562	1	12	1	\N
1562	1	11	2	\N
1562	1	10	3	\N
1562	1	9	4	1
1562	1	8	5	\N
1562	1	7	6	2
1562	1	6	7	3
1562	1	5	8	4
1562	1	4	9	\N
1562	1	3	10	5
1562	1	2	11	6
1569	1	13	0	0
1569	1	12	1	\N
1569	1	11	2	\N
1569	1	10	3	\N
1569	1	9	4	1
1569	1	8	5	2
1569	1	7	6	\N
1569	1	6	7	\N
1569	1	5	8	\N
1569	1	4	9	\N
1569	2	18	10	\N
1569	2	17	11	3
1569	2	19	12	4
1569	2	20	13	\N
1569	2	21	14	5
1578	1	13	0	0
1578	1	12	1	\N
1578	1	11	2	\N
1578	1	10	3	1
1578	1	9	4	\N
1578	1	8	5	\N
1578	1	7	6	2
1578	1	6	7	3
1578	1	5	8	4
1578	1	4	9	5
1578	2	19	10	6
1578	2	20	11	7
1578	2	21	12	\N
1578	3	29	13	\N
1578	3	30	14	8
1578	3	31	15	\N
1578	3	32	16	\N
1578	3	33	17	9
1630	1	13	0	0
1630	1	12	1	1
1630	1	11	2	\N
1630	4	39	3	\N
1630	4	40	4	2
1630	2	21	5	3
1630	2	20	6	\N
1630	2	19	7	4
1630	1	4	8	5
1630	1	3	9	6
1630	1	2	10	7
1630	1	5	11	8
1630	1	6	12	\N
1630	1	7	13	\N
1630	1	8	14	9
1646	1	13	0	0
1646	1	12	1	\N
1646	1	11	2	1
1646	4	39	3	\N
1646	4	40	4	2
1646	2	21	5	\N
1646	2	22	6	3
1646	2	23	7	4
1646	3	29	8	5
1646	3	28	9	\N
1646	1	8	10	6
1666	1	13	0	0
1666	1	12	1	1
1666	1	11	2	\N
1666	4	39	3	2
1666	4	40	4	\N
1666	2	21	5	\N
1666	3	29	6	3
1666	3	28	7	4
1666	1	8	8	\N
1666	3	27	9	\N
1666	3	26	10	5
1666	3	30	11	\N
1666	3	31	12	\N
1666	3	32	13	6
1669	1	13	0	0
1669	1	12	1	1
1669	1	11	2	\N
1669	4	39	3	2
1669	4	40	4	3
1669	2	21	5	\N
1669	3	30	6	\N
1669	3	31	7	4
1669	3	32	8	5
1669	3	33	9	6
1669	4	41	10	7
1670	1	13	0	0
1670	1	12	1	\N
1670	1	11	2	\N
1670	4	39	3	1
1670	4	40	4	\N
1670	2	21	5	\N
1670	3	30	6	2
1670	3	31	7	3
1670	3	32	8	4
1670	3	33	9	\N
1670	4	41	10	5
1670	4	42	11	6
1676	1	14	0	0
1676	1	13	1	1
1676	1	12	2	\N
1676	1	11	3	2
1676	1	10	4	3
1677	1	14	0	0
1677	1	13	1	1
1677	1	12	2	\N
1677	1	11	3	2
1677	1	10	4	\N
1677	1	9	5	3
1690	1	14	0	0
1690	1	13	1	1
1690	1	12	2	2
1690	1	11	3	3
1690	1	10	4	4
1690	1	9	5	5
1690	1	8	6	\N
1690	1	7	7	\N
1690	1	6	8	\N
1690	1	5	9	\N
1690	1	4	10	\N
1690	2	18	11	\N
1690	2	17	12	6
1690	2	19	13	\N
1690	2	20	14	7
1697	1	14	0	0
1697	1	13	1	1
1697	1	12	2	2
1697	1	11	3	\N
1697	1	10	4	\N
1697	1	9	5	\N
1697	1	8	6	\N
1697	1	7	7	\N
1697	1	6	8	\N
1697	1	5	9	\N
1697	1	4	10	\N
1697	2	19	11	3
1697	2	20	12	\N
1697	2	21	13	\N
1697	3	29	14	4
1697	3	30	15	5
1704	1	14	0	0
1704	1	13	1	\N
1704	1	12	2	\N
1704	1	11	3	1
1704	1	10	4	2
1704	1	9	5	3
1704	1	8	6	\N
1704	1	7	7	\N
1704	1	6	8	\N
1704	1	5	9	4
1704	1	4	10	5
1704	2	19	11	\N
1704	2	20	12	\N
1704	2	21	13	\N
1704	4	40	14	6
1704	4	41	15	7
1707	1	14	0	0
1707	1	13	1	1
1707	1	12	2	2
1707	1	11	3	\N
1707	1	10	4	3
1707	1	9	5	\N
1707	1	8	6	4
1707	1	7	7	5
1707	1	6	8	\N
1707	1	5	9	6
1707	1	4	10	7
1707	2	19	11	8
1707	2	20	12	9
1707	2	21	13	10
1707	4	41	14	11
1707	3	27	15	\N
1707	3	26	16	12
1713	1	14	0	0
1713	1	13	1	\N
1713	1	12	2	\N
1713	1	11	3	1
1713	1	10	4	\N
1713	1	9	5	\N
1713	1	8	6	\N
1713	3	27	7	2
1713	3	26	8	\N
1713	3	28	9	3
1713	3	29	10	4
1713	2	21	11	\N
1713	2	20	12	\N
1713	2	19	13	5
1746	1	14	0	0
1746	1	13	1	\N
1746	1	12	2	\N
1746	1	11	3	1
1746	4	38	4	\N
1746	4	37	5	\N
1746	4	36	6	\N
1746	4	39	7	\N
1746	4	40	8	2
1746	2	21	9	3
1746	2	20	10	4
1746	2	19	11	5
1746	1	4	12	\N
1746	1	3	13	6
1757	1	14	0	0
1757	1	13	1	1
1757	1	12	2	\N
1757	1	11	3	\N
1757	4	39	4	\N
1757	4	40	5	\N
1757	2	21	6	\N
1757	2	20	7	\N
1757	2	19	8	2
1757	1	4	9	\N
1757	1	5	10	\N
1757	1	6	11	3
1757	1	7	12	\N
1757	1	8	13	4
1757	1	9	14	\N
1757	3	27	15	\N
1757	3	26	16	\N
1757	3	25	17	5
1758	1	14	0	0
1758	1	13	1	\N
1758	1	12	2	1
1758	1	11	3	2
1758	4	39	4	\N
1758	4	40	5	3
1758	2	21	6	\N
1758	2	20	7	4
1758	2	19	8	5
1758	1	4	9	\N
1758	1	5	10	6
1758	1	6	11	7
1758	1	7	12	8
1758	1	8	13	9
1758	3	27	14	10
1758	3	26	15	\N
1758	3	28	16	11
1765	1	14	0	0
1765	1	13	1	\N
1765	1	12	2	1
1765	1	11	3	2
1765	4	39	4	\N
1765	4	40	5	\N
1765	2	21	6	\N
1765	2	20	7	\N
1765	2	19	8	\N
1765	1	4	9	\N
1765	2	18	10	3
1765	2	17	11	4
1765	2	22	12	5
1765	2	23	13	\N
1765	2	24	14	6
1774	1	14	0	0
1774	1	13	1	1
1774	1	12	2	\N
1774	1	11	3	\N
1774	4	39	4	\N
1774	4	40	5	2
1774	2	21	6	\N
1774	2	22	7	\N
1774	2	23	8	3
1774	3	29	9	4
1774	3	28	10	\N
1774	1	8	11	\N
1774	1	7	12	5
1774	1	6	13	6
1774	1	5	14	\N
1774	1	4	15	\N
1774	1	3	16	\N
1774	1	2	17	7
1780	1	14	0	0
1780	1	13	1	\N
1780	1	12	2	\N
1780	1	11	3	\N
1780	4	39	4	1
1780	4	40	5	\N
1780	2	21	6	2
1780	3	29	7	3
1780	3	28	8	\N
1780	1	8	9	4
1780	1	7	10	\N
1780	1	6	11	5
1780	1	5	12	\N
1780	1	4	13	\N
1780	2	18	14	\N
1780	2	17	15	6
1780	2	19	16	\N
1780	2	20	17	7
1781	1	14	0	0
1781	1	13	1	1
1781	1	12	2	\N
1781	1	11	3	2
1781	4	39	4	3
1781	4	40	5	4
1781	2	21	6	\N
1781	3	29	7	\N
1781	3	28	8	\N
1781	1	8	9	\N
1781	1	7	10	5
1781	1	6	11	\N
1781	1	5	12	\N
1781	1	4	13	\N
1781	2	19	14	\N
1781	1	9	15	6
1784	1	14	0	0
1784	1	13	1	1
1784	1	12	2	\N
1784	1	11	3	2
1784	4	39	4	3
1784	4	40	5	\N
1784	2	21	6	4
1784	3	29	7	\N
1784	3	28	8	5
1784	1	8	9	6
1784	1	9	10	\N
1784	3	27	11	\N
1784	3	26	12	7
1793	1	14	0	0
1793	1	13	1	1
1793	1	12	2	\N
1793	1	11	3	\N
1793	4	39	4	2
1793	4	40	5	\N
1793	2	21	6	\N
1793	4	41	7	\N
1793	1	15	8	3
1795	1	15	0	0
1795	1	14	1	1
1795	1	13	2	2
1815	1	15	0	0
1815	1	14	1	\N
1815	1	13	2	\N
1815	1	12	3	1
1815	1	11	4	\N
1815	1	10	5	\N
1815	1	9	6	2
1815	1	8	7	\N
1815	1	7	8	3
1815	1	6	9	\N
1815	1	5	10	4
1815	1	4	11	\N
1815	2	18	12	5
1815	2	17	13	6
1815	2	19	14	7
1815	2	20	15	8
1815	2	21	16	9
1815	2	22	17	10
1815	2	23	18	11
1817	1	15	0	0
1817	1	14	1	\N
1817	1	13	2	\N
1817	1	12	3	\N
1817	1	11	4	\N
1817	1	10	5	1
1817	1	9	6	2
1817	1	8	7	3
1817	1	7	8	4
1817	1	6	9	\N
1817	1	5	10	\N
1817	1	4	11	\N
1817	2	19	12	5
1817	2	20	13	\N
1817	2	21	14	\N
1817	2	22	15	6
1817	2	23	16	7
1817	3	29	17	8
1824	1	15	0	0
1824	1	14	1	\N
1824	1	13	2	\N
1824	1	12	3	1
1824	1	11	4	2
1824	1	10	5	\N
1824	1	9	6	3
1824	1	8	7	4
1824	1	7	8	\N
1824	1	6	9	\N
1824	1	5	10	5
1824	1	4	11	\N
1824	2	19	12	6
1824	2	20	13	7
1824	2	21	14	\N
1824	3	30	15	\N
1824	3	31	16	8
1824	3	32	17	\N
1824	3	33	18	9
1824	4	40	19	10
1830	1	15	0	0
1830	1	14	1	1
1830	1	13	2	\N
1830	1	12	3	2
1830	1	11	4	\N
1830	1	10	5	\N
1830	1	9	6	\N
1830	1	8	7	3
1830	1	7	8	4
1830	1	6	9	5
1830	1	5	10	6
1830	1	4	11	7
1830	2	19	12	8
1830	2	20	13	9
1830	2	21	14	10
1830	4	41	15	11
1830	3	27	16	12
1830	3	26	17	13
1830	3	25	18	14
1840	1	15	0	0
1840	1	14	1	\N
1840	1	13	2	1
1840	1	12	3	2
1840	1	11	4	\N
1840	1	10	5	3
1840	1	9	6	4
1840	1	8	7	\N
1840	3	28	8	5
1840	3	29	9	6
1840	2	21	10	7
1840	2	20	11	8
1840	2	19	12	9
1840	1	4	13	\N
1840	1	3	14	10
1840	1	2	15	11
1840	1	5	16	12
1842	1	15	0	0
1842	1	14	1	\N
1842	1	13	2	1
1842	1	12	3	\N
1842	1	11	4	2
1842	1	10	5	3
1842	1	9	6	\N
1842	1	8	7	4
1842	3	28	8	5
1842	3	29	9	\N
1842	2	21	10	6
1842	2	20	11	7
1842	2	19	12	\N
1842	1	4	13	\N
1842	1	3	14	\N
1842	1	2	15	\N
1842	1	5	16	\N
1842	1	6	17	\N
1842	1	7	18	8
1843	1	15	0	0
1843	1	14	1	1
1843	1	13	2	\N
1843	1	12	3	\N
1843	1	11	4	\N
1843	1	10	5	2
1843	1	9	6	3
1843	1	8	7	4
1843	3	28	8	\N
1843	3	29	9	5
1843	2	21	10	6
1843	2	20	11	\N
1843	2	19	12	\N
1843	1	4	13	\N
1843	1	5	14	\N
1843	1	6	15	\N
1843	2	18	16	7
1844	1	15	0	0
1844	1	14	1	\N
1844	1	13	2	1
1844	1	12	3	2
1844	1	11	4	3
1844	1	10	5	4
1844	1	9	6	5
1844	1	8	7	6
1844	3	28	8	7
1844	3	29	9	\N
1844	2	21	10	\N
1844	2	20	11	\N
1844	2	19	12	8
1844	1	4	13	9
1844	1	5	14	\N
1844	1	6	15	\N
1844	2	18	16	\N
1844	2	17	17	10
1846	1	15	0	0
1846	1	14	1	1
1846	1	13	2	\N
1846	1	12	3	\N
1846	1	11	4	\N
1846	1	10	5	2
1846	1	9	6	3
1846	1	8	7	4
1846	3	28	8	5
1846	3	29	9	\N
1846	2	21	10	\N
1846	2	20	11	6
1846	2	19	12	7
1846	1	4	13	\N
1846	2	18	14	8
1846	2	17	15	\N
1846	2	22	16	9
1858	1	15	0	0
1858	1	14	1	\N
1858	1	13	2	\N
1858	1	12	3	\N
1858	1	11	4	1
1858	1	10	5	\N
1858	1	9	6	2
1858	1	8	7	3
1858	3	28	8	\N
1858	3	29	9	\N
1858	2	21	10	\N
1858	4	41	11	4
1858	4	38	12	5
1871	1	15	0	0
1871	1	14	1	1
1871	1	13	2	2
1871	1	12	3	3
1871	1	11	4	4
1871	4	39	5	\N
1871	4	40	6	5
1871	2	21	7	\N
1871	2	20	8	6
1871	2	19	9	\N
1871	1	4	10	7
1871	1	3	11	8
1871	1	2	12	\N
1871	1	5	13	9
1896	1	15	0	0
1896	1	14	1	\N
1896	1	13	2	1
1896	1	12	3	\N
1896	1	11	4	2
1896	4	39	5	\N
1896	4	40	6	\N
1896	2	21	7	\N
1896	2	22	8	\N
1896	2	23	9	\N
1896	3	29	10	3
1896	3	28	11	4
1896	1	8	12	5
1896	1	7	13	6
1896	1	6	14	\N
1896	1	5	15	\N
1896	1	4	16	7
1896	1	3	17	8
1896	1	2	18	9
1902	1	15	0	0
1902	1	14	1	\N
1902	1	13	2	\N
1902	1	12	3	\N
1902	1	11	4	\N
1902	4	39	5	\N
1902	4	40	6	\N
1902	2	21	7	\N
1902	3	29	8	\N
1902	3	28	9	1
1902	1	8	10	\N
1902	1	7	11	\N
1902	1	6	12	2
1902	1	5	13	\N
1902	1	4	14	\N
1902	2	18	15	\N
1902	2	17	16	\N
1902	2	19	17	\N
1902	2	20	18	3
1906	1	15	0	0
1906	1	14	1	1
1906	1	13	2	\N
1906	1	12	3	\N
1906	1	11	4	\N
1906	4	39	5	2
1906	4	40	6	\N
1906	2	21	7	3
1906	3	29	8	4
1906	3	28	9	5
1906	1	8	10	\N
1906	1	9	11	6
1906	3	27	12	7
1906	3	26	13	8
1926	2	16	0	0
1926	2	17	1	\N
1926	2	18	2	\N
1926	1	4	3	1
1926	1	3	4	2
1926	1	2	5	3
1926	1	5	6	\N
1926	1	6	7	4
1926	1	7	8	\N
1926	1	8	9	\N
1926	1	9	10	5
1926	1	10	11	6
1930	2	16	0	0
1930	2	17	1	1
1930	2	18	2	\N
1930	1	4	3	2
1930	1	3	4	\N
1930	1	2	5	3
1930	1	5	6	\N
1930	1	6	7	4
1930	1	7	8	\N
1930	1	8	9	5
1930	1	9	10	6
1930	1	10	11	\N
1930	1	11	12	7
1930	1	12	13	\N
1930	1	13	14	8
1930	1	14	15	9
1940	2	16	0	0
1940	2	17	1	\N
1940	2	18	2	1
1940	1	4	3	2
1940	1	5	4	3
1940	1	6	5	4
1940	1	7	6	\N
1940	1	8	7	\N
1940	1	9	8	5
1940	1	10	9	6
1940	1	11	10	\N
1940	4	38	11	\N
1940	4	37	12	\N
1940	4	36	13	\N
1940	4	39	14	\N
1940	4	40	15	7
1940	2	21	16	\N
1940	2	20	17	8
1940	2	19	18	9
1953	2	16	0	0
1953	2	17	1	1
1953	2	18	2	2
1953	1	4	3	3
1953	1	5	4	\N
1953	1	6	5	\N
1953	1	7	6	\N
1953	1	8	7	4
1953	1	9	8	\N
1953	1	10	9	\N
1953	1	11	10	5
1953	4	39	11	6
1953	4	40	12	\N
1953	2	21	13	\N
1953	4	41	14	7
1953	3	27	15	8
1961	2	16	0	0
1961	2	17	1	1
1961	2	18	2	2
1961	1	4	3	\N
1961	1	5	4	\N
1961	1	6	5	3
1961	1	7	6	4
1961	1	8	7	5
1961	3	28	8	\N
1961	3	29	9	6
1961	2	21	10	\N
1961	2	20	11	7
1961	2	22	12	8
1975	2	16	0	0
1975	2	17	1	\N
1975	2	18	2	1
1975	1	4	3	\N
1975	1	5	4	\N
1975	1	6	5	2
1975	1	7	6	3
1975	1	8	7	\N
1975	3	28	8	\N
1975	3	29	9	4
1975	2	21	10	5
1975	4	40	11	\N
1975	4	39	12	6
1975	1	11	13	\N
1975	1	10	14	\N
1975	1	12	15	\N
1975	1	13	16	7
2046	2	17	0	0
2046	2	18	1	\N
2046	1	4	2	1
2046	1	5	3	2
2046	1	6	4	3
2046	1	7	5	\N
2046	1	8	6	4
2046	3	28	7	\N
2046	3	29	8	\N
2046	2	21	9	5
2046	4	40	10	6
2046	4	39	11	7
2046	1	11	12	\N
2046	1	10	13	\N
2046	1	12	14	\N
2046	1	13	15	8
2048	2	17	0	0
2048	2	18	1	\N
2048	1	4	2	1
2048	1	5	3	2
2048	1	6	4	\N
2048	1	7	5	3
2048	1	8	6	\N
2048	3	28	7	\N
2048	3	29	8	\N
2048	2	21	9	4
2048	4	40	10	\N
2048	4	39	11	\N
2048	1	11	12	5
2048	1	10	13	\N
2048	1	12	14	\N
2048	1	13	15	\N
2048	1	14	16	\N
2048	1	15	17	6
2052	2	17	0	0
2052	2	18	1	1
2052	1	4	2	2
2052	1	5	3	\N
2052	1	6	4	3
2052	1	7	5	4
2052	1	8	6	\N
2052	3	28	7	\N
2052	3	29	8	\N
2052	2	21	9	\N
2052	4	40	10	5
2052	4	39	11	6
2052	1	11	12	\N
2052	1	12	13	\N
2052	1	13	14	\N
2052	1	14	15	\N
2052	4	38	16	\N
2052	4	37	17	7
2052	4	36	18	8
2052	4	35	19	9
2062	2	18	0	0
2062	1	4	1	\N
2062	1	3	2	1
2062	1	2	3	2
2062	1	5	4	3
2062	1	6	5	4
2064	2	18	0	0
2064	1	4	1	1
2064	1	3	2	\N
2064	1	2	3	2
2064	1	5	4	\N
2064	1	6	5	\N
2064	1	7	6	3
2064	1	8	7	4
2068	2	18	0	0
2068	1	4	1	1
2068	1	3	2	2
2068	1	2	3	\N
2068	1	5	4	\N
2068	1	6	5	\N
2068	1	7	6	\N
2068	1	8	7	\N
2068	1	9	8	\N
2068	1	10	9	3
2068	1	11	10	\N
2068	1	12	11	4
2071	2	18	0	0
2071	1	4	1	1
2071	1	3	2	\N
2071	1	2	3	\N
2071	1	5	4	2
2071	1	6	5	3
2071	1	7	6	\N
2071	1	8	7	4
2071	1	9	8	5
2071	1	10	9	\N
2071	1	11	10	6
2071	1	12	11	\N
2071	1	13	12	7
2071	1	14	13	\N
2071	1	15	14	8
2074	2	18	0	0
2074	1	4	1	1
2074	1	5	2	2
2074	1	6	3	3
2074	1	7	4	4
2074	1	8	5	5
2074	1	9	6	\N
2074	1	10	7	6
2074	1	11	8	7
2074	1	12	9	8
2074	1	13	10	\N
2074	1	14	11	9
2074	4	38	12	\N
2074	4	37	13	10
2074	4	36	14	11
2080	2	18	0	0
2080	1	4	1	\N
2080	1	5	2	1
2080	1	6	3	2
2080	1	7	4	3
2080	1	8	5	\N
2080	1	9	6	4
2080	1	10	7	\N
2080	1	11	8	5
2080	4	38	9	6
2080	4	37	10	7
2080	4	36	11	\N
2080	4	39	12	8
2080	4	40	13	9
2080	2	21	14	10
2080	2	20	15	\N
2080	2	19	16	11
2098	2	18	0	0
2098	1	4	1	1
2098	1	5	2	\N
2098	1	6	3	\N
2098	1	7	4	2
2098	1	8	5	\N
2098	3	27	6	\N
2098	3	26	7	3
2098	3	28	8	\N
2098	3	29	9	4
2098	2	21	10	5
2101	2	18	0	0
2101	1	4	1	1
2101	1	5	2	2
2101	1	6	3	3
2101	1	7	4	\N
2101	1	8	5	\N
2101	3	28	6	\N
2101	3	29	7	\N
2101	2	21	8	\N
2101	2	20	9	\N
2101	2	22	10	4
2102	2	18	0	0
2102	1	4	1	\N
2102	1	5	2	\N
2102	1	6	3	1
2102	1	7	4	\N
2102	1	8	5	2
2102	3	28	6	3
2102	3	29	7	\N
2102	2	21	8	4
2102	2	20	9	\N
2102	2	22	10	5
2102	2	23	11	6
2106	2	18	0	0
2106	1	4	1	\N
2106	1	5	2	1
2106	1	6	3	\N
2106	1	7	4	2
2106	1	8	5	\N
2106	3	28	6	\N
2106	3	29	7	\N
2106	2	21	8	3
2106	2	22	9	\N
2106	2	23	10	4
2106	3	30	11	5
2106	3	31	12	6
2106	3	32	13	7
2107	2	18	0	0
2107	1	4	1	1
2107	1	5	2	2
2107	1	6	3	\N
2107	1	7	4	\N
2107	1	8	5	\N
2107	3	28	6	\N
2107	3	29	7	\N
2107	2	21	8	\N
2107	2	22	9	\N
2107	2	23	10	\N
2107	3	30	11	\N
2107	3	31	12	\N
2107	3	32	13	3
2107	3	33	14	4
2144	2	19	0	0
2144	1	4	1	\N
2144	1	5	2	\N
2144	1	6	3	\N
2144	1	7	4	\N
2144	1	8	5	1
2144	1	9	6	2
2144	1	10	7	3
2144	1	11	8	4
2144	1	12	9	5
2144	1	13	10	6
2144	1	14	11	7
2144	4	38	12	8
2144	4	37	13	9
2162	2	19	0	0
2162	1	4	1	1
2162	1	5	2	\N
2162	1	6	3	2
2162	1	7	4	\N
2162	1	8	5	\N
2162	1	9	6	3
2162	1	10	7	4
2162	1	11	8	\N
2162	4	39	9	5
2162	4	40	10	6
2162	2	21	11	\N
2162	3	30	12	\N
2162	3	31	13	\N
2162	3	32	14	\N
2162	3	33	15	7
2162	4	41	16	\N
2162	4	42	17	8
2164	2	19	0	0
2164	1	4	1	1
2164	1	5	2	2
2164	1	6	3	\N
2164	1	7	4	\N
2164	1	8	5	3
2164	1	9	6	\N
2164	1	10	7	4
2164	1	11	8	5
2164	4	39	9	6
2164	4	40	10	\N
2164	2	21	11	\N
2164	4	41	12	\N
2164	3	27	13	\N
2164	3	26	14	7
2175	2	19	0	0
2175	1	4	1	1
2175	1	5	2	2
2175	1	6	3	3
2175	1	7	4	4
2175	1	8	5	5
2175	3	28	6	\N
2175	3	29	7	\N
2175	2	21	8	\N
2175	2	22	9	6
2175	2	23	10	7
2175	3	30	11	8
2175	3	31	12	9
2175	3	32	13	10
2185	2	19	0	0
2185	1	4	1	1
2185	1	5	2	2
2185	1	6	3	\N
2185	1	7	4	3
2185	1	8	5	\N
2185	3	28	6	\N
2185	3	29	7	\N
2185	2	21	8	\N
2185	4	40	9	4
2185	4	39	10	\N
2185	1	11	11	5
2185	1	10	12	\N
2185	1	12	13	6
2185	1	13	14	\N
2185	1	14	15	7
2186	2	19	0	0
2186	1	4	1	\N
2186	1	5	2	1
2186	1	6	3	2
2186	1	7	4	3
2186	1	8	5	\N
2186	3	28	6	\N
2186	3	29	7	4
2186	2	21	8	\N
2186	4	40	9	\N
2186	4	39	10	5
2186	1	11	11	6
2186	1	10	12	\N
2186	1	12	13	\N
2186	1	13	14	7
2186	1	14	15	8
2186	1	15	16	9
2190	2	19	0	0
2190	1	4	1	1
2190	1	5	2	\N
2190	1	6	3	\N
2190	1	7	4	2
2190	1	8	5	3
2190	3	28	6	4
2190	3	29	7	5
2190	2	21	8	\N
2190	4	40	9	\N
2190	4	39	10	\N
2190	1	11	11	\N
2190	1	12	12	\N
2190	1	13	13	6
2190	1	14	14	\N
2190	4	38	15	7
2190	4	37	16	\N
2190	4	36	17	8
2190	4	35	18	9
2195	2	19	0	0
2195	1	4	1	1
2195	1	5	2	\N
2195	1	6	3	\N
2195	1	7	4	2
2195	1	8	5	3
2195	3	28	6	\N
2195	3	29	7	4
2195	2	21	8	5
2195	4	41	9	\N
2195	2	18	10	\N
2195	2	17	11	\N
2195	2	16	12	6
2201	2	19	0	0
2201	2	20	1	\N
2201	2	21	2	1
2201	2	22	3	\N
2201	2	23	4	2
2201	3	29	5	3
2205	2	19	0	0
2205	2	20	1	1
2205	2	21	2	2
2205	2	22	3	3
2205	2	23	4	4
2205	3	29	5	\N
2205	3	28	6	5
2205	1	8	7	6
2205	1	7	8	\N
2205	1	6	9	7
2206	2	19	0	0
2206	2	20	1	1
2206	2	21	2	\N
2206	2	22	3	\N
2206	2	23	4	2
2206	3	29	5	3
2206	3	28	6	\N
2206	1	8	7	\N
2206	1	7	8	4
2206	1	6	9	5
2206	1	5	10	6
2208	2	19	0	0
2208	2	20	1	\N
2208	2	21	2	1
2208	2	22	3	\N
2208	2	23	4	2
2208	3	29	5	\N
2208	3	28	6	\N
2208	1	8	7	\N
2208	1	7	8	\N
2208	1	6	9	3
2208	1	5	10	4
2208	1	4	11	5
2208	1	3	12	6
2223	2	19	0	0
2223	2	20	1	1
2223	2	21	2	2
2223	3	29	3	\N
2223	3	28	4	\N
2223	1	8	5	\N
2223	1	9	6	\N
2223	1	10	7	3
2223	1	11	8	\N
2223	1	12	9	4
2223	1	13	10	5
2223	1	14	11	6
2223	4	38	12	7
2223	4	37	13	8
2223	4	36	14	9
2227	2	19	0	0
2227	2	20	1	1
2227	2	21	2	2
2227	3	29	3	\N
2227	3	28	4	\N
2227	1	8	5	3
2227	1	9	6	\N
2227	1	10	7	\N
2227	1	11	8	\N
2227	4	39	9	\N
2227	3	27	10	4
2259	2	19	0	0
2259	2	20	1	\N
2259	2	21	2	\N
2259	4	40	3	\N
2259	4	39	4	1
2259	1	11	5	2
2259	1	10	6	3
2259	1	9	7	\N
2259	1	8	8	\N
2259	3	28	9	4
2259	1	12	10	\N
2259	1	13	11	5
2259	1	14	12	6
2259	1	15	13	7
2274	2	20	0	0
2274	2	19	1	\N
2274	1	4	2	\N
2274	1	3	3	\N
2274	1	2	4	\N
2274	1	5	5	\N
2274	1	6	6	1
2274	1	7	7	\N
2274	1	8	8	2
2280	2	20	0	0
2280	2	19	1	1
2280	1	4	2	2
2280	1	3	3	3
2280	1	2	4	4
2280	1	5	5	5
2280	1	6	6	\N
2280	1	7	7	6
2280	1	8	8	\N
2280	1	9	9	\N
2280	1	10	10	\N
2280	1	11	11	\N
2280	1	12	12	7
2280	1	13	13	\N
2280	1	14	14	8
2299	2	20	0	0
2299	2	19	1	\N
2299	1	4	2	1
2299	1	5	3	\N
2299	1	6	4	\N
2299	1	7	5	2
2299	1	8	6	\N
2299	1	9	7	3
2299	1	10	8	\N
2299	1	11	9	\N
2299	4	39	10	4
2299	4	40	11	\N
2299	2	21	12	\N
2299	3	30	13	\N
2299	3	31	14	\N
2299	3	32	15	\N
2299	3	33	16	\N
2299	4	41	17	5
2308	2	20	0	0
2308	2	19	1	1
2308	1	4	2	2
2308	1	5	3	3
2308	1	6	4	\N
2308	1	7	5	\N
2308	1	8	6	4
2308	3	27	7	5
2308	3	26	8	\N
2308	3	28	9	\N
2308	3	29	10	6
2308	2	21	11	\N
2308	2	22	12	\N
2308	2	23	13	7
2316	2	20	0	0
2316	2	19	1	1
2316	1	4	2	\N
2316	1	5	3	\N
2316	1	6	4	\N
2316	1	7	5	\N
2316	1	8	6	\N
2316	3	28	7	\N
2316	3	29	8	\N
2316	2	21	9	2
2316	3	30	10	3
2316	3	31	11	\N
2316	3	32	12	4
2316	3	33	13	\N
2316	4	40	14	\N
2316	4	39	15	5
2322	2	20	0	0
2322	2	19	1	1
2322	1	4	2	2
2322	1	5	3	3
2322	1	6	4	4
2322	1	7	5	\N
2322	1	8	6	\N
2322	3	28	7	5
2322	3	29	8	6
2322	2	21	9	\N
2322	4	40	10	7
2322	4	39	11	8
2322	1	11	12	\N
2322	1	10	13	9
2322	1	12	14	\N
2322	1	13	15	10
2322	1	14	16	11
2346	2	20	0	0
2346	2	21	1	\N
2346	2	22	2	1
2346	2	23	3	2
2346	3	29	4	\N
2346	3	28	5	\N
2346	1	8	6	\N
2346	1	7	7	\N
2346	1	6	8	3
2346	1	5	9	\N
2346	1	4	10	4
2346	1	3	11	5
2346	1	2	12	6
2346	1	1	13	7
2347	2	20	0	0
2347	2	21	1	1
2347	3	29	2	\N
2347	3	28	3	2
2347	1	8	4	3
2347	1	7	5	4
2347	1	6	6	\N
2347	1	5	7	\N
2347	1	4	8	\N
2347	1	3	9	\N
2347	1	2	10	5
2347	2	18	11	6
2361	2	20	0	0
2361	2	21	1	\N
2361	3	29	2	1
2361	3	28	3	\N
2361	1	8	4	2
2361	1	9	5	\N
2361	1	10	6	3
2361	1	11	7	4
2361	1	12	8	5
2361	1	13	9	6
2361	1	14	10	\N
2361	4	38	11	\N
2361	4	37	12	7
2361	4	36	13	8
2361	4	35	14	9
2376	2	20	0	0
2376	2	21	1	\N
2376	3	30	2	1
2376	3	31	3	\N
2376	3	32	4	2
2376	3	33	5	3
2376	4	40	6	4
2376	4	39	7	\N
2376	1	11	8	\N
2376	1	10	9	\N
2376	1	9	10	5
2401	2	20	0	0
2401	2	21	1	\N
2401	4	40	2	1
2401	4	39	3	2
2401	1	11	4	\N
2401	1	12	5	\N
2401	1	13	6	\N
2401	1	14	7	\N
2401	4	38	8	\N
2401	4	37	9	3
2401	4	36	10	\N
2401	4	35	11	4
2409	2	21	0	0
2409	2	20	1	1
2409	2	19	2	2
2409	1	4	3	3
2409	1	3	4	4
2409	1	2	5	\N
2409	1	1	6	5
2419	2	21	0	0
2419	2	20	1	1
2419	2	19	2	2
2419	1	4	3	\N
2419	1	3	4	\N
2419	1	2	5	3
2419	1	5	6	4
2419	1	6	7	\N
2419	1	7	8	\N
2419	1	8	9	\N
2419	1	9	10	5
2419	1	10	11	\N
2419	1	11	12	6
2419	1	12	13	7
2419	1	13	14	\N
2419	1	14	15	8
2426	2	21	0	0
2426	2	20	1	\N
2426	2	19	2	\N
2426	1	4	3	\N
2426	1	5	4	\N
2426	1	6	5	1
2426	1	7	6	2
2426	1	8	7	3
2426	1	9	8	\N
2426	1	10	9	4
2426	1	11	10	5
2426	4	38	11	\N
2426	4	37	12	\N
2426	4	36	13	\N
2426	4	39	14	6
2426	4	40	15	7
2429	2	21	0	0
2429	2	20	1	1
2429	2	19	2	2
2429	1	4	3	3
2429	1	5	4	4
2429	1	6	5	5
2429	1	7	6	6
2429	1	8	7	\N
2429	1	9	8	7
2429	1	10	9	\N
2429	1	11	10	8
2429	4	39	11	9
2429	3	27	12	\N
2429	3	26	13	10
2429	3	25	14	11
2435	2	21	0	0
2435	2	20	1	1
2435	2	19	2	\N
2435	1	4	3	2
2435	2	18	4	3
2435	2	17	5	\N
2435	2	22	6	4
2440	2	21	0	0
2440	2	22	1	1
2440	2	23	2	\N
2440	3	29	3	2
2440	3	28	4	3
2440	1	8	5	4
2448	2	21	0	0
2448	3	29	1	1
2448	3	28	2	\N
2448	1	8	3	\N
2448	1	7	4	\N
2448	1	6	5	2
2448	1	5	6	3
2448	1	4	7	\N
2448	1	3	8	4
2448	1	2	9	\N
2448	2	18	10	5
2450	2	21	0	0
2450	3	29	1	\N
2450	3	28	2	\N
2450	1	8	3	\N
2450	1	7	4	1
2450	1	6	5	2
2450	1	5	6	\N
2450	1	4	7	\N
2450	1	3	8	3
2450	1	2	9	\N
2450	2	18	10	\N
2450	2	17	11	\N
2450	2	16	12	4
2481	2	21	0	0
2481	3	30	1	\N
2481	3	31	2	1
2481	3	32	3	\N
2481	3	33	4	2
2481	4	40	5	3
2481	4	39	6	4
2481	1	11	7	\N
2481	1	10	8	\N
2481	1	9	9	\N
2481	1	8	10	\N
2481	1	7	11	5
2481	1	6	12	6
2504	2	21	0	0
2504	4	40	1	1
2504	4	39	2	\N
2504	1	11	3	\N
2504	1	12	4	2
2504	1	13	5	3
2504	1	14	6	\N
2504	4	38	7	4
2504	4	37	8	\N
2504	4	36	9	5
2504	4	35	10	6
2517	2	22	0	0
2517	2	21	1	\N
2517	2	20	2	\N
2517	2	19	3	\N
2517	1	4	4	1
2517	1	3	5	2
2517	1	2	6	\N
2517	1	5	7	3
2517	1	6	8	4
2517	1	7	9	5
2517	1	8	10	6
2519	2	22	0	0
2519	2	21	1	1
2519	2	20	2	2
2519	2	19	3	\N
2519	1	4	4	\N
2519	1	3	5	3
2519	1	2	6	4
2519	1	5	7	5
2519	1	6	8	6
2519	1	7	9	\N
2519	1	8	10	\N
2519	1	9	11	\N
2519	1	10	12	7
2539	2	22	0	0
2539	2	21	1	1
2539	2	20	2	2
2539	2	19	3	3
2539	1	4	4	4
2539	2	18	5	5
2539	2	17	6	6
2539	3	29	7	7
2542	2	22	0	0
2542	2	21	1	\N
2542	2	20	2	\N
2542	2	19	3	\N
2542	1	4	4	\N
2542	2	18	5	\N
2542	2	17	6	1
2542	3	29	7	2
2542	3	28	8	3
2542	1	8	9	4
2542	1	7	10	5
2543	2	22	0	0
2543	2	21	1	1
2543	2	20	2	\N
2543	2	19	3	\N
2543	1	4	4	\N
2543	2	18	5	\N
2543	2	17	6	\N
2543	3	29	7	2
2543	3	28	8	3
2543	1	8	9	4
2543	1	7	10	5
2543	1	6	11	6
2557	2	22	0	0
2557	2	21	1	1
2557	3	29	2	\N
2557	3	28	3	\N
2557	1	8	4	2
2557	1	9	5	\N
2557	1	10	6	3
2557	1	11	7	4
2557	4	38	8	\N
2557	4	37	9	\N
2557	4	36	10	5
2557	4	39	11	\N
2557	4	40	12	6
2569	2	22	0	0
2569	2	21	1	1
2569	3	30	2	2
2569	3	31	3	\N
2569	3	32	4	3
2569	3	33	5	\N
2569	4	40	6	4
2569	4	39	7	5
2569	1	11	8	6
2569	1	10	9	7
2571	2	22	0	0
2571	2	21	1	1
2571	3	30	2	\N
2571	3	31	3	\N
2571	3	32	4	\N
2571	3	33	5	2
2571	4	40	6	3
2571	4	39	7	\N
2571	1	11	8	\N
2571	1	10	9	4
2571	1	9	10	5
2571	1	8	11	6
2610	2	23	0	0
2610	2	22	1	\N
2610	2	21	2	1
2610	2	20	3	2
2610	2	19	4	3
2610	1	4	5	\N
2610	1	3	6	4
2610	1	2	7	\N
2610	1	5	8	\N
2610	1	6	9	5
2641	2	23	0	0
2641	2	22	1	\N
2641	2	21	2	\N
2641	3	29	3	1
2641	3	28	4	2
2641	1	8	5	3
2641	1	7	6	\N
2641	1	6	7	4
2641	1	9	8	5
2641	1	10	9	6
2655	2	23	0	0
2655	2	22	1	\N
2655	2	21	2	1
2655	3	29	3	2
2655	3	28	4	\N
2655	1	8	5	\N
2655	1	9	6	\N
2655	1	10	7	3
2655	1	11	8	4
2655	4	39	9	\N
2655	3	27	10	5
2655	3	26	11	6
2655	3	25	12	7
2656	2	23	0	0
2656	2	22	1	1
2656	2	21	2	2
2656	3	29	3	3
2656	3	28	4	\N
2656	1	8	5	\N
2656	3	27	6	\N
2656	3	26	7	4
2656	3	30	8	5
2659	2	23	0	0
2659	2	22	1	1
2659	2	21	2	2
2659	3	29	3	3
2659	3	28	4	4
2659	1	8	5	\N
2659	3	27	6	\N
2659	3	26	7	5
2659	3	30	8	6
2659	3	31	9	\N
2659	3	32	10	\N
2659	3	33	11	7
2660	2	23	0	0
2660	2	22	1	\N
2660	2	21	2	\N
2660	3	29	3	1
2660	3	28	4	2
2660	1	8	5	\N
2660	3	27	6	\N
2660	3	26	7	3
2660	3	30	8	\N
2660	3	31	9	4
2660	3	32	10	\N
2660	3	33	11	5
2660	3	34	12	6
2661	2	23	0	0
2661	2	22	1	\N
2661	2	21	2	1
2661	3	30	3	\N
2661	3	31	4	2
2661	3	32	5	\N
2661	3	33	6	\N
2661	4	40	7	3
2666	2	23	0	0
2666	2	22	1	1
2666	2	21	2	2
2666	3	30	3	3
2666	3	31	4	\N
2666	3	32	5	4
2666	3	33	6	5
2666	4	40	7	6
2666	4	39	8	7
2666	1	11	9	\N
2666	1	10	10	8
2666	1	9	11	\N
2666	1	8	12	9
2694	2	23	0	0
2694	2	22	1	1
2694	2	21	2	2
2694	4	41	3	3
2694	2	24	4	4
2695	2	24	0	0
2695	2	23	1	1
2702	2	24	0	0
2702	2	23	1	1
2702	2	22	2	\N
2702	2	21	3	2
2702	2	20	4	3
2702	2	19	5	\N
2702	1	4	6	4
2702	1	3	7	5
2702	1	2	8	6
2712	2	24	0	0
2712	2	23	1	1
2712	2	22	2	\N
2712	2	21	3	\N
2712	2	20	4	2
2712	2	19	5	\N
2712	1	4	6	3
2712	1	3	7	4
2712	1	2	8	5
2712	1	5	9	\N
2712	1	6	10	\N
2712	1	7	11	6
2712	1	8	12	\N
2712	1	9	13	\N
2712	1	10	14	7
2712	1	11	15	\N
2712	1	12	16	\N
2712	1	13	17	8
2717	2	24	0	0
2717	2	23	1	\N
2717	2	22	2	\N
2717	2	21	3	1
2717	2	20	4	\N
2717	2	19	5	\N
2717	1	4	6	2
2717	1	5	7	3
2717	1	6	8	4
2717	1	7	9	5
2717	1	8	10	6
2717	1	9	11	\N
2717	1	10	12	7
2717	1	11	13	8
2717	1	12	14	\N
2717	1	13	15	\N
2717	1	14	16	9
2717	4	38	17	10
2717	4	37	18	\N
2717	4	36	19	11
2720	2	24	0	0
2720	2	23	1	\N
2720	2	22	2	1
2720	2	21	3	2
2720	2	20	4	\N
2720	2	19	5	3
2720	1	4	6	\N
2720	1	5	7	\N
2720	1	6	8	4
2720	1	7	9	\N
2720	1	8	10	5
2720	1	9	11	6
2720	1	10	12	7
2720	1	11	13	8
2720	4	38	14	\N
2720	4	37	15	9
2720	4	36	16	10
2720	4	39	17	11
2720	4	40	18	12
2731	2	24	0	0
2731	2	23	1	1
2731	2	22	2	2
2731	2	21	3	\N
2731	2	20	4	3
2731	2	19	5	\N
2731	1	4	6	\N
2731	2	18	7	4
2731	2	17	8	5
2731	3	29	9	\N
2731	3	28	10	\N
2731	1	8	11	6
2744	2	24	0	0
2744	2	23	1	1
2744	2	22	2	\N
2744	2	21	3	\N
2744	3	29	4	\N
2744	3	28	5	\N
2744	1	8	6	2
2744	1	9	7	3
2744	1	10	8	\N
2744	1	11	9	4
2744	1	12	10	\N
2744	1	13	11	\N
2744	1	14	12	\N
2744	4	38	13	\N
2744	4	37	14	5
2744	4	36	15	6
2751	2	24	0	0
2751	2	23	1	\N
2751	2	22	2	\N
2751	2	21	3	\N
2751	3	29	4	1
2751	3	28	5	2
2751	1	8	6	3
2751	3	27	7	4
2751	3	26	8	\N
2751	3	30	9	5
2752	2	24	0	0
2752	2	23	1	1
2752	2	22	2	\N
2752	2	21	3	2
2752	3	29	4	3
2752	3	28	5	4
2752	1	8	6	\N
2752	3	27	7	5
2752	3	26	8	\N
2752	3	30	9	\N
2752	3	31	10	6
2789	3	25	0	0
2789	3	26	1	1
2792	3	25	0	0
2792	3	26	1	1
2792	3	27	2	2
2792	1	8	3	3
2792	1	7	4	4
2806	3	25	0	0
2806	3	26	1	1
2806	3	27	2	\N
2806	1	8	3	\N
2806	1	7	4	\N
2806	1	6	5	2
2806	1	5	6	\N
2806	1	4	7	\N
2806	2	18	8	\N
2806	2	17	9	3
2806	2	19	10	4
2806	2	20	11	\N
2806	2	21	12	5
2806	2	22	13	6
2806	2	23	14	7
2810	3	25	0	0
2810	3	26	1	\N
2810	3	27	2	1
2810	1	8	3	2
2810	1	7	4	\N
2810	1	6	5	\N
2810	1	5	6	3
2810	1	4	7	\N
2810	2	19	8	\N
2810	2	20	9	4
2810	2	21	10	5
2810	3	29	11	6
2810	3	30	12	7
2817	3	25	0	0
2817	3	26	1	\N
2817	3	27	2	1
2817	1	8	3	\N
2817	1	7	4	2
2817	1	6	5	3
2817	1	5	6	\N
2817	1	4	7	4
2817	2	19	8	5
2817	2	20	9	6
2817	2	21	10	\N
2817	3	30	11	7
2817	3	31	12	8
2817	3	32	13	\N
2817	3	33	14	9
2817	4	40	15	\N
2817	4	39	16	10
2817	1	11	17	11
2830	3	25	0	0
2830	3	26	1	\N
2830	3	27	2	\N
2830	1	8	3	1
2830	1	7	4	2
2830	1	6	5	3
2830	1	5	6	4
2830	1	4	7	5
2830	2	19	8	6
2830	2	20	9	7
2830	2	21	10	\N
2830	4	41	11	\N
2830	1	9	12	8
2838	3	25	0	0
2838	3	26	1	1
2838	3	27	2	2
2838	1	8	3	3
2838	1	9	4	\N
2838	1	10	5	\N
2838	1	11	6	\N
2838	1	12	7	\N
2838	1	13	8	\N
2838	1	14	9	\N
2838	4	38	10	\N
2838	4	37	11	4
2840	3	25	0	0
2840	3	26	1	\N
2840	3	27	2	\N
2840	1	8	3	\N
2840	1	9	4	1
2840	1	10	5	\N
2840	1	11	6	\N
2840	1	12	7	2
2840	1	13	8	3
2840	1	14	9	\N
2840	4	38	10	4
2840	4	37	11	\N
2840	4	36	12	\N
2840	4	35	13	5
2854	3	25	0	0
2854	3	26	1	1
2854	3	27	2	2
2854	1	8	3	\N
2854	1	9	4	\N
2854	1	10	5	3
2854	1	11	6	4
2854	4	39	7	\N
2854	4	40	8	\N
2854	2	21	9	5
2854	2	20	10	\N
2854	2	19	11	\N
2854	1	4	12	\N
2854	1	5	13	\N
2854	1	6	14	6
2854	2	18	15	7
2854	2	17	16	8
2860	3	25	0	0
2860	3	26	1	\N
2860	3	27	2	\N
2860	1	8	3	1
2860	1	9	4	\N
2860	1	10	5	\N
2860	1	11	6	2
2860	4	39	7	\N
2860	4	40	8	3
2860	2	21	9	\N
2860	2	22	10	\N
2860	2	23	11	\N
2860	3	29	12	4
2860	3	28	13	5
2884	3	26	0	0
2884	3	27	1	1
2884	1	8	2	\N
2884	1	7	3	2
2884	1	6	4	\N
2884	1	5	5	3
2884	1	4	6	4
2884	2	18	7	\N
2884	2	17	8	5
2884	2	19	9	6
2884	2	20	10	7
2886	3	26	0	0
2886	3	27	1	\N
2886	1	8	2	\N
2886	1	7	3	1
2886	1	6	4	2
2886	1	5	5	3
2886	1	4	6	4
2886	2	18	7	\N
2886	2	17	8	\N
2886	2	19	9	\N
2886	2	20	10	\N
2886	2	21	11	5
2886	2	22	12	6
2888	3	26	0	0
2888	3	27	1	1
2888	1	8	2	\N
2888	1	7	3	2
2888	1	6	4	3
2888	1	5	5	4
2888	1	4	6	5
2888	2	18	7	6
2888	2	17	8	\N
2888	2	19	9	\N
2888	2	20	10	\N
2888	2	21	11	\N
2888	2	22	12	\N
2888	2	23	13	7
2888	2	24	14	8
2890	3	26	0	0
2890	3	27	1	1
2890	1	8	2	2
2890	1	7	3	\N
2890	1	6	4	\N
2890	1	5	5	3
2890	1	4	6	\N
2890	2	19	7	4
2890	2	20	8	\N
2890	2	21	9	\N
2890	2	22	10	5
2890	2	23	11	\N
2890	3	29	12	\N
2890	3	28	13	6
2904	3	26	0	0
2904	3	27	1	\N
2904	1	8	2	1
2904	1	7	3	2
2904	1	6	4	3
2904	1	5	5	\N
2904	1	4	6	\N
2904	2	19	7	\N
2904	2	20	8	4
2904	2	21	9	5
2904	4	40	10	\N
2904	4	39	11	6
2904	1	11	12	\N
2904	1	10	13	7
2904	1	12	14	\N
2904	1	13	15	\N
2904	1	14	16	8
2904	1	15	17	9
2912	3	26	0	0
2912	3	27	1	\N
2912	1	8	2	\N
2912	1	7	3	\N
2912	1	6	4	1
2912	1	5	5	2
2912	1	4	6	\N
2912	2	19	7	\N
2912	2	20	8	\N
2912	2	21	9	3
2912	4	41	10	4
2912	1	9	11	\N
2912	1	10	12	5
2914	3	26	0	0
2914	3	27	1	1
2914	1	8	2	2
2914	1	7	3	\N
2914	1	6	4	3
2914	1	5	5	\N
2914	1	4	6	\N
2914	2	19	7	\N
2914	2	20	8	\N
2914	2	21	9	\N
2914	4	41	10	4
2914	1	9	11	\N
2914	1	10	12	5
2914	1	11	13	6
2914	1	12	14	7
2921	3	26	0	0
2921	3	27	1	1
2921	1	8	2	\N
2921	1	9	3	2
2921	1	10	4	3
2921	1	11	5	4
2921	1	12	6	\N
2921	1	13	7	5
2921	1	14	8	6
2921	4	38	9	7
2921	4	37	10	\N
2921	4	36	11	8
2921	4	35	12	9
2922	3	26	0	0
2922	3	27	1	\N
2922	1	8	2	\N
2922	1	9	3	\N
2922	1	10	4	1
2922	1	11	5	\N
2922	4	38	6	\N
2922	4	37	7	2
2922	4	36	8	\N
2922	4	39	9	3
2923	3	26	0	0
2923	3	27	1	1
2923	1	8	2	\N
2923	1	9	3	2
2923	1	10	4	3
2923	1	11	5	\N
2923	4	38	6	\N
2923	4	37	7	4
2923	4	36	8	\N
2923	4	39	9	5
2923	4	40	10	6
2924	3	26	0	0
2924	3	27	1	\N
2924	1	8	2	1
2924	1	9	3	\N
2924	1	10	4	2
2924	1	11	5	3
2924	4	38	6	\N
2924	4	37	7	\N
2924	4	36	8	\N
2924	4	39	9	4
2924	4	40	10	5
2924	2	21	11	6
2926	3	26	0	0
2926	3	27	1	1
2926	1	8	2	2
2926	1	9	3	\N
2926	1	10	4	3
2926	1	11	5	\N
2926	4	38	6	4
2926	4	37	7	\N
2926	4	36	8	\N
2926	4	39	9	5
2926	4	40	10	6
2926	2	21	11	7
2926	2	20	12	\N
2926	2	19	13	8
2931	3	26	0	0
2931	3	27	1	\N
2931	1	8	2	\N
2931	1	9	3	1
2931	1	10	4	2
2931	1	11	5	3
2931	4	39	6	\N
2931	4	40	7	\N
2931	2	21	8	\N
2931	2	20	9	\N
2931	2	19	10	\N
2931	1	4	11	4
2931	1	3	12	\N
2931	1	2	13	5
2931	1	5	14	6
2936	3	26	0	0
2936	3	27	1	1
2936	1	8	2	\N
2936	1	9	3	\N
2936	1	10	4	2
2936	1	11	5	\N
2936	4	39	6	3
2936	4	40	7	4
2936	2	21	8	\N
2936	2	20	9	5
2936	2	19	10	6
2936	1	4	11	\N
2936	1	5	12	\N
2936	1	6	13	7
2936	2	18	14	8
2936	2	17	15	\N
2936	2	16	16	9
2947	3	26	0	0
2947	3	27	1	1
2947	1	8	2	2
2947	1	9	3	\N
2947	1	10	4	\N
2947	1	11	5	\N
2947	4	39	6	\N
2947	4	40	7	3
2947	2	21	8	\N
2947	3	30	9	4
2947	3	31	10	5
2947	3	32	11	6
2947	3	33	12	\N
2947	4	41	13	7
2954	3	27	0	0
2954	1	8	1	1
2954	1	7	2	\N
2954	1	6	3	\N
2954	1	5	4	2
2959	3	27	0	0
2959	1	8	1	\N
2959	1	7	2	\N
2959	1	6	3	1
2959	1	5	4	\N
2959	1	4	5	2
2959	1	3	6	3
2959	1	2	7	4
2959	2	18	8	5
2964	3	27	0	0
2964	1	8	1	1
2964	1	7	2	\N
2964	1	6	3	\N
2964	1	5	4	\N
2964	1	4	5	2
2964	2	18	6	3
2964	2	17	7	4
2964	2	19	8	5
2964	2	20	9	6
2964	2	21	10	7
2977	3	27	0	0
2977	1	8	1	1
2977	1	7	2	2
2977	1	6	3	\N
2977	1	5	4	3
2977	1	4	5	4
2977	2	19	6	\N
2977	2	20	7	\N
2977	2	21	8	5
2977	3	30	9	\N
2977	3	31	10	6
2977	3	32	11	7
2977	3	33	12	8
2977	4	40	13	9
2977	4	39	14	\N
2977	1	11	15	10
3021	3	27	0	0
3021	1	8	1	\N
3021	1	9	2	\N
3021	1	10	3	\N
3021	1	11	4	1
3021	4	39	5	2
3021	4	40	6	3
3021	2	21	7	\N
3021	3	29	8	4
3021	3	30	9	5
3024	3	27	0	0
3024	1	8	1	1
3024	1	9	2	\N
3024	1	10	3	\N
3024	1	11	4	2
3024	4	39	5	3
3024	4	40	6	\N
3024	2	21	7	\N
3024	3	29	8	\N
3024	3	30	9	\N
3024	3	31	10	\N
3024	3	32	11	\N
3024	3	33	12	4
3032	3	28	0	0
3032	1	8	1	1
3046	3	28	0	0
3046	1	8	1	1
3046	1	7	2	2
3046	1	6	3	3
3046	1	5	4	4
3046	1	4	5	5
3046	2	18	6	6
3046	2	17	7	\N
3046	2	19	8	\N
3046	2	20	9	\N
3046	2	21	10	\N
3046	2	22	11	7
3048	3	28	0	0
3048	1	8	1	1
3048	1	7	2	\N
3048	1	6	3	\N
3048	1	5	4	\N
3048	1	4	5	2
3048	2	18	6	\N
3048	2	17	7	3
3048	2	19	8	4
3048	2	20	9	5
3048	2	21	10	6
3048	2	22	11	\N
3048	2	23	12	7
3048	2	24	13	8
3058	3	28	0	0
3058	1	8	1	1
3058	1	7	2	\N
3058	1	6	3	2
3058	1	5	4	\N
3058	1	4	5	3
3058	2	19	6	4
3058	2	20	7	\N
3058	2	21	8	\N
3058	3	30	9	\N
3058	3	31	10	\N
3058	3	32	11	\N
3058	3	33	12	5
3058	4	40	13	\N
3058	4	39	14	\N
3058	1	11	15	6
3058	1	10	16	7
3062	3	28	0	0
3062	1	8	1	\N
3062	1	7	2	1
3062	1	6	3	\N
3062	1	5	4	2
3062	1	4	5	\N
3062	2	19	6	\N
3062	2	20	7	\N
3062	2	21	8	\N
3062	4	40	9	\N
3062	4	39	10	\N
3062	1	11	11	\N
3062	1	10	12	3
3062	1	12	13	\N
3062	1	13	14	\N
3062	1	14	15	4
3071	3	28	0	0
3071	1	8	1	\N
3071	1	7	2	1
3071	1	6	3	2
3071	1	5	4	\N
3071	1	4	5	\N
3071	2	19	6	3
3071	2	20	7	4
3071	2	21	8	5
3071	4	41	9	6
3071	1	9	10	7
3071	1	10	11	8
3104	3	28	0	0
3104	1	8	1	\N
3104	1	9	2	1
3104	1	10	3	2
3104	1	11	4	3
3104	4	39	5	\N
3104	4	40	6	4
3104	2	21	7	\N
3104	3	30	8	\N
3104	3	31	9	5
3104	3	32	10	6
3104	3	33	11	\N
3104	3	34	12	7
3105	3	28	0	0
3105	1	8	1	\N
3105	1	9	2	1
3105	1	10	3	2
3105	1	11	4	\N
3105	4	39	5	\N
3105	4	40	6	\N
3105	2	21	7	\N
3105	3	30	8	\N
3105	3	31	9	\N
3105	3	32	10	3
3105	3	33	11	\N
3105	4	41	12	4
3115	3	28	0	0
3115	1	8	1	\N
3115	3	27	2	1
3115	3	26	3	2
3115	3	29	4	3
3115	2	21	5	\N
3115	2	20	6	\N
3115	2	19	7	4
3115	1	4	8	\N
3115	1	3	9	5
3139	3	28	0	0
3139	3	29	1	1
3139	2	21	2	\N
3139	2	20	3	2
3139	2	19	4	3
3139	1	4	5	\N
3139	1	5	6	\N
3139	1	6	7	4
3139	1	7	8	5
3139	1	8	9	\N
3139	3	27	10	\N
3139	3	26	11	\N
3139	2	18	12	6
3139	2	17	13	7
3141	3	28	0	0
3141	3	29	1	\N
3141	2	21	2	\N
3141	2	20	3	1
3141	2	19	4	2
3141	1	4	5	\N
3141	2	18	6	3
3141	2	17	7	4
3141	2	22	8	5
3142	3	28	0	0
3142	3	29	1	1
3142	2	21	2	2
3142	2	20	3	\N
3142	2	19	4	\N
3142	1	4	5	\N
3142	2	18	6	\N
3142	2	17	7	3
3142	2	22	8	\N
3142	2	23	9	4
3153	3	28	0	0
3153	3	29	1	\N
3153	2	21	2	\N
3153	3	30	3	1
3153	3	31	4	2
3153	3	32	5	\N
3153	3	33	6	3
3153	4	40	7	4
3153	4	39	8	5
3153	1	11	9	\N
3153	1	10	10	6
3153	1	9	11	7
3160	3	28	0	0
3160	3	29	1	\N
3160	2	21	2	\N
3160	3	30	3	1
3160	3	31	4	2
3160	3	32	5	3
3160	3	33	6	4
3160	4	40	7	5
3160	4	39	8	6
3160	1	11	9	7
3160	1	10	10	\N
3160	1	9	11	\N
3160	1	8	12	8
3160	1	7	13	9
3160	1	6	14	10
3160	1	5	15	\N
3160	1	4	16	\N
3160	1	3	17	\N
3160	1	2	18	11
3178	3	28	0	0
3178	3	29	1	1
3178	2	21	2	\N
3178	4	40	3	\N
3178	4	39	4	2
3178	1	11	5	\N
3178	4	38	6	3
3178	4	37	7	4
3178	4	36	8	\N
3178	4	41	9	5
3179	3	28	0	0
3179	3	29	1	\N
3179	2	21	2	1
3179	4	40	3	2
3179	4	39	4	3
3179	1	11	5	4
3179	4	38	6	5
3179	4	37	7	6
3179	4	36	8	7
3179	4	41	9	\N
3179	4	42	10	8
3186	3	29	0	0
3186	2	21	1	1
3186	2	20	2	2
3186	2	19	3	3
3186	1	4	4	4
3186	1	3	5	5
3186	1	2	6	6
3186	1	1	7	7
3198	3	29	0	0
3198	2	21	1	\N
3198	2	20	2	\N
3198	2	19	3	1
3198	1	4	4	2
3198	1	5	5	\N
3198	1	6	6	\N
3198	1	7	7	3
3198	1	8	8	4
3198	1	9	9	5
3198	1	10	10	6
3198	1	11	11	\N
3198	1	12	12	\N
3198	1	13	13	7
3198	1	14	14	\N
3198	4	38	15	8
3207	3	29	0	0
3207	2	21	1	\N
3207	2	20	2	1
3207	2	19	3	2
3207	1	4	4	\N
3207	1	5	5	3
3207	1	6	6	\N
3207	1	7	7	\N
3207	1	8	8	\N
3207	3	27	9	4
3207	3	26	10	\N
3207	3	28	11	5
3209	3	29	0	0
3209	2	21	1	1
3209	2	20	2	\N
3209	2	19	3	2
3209	1	4	4	\N
3209	1	5	5	3
3209	1	6	6	4
3209	1	7	7	5
3209	1	8	8	\N
3209	2	18	9	6
3209	2	17	10	7
3211	3	29	0	0
3211	2	21	1	\N
3211	2	20	2	1
3211	2	19	3	2
3211	1	4	4	\N
3211	2	18	5	\N
3211	2	17	6	\N
3211	2	22	7	3
3217	3	29	0	0
3217	2	21	1	\N
3217	2	22	2	1
3217	2	23	3	\N
3217	3	30	4	2
3217	3	31	5	3
3217	3	32	6	4
3217	3	33	7	5
3221	3	29	0	0
3221	2	21	1	\N
3221	3	30	2	1
3221	3	31	3	\N
3221	3	32	4	2
3221	3	33	5	3
3221	4	40	6	\N
3221	4	39	7	\N
3221	1	11	8	4
3230	3	29	0	0
3230	2	21	1	1
3230	3	30	2	2
3230	3	31	3	3
3230	3	32	4	4
3230	3	33	5	\N
3230	4	40	6	\N
3230	4	39	7	\N
3230	1	11	8	\N
3230	1	10	9	\N
3230	1	9	10	\N
3230	1	8	11	\N
3230	1	7	12	5
3230	1	6	13	\N
3230	1	5	14	\N
3230	1	4	15	\N
3230	1	3	16	6
3230	1	2	17	7
3232	3	29	0	0
3232	2	21	1	1
3232	4	40	2	2
3232	4	39	3	\N
3232	1	11	4	3
3232	1	10	5	4
3232	1	9	6	\N
3232	1	8	7	\N
3232	1	7	8	5
3232	1	6	9	6
3232	1	5	10	7
3232	1	4	11	8
3232	1	3	12	\N
3232	1	2	13	9
3232	2	18	14	10
3239	3	29	0	0
3239	2	21	1	1
3239	4	40	2	\N
3239	4	39	3	2
3239	1	11	4	3
3239	1	10	5	4
3239	1	9	6	5
3239	1	8	7	\N
3239	1	7	8	6
3239	1	6	9	7
3239	1	5	10	\N
3239	1	4	11	\N
3239	2	19	12	\N
3239	3	27	13	8
3239	3	26	14	\N
3239	3	25	15	9
3248	3	29	0	0
3248	2	21	1	\N
3248	4	40	2	1
3248	4	39	3	2
3248	1	11	4	3
3248	1	12	5	\N
3248	1	13	6	4
3248	1	14	7	5
3248	4	38	8	\N
3248	4	37	9	\N
3248	4	36	10	\N
3248	4	35	11	6
3280	3	29	0	0
3280	3	28	1	\N
3280	1	8	2	1
3280	1	7	3	\N
3280	1	6	4	2
3280	1	5	5	\N
3280	1	4	6	3
3280	2	19	7	4
3280	2	20	8	\N
3280	2	21	9	5
3280	4	40	10	6
3280	4	39	11	\N
3280	1	11	12	7
3280	1	10	13	\N
3280	1	12	14	\N
3280	1	13	15	8
3318	3	29	0	0
3318	3	28	1	1
3318	1	8	2	\N
3318	1	9	3	\N
3318	1	10	4	\N
3318	1	11	5	\N
3318	4	39	6	\N
3318	4	40	7	2
3318	2	21	8	3
3318	2	22	9	\N
3318	2	23	10	\N
3318	3	30	11	4
3321	3	29	0	0
3321	3	28	1	\N
3321	1	8	2	1
3321	1	9	3	2
3321	1	10	4	3
3321	1	11	5	\N
3321	4	39	6	\N
3321	4	40	7	4
3321	2	21	8	5
3321	2	22	9	6
3321	2	23	10	\N
3321	3	30	11	\N
3321	3	31	12	7
3321	3	32	13	8
3321	3	33	14	9
3323	3	29	0	0
3323	3	28	1	1
3323	1	8	2	\N
3323	1	9	3	2
3323	1	10	4	\N
3323	1	11	5	\N
3323	4	39	6	3
3323	4	40	7	4
3323	2	21	8	5
3323	3	30	9	\N
3323	3	31	10	6
3323	3	32	11	\N
3323	3	33	12	\N
3323	4	41	13	7
3338	3	30	0	0
3338	2	21	1	\N
3338	2	20	2	\N
3338	2	19	3	\N
3338	1	4	4	1
3338	1	3	5	\N
3338	1	2	6	\N
3338	1	5	7	\N
3338	1	6	8	2
3338	1	7	9	\N
3338	1	8	10	3
3344	3	30	0	0
3344	2	21	1	1
3344	2	20	2	\N
3344	2	19	3	2
3344	1	4	4	\N
3344	1	3	5	\N
3344	1	2	6	\N
3344	1	5	7	\N
3344	1	6	8	3
3344	1	7	9	\N
3344	1	8	10	4
3344	1	9	11	5
3344	1	10	12	\N
3344	1	11	13	\N
3344	1	12	14	\N
3344	1	13	15	6
3344	1	14	16	7
3355	3	30	0	0
3355	2	21	1	\N
3355	2	20	2	\N
3355	2	19	3	1
3355	1	4	4	2
3355	1	5	5	3
3355	1	6	6	4
3355	1	7	7	\N
3355	1	8	8	5
3355	3	27	9	\N
3355	3	26	10	\N
3355	3	28	11	6
3373	3	30	0	0
3373	2	21	1	\N
3373	3	29	2	\N
3373	3	28	3	\N
3373	1	8	4	1
3373	1	7	5	\N
3373	1	6	6	\N
3373	1	5	7	2
3373	1	4	8	3
3373	1	3	9	4
3373	1	2	10	5
3373	2	18	11	6
3375	3	30	0	0
3375	2	21	1	1
3375	3	29	2	2
3375	3	28	3	\N
3375	1	8	4	\N
3375	1	7	5	3
3375	1	6	6	4
3375	1	5	7	\N
3375	1	4	8	\N
3375	1	3	9	5
3375	1	2	10	\N
3375	2	18	11	\N
3375	2	17	12	\N
3375	2	16	13	6
3416	3	31	0	0
3416	3	30	1	1
3416	2	21	2	2
3416	2	20	3	\N
3416	2	19	4	3
3422	3	31	0	0
3422	3	30	1	1
3422	2	21	2	2
3422	2	20	3	3
3422	2	19	4	4
3422	1	4	5	\N
3422	1	3	6	\N
3422	1	2	7	5
3422	1	5	8	6
3422	1	6	9	7
3441	3	31	0	0
3441	3	30	1	1
3441	2	21	2	2
3441	2	20	3	\N
3441	2	19	4	3
3441	1	4	5	4
3441	1	5	6	5
3441	1	6	7	6
3441	1	7	8	\N
3441	1	8	9	7
3441	3	27	10	8
3441	3	26	11	9
3441	3	28	12	10
3443	3	31	0	0
3443	3	30	1	\N
3443	2	21	2	\N
3443	2	20	3	1
3443	2	19	4	2
3443	1	4	5	\N
3443	1	5	6	\N
3443	1	6	7	\N
3443	1	7	8	\N
3443	1	8	9	3
3443	3	28	10	4
3443	2	18	11	5
3444	3	31	0	0
3444	3	30	1	\N
3444	2	21	2	1
3444	2	20	3	\N
3444	2	19	4	\N
3444	1	4	5	\N
3444	1	5	6	2
3444	1	6	7	3
3444	1	7	8	\N
3444	1	8	9	4
3444	3	28	10	\N
3444	2	18	11	\N
3444	2	17	12	5
3446	3	31	0	0
3446	3	30	1	\N
3446	2	21	2	1
3446	2	20	3	2
3446	2	19	4	3
3446	1	4	5	\N
3446	2	18	6	4
3446	2	17	7	5
3446	2	22	8	6
3457	3	31	0	0
3457	3	30	1	1
3457	2	21	2	2
3457	2	22	3	3
3457	2	23	4	\N
3457	3	29	5	4
3457	3	28	6	\N
3457	1	8	7	\N
3457	1	7	8	\N
3457	1	6	9	\N
3457	1	5	10	\N
3457	1	4	11	\N
3457	1	3	12	5
3457	1	2	13	6
3458	3	31	0	0
3458	3	30	1	1
3458	2	21	2	\N
3458	2	22	3	\N
3458	2	23	4	\N
3458	3	29	5	\N
3458	3	28	6	\N
3458	1	8	7	2
3458	1	7	8	3
3458	1	6	9	4
3458	1	5	10	\N
3458	1	4	11	5
3458	1	3	12	\N
3458	1	2	13	\N
3458	1	1	14	6
3461	3	31	0	0
3461	3	30	1	1
3461	2	21	2	2
3461	3	29	3	3
3461	3	28	4	4
3461	1	8	5	\N
3461	1	7	6	\N
3461	1	6	7	5
3461	1	5	8	6
3461	1	4	9	\N
3461	1	3	10	\N
3461	1	2	11	\N
3461	2	18	12	\N
3461	2	17	13	7
3461	2	16	14	8
3467	3	31	0	0
3467	3	30	1	\N
3467	2	21	2	\N
3467	3	29	3	\N
3467	3	28	4	\N
3467	1	8	5	1
3467	1	7	6	2
3467	1	6	7	\N
3467	1	5	8	\N
3467	1	4	9	\N
3467	2	19	10	\N
3467	1	9	11	3
3467	1	10	12	4
3467	1	11	13	\N
3467	1	12	14	5
3473	3	31	0	0
3473	3	30	1	\N
3473	2	21	2	1
3473	3	29	3	\N
3473	3	28	4	\N
3473	1	8	5	2
3473	1	9	6	3
3473	1	10	7	4
3473	1	11	8	\N
3473	1	12	9	\N
3473	1	13	10	5
3473	1	14	11	6
3473	4	38	12	\N
3473	4	37	13	7
3473	4	36	14	8
3478	3	31	0	0
3478	3	30	1	1
3478	2	21	2	\N
3478	3	29	3	2
3478	3	28	4	\N
3478	1	8	5	3
3478	1	9	6	\N
3478	1	10	7	4
3478	1	11	8	5
3478	4	39	9	6
3478	3	27	10	7
3478	3	26	11	8
3503	3	32	0	0
3503	3	31	1	1
3503	3	30	2	2
3503	2	21	3	\N
3503	2	20	4	\N
3503	2	19	5	3
3503	1	4	6	4
3511	3	32	0	0
3511	3	31	1	1
3511	3	30	2	2
3511	2	21	3	\N
3511	2	20	4	3
3511	2	19	5	\N
3511	1	4	6	4
3511	1	3	7	5
3511	1	2	8	6
3511	1	5	9	\N
3511	1	6	10	7
3511	1	7	11	\N
3511	1	8	12	8
3511	1	9	13	9
3513	3	32	0	0
3513	3	31	1	\N
3513	3	30	2	1
3513	2	21	3	\N
3513	2	20	4	2
3513	2	19	5	\N
3513	1	4	6	3
3513	1	3	7	\N
3513	1	2	8	\N
3513	1	5	9	\N
3513	1	6	10	4
3513	1	7	11	5
3513	1	8	12	6
3513	1	9	13	7
3513	1	10	14	8
3513	1	11	15	9
3526	3	32	0	0
3526	3	31	1	\N
3526	3	30	2	1
3526	2	21	3	2
3526	2	20	4	\N
3526	2	19	5	\N
3526	1	4	6	3
3526	1	5	7	4
3526	1	6	8	\N
3526	1	7	9	\N
3526	1	8	10	5
3526	1	9	11	6
3526	1	10	12	7
3526	1	11	13	\N
3526	4	39	14	8
3526	3	27	15	9
3526	3	26	16	10
3526	3	25	17	11
3529	3	32	0	0
3529	3	31	1	1
3529	3	30	2	2
3529	2	21	3	3
3529	2	20	4	\N
3529	2	19	5	\N
3529	1	4	6	4
3529	1	5	7	5
3529	1	6	8	\N
3529	1	7	9	\N
3529	1	8	10	\N
3529	3	28	11	6
3529	2	18	12	7
3538	3	32	0	0
3538	3	31	1	\N
3538	3	30	2	\N
3538	2	21	3	\N
3538	2	22	4	\N
3538	2	23	5	\N
3538	3	29	6	\N
3538	3	28	7	\N
3538	1	8	8	1
3538	1	7	9	2
3563	3	32	0	0
3563	3	31	1	1
3563	3	30	2	\N
3563	2	21	3	\N
3563	3	29	4	2
3563	3	28	5	\N
3563	1	8	6	\N
3563	1	9	7	3
3563	1	10	8	4
3563	1	11	9	\N
3563	4	39	10	5
3563	3	27	11	6
3565	3	32	0	0
3565	3	31	1	\N
3565	3	30	2	\N
3565	2	21	3	1
3565	3	29	4	2
3565	3	28	5	3
3565	1	8	6	4
3565	1	9	7	5
3565	1	10	8	\N
3565	1	11	9	6
3565	4	39	10	\N
3565	3	27	11	\N
3565	3	26	12	\N
3565	3	25	13	7
3572	3	32	0	0
3572	3	31	1	\N
3572	3	30	2	\N
3572	2	21	3	1
3572	4	40	4	\N
3572	4	39	5	2
3572	1	11	6	3
3572	1	10	7	4
3572	1	12	8	\N
3572	1	13	9	5
3577	3	32	0	0
3577	3	31	1	\N
3577	3	30	2	\N
3577	2	21	3	1
3577	4	40	4	\N
3577	4	39	5	\N
3577	1	11	6	2
3577	1	12	7	\N
3577	1	13	8	3
3577	1	14	9	4
3577	4	38	10	\N
3577	4	37	11	5
3577	4	36	12	6
3581	3	32	0	0
3581	3	31	1	\N
3581	3	30	2	1
3581	2	21	3	\N
3581	4	41	4	\N
3581	3	33	5	2
3590	3	33	0	0
3590	3	32	1	\N
3590	3	31	2	\N
3590	3	30	3	\N
3590	2	21	4	\N
3590	2	20	5	1
3590	2	19	6	2
3590	1	4	7	3
3590	1	3	8	4
3610	3	33	0	0
3610	3	32	1	1
3610	3	31	2	\N
3610	3	30	3	2
3610	2	21	4	3
3610	2	20	5	\N
3610	2	19	6	\N
3610	1	4	7	4
3610	1	5	8	5
3610	1	6	9	6
3610	1	7	10	7
3610	1	8	11	\N
3610	1	9	12	\N
3610	1	10	13	8
3610	1	11	14	\N
3610	4	39	15	\N
3610	3	27	16	9
3611	3	33	0	0
3611	3	32	1	1
3611	3	31	2	2
3611	3	30	3	\N
3611	2	21	4	\N
3611	2	20	5	3
3611	2	19	6	\N
3611	1	4	7	4
3611	1	5	8	5
3611	1	6	9	\N
3611	1	7	10	\N
3611	1	8	11	\N
3611	1	9	12	6
3611	1	10	13	7
3611	1	11	14	8
3611	4	39	15	9
3611	3	27	16	10
3611	3	26	17	11
3612	3	33	0	0
3612	3	32	1	1
3612	3	31	2	\N
3612	3	30	3	\N
3612	2	21	4	\N
3612	2	20	5	\N
3612	2	19	6	\N
3612	1	4	7	\N
3612	1	5	8	2
3612	1	6	9	3
3612	1	7	10	4
3612	1	8	11	\N
3612	1	9	12	\N
3612	1	10	13	5
3612	1	11	14	\N
3612	4	39	15	6
3612	3	27	16	\N
3612	3	26	17	7
3612	3	25	18	8
3664	3	33	0	0
3664	3	32	1	\N
3664	3	31	2	\N
3664	3	30	3	\N
3664	2	21	4	\N
3664	4	40	5	1
3664	4	39	6	2
3664	1	11	7	3
3664	1	12	8	\N
3664	1	13	9	\N
3664	1	14	10	4
3664	4	38	11	5
3664	4	37	12	\N
3664	4	36	13	6
3664	4	35	14	7
3690	3	34	0	0
3690	3	33	1	1
3690	3	32	2	\N
3690	3	31	3	2
3690	3	30	4	\N
3690	2	21	5	\N
3690	2	20	6	3
3690	2	19	7	4
3690	1	4	8	\N
3690	1	5	9	\N
3690	1	6	10	\N
3690	1	7	11	5
3690	1	8	12	\N
3690	1	9	13	6
3690	1	10	14	\N
3690	1	11	15	7
3690	1	12	16	\N
3690	1	13	17	\N
3690	1	14	18	8
3690	4	38	19	9
3698	3	34	0	0
3698	3	33	1	\N
3698	3	32	2	1
3698	3	31	3	\N
3698	3	30	4	\N
3698	2	21	5	\N
3698	2	20	6	\N
3698	2	19	7	2
3698	1	4	8	3
3698	1	5	9	4
3698	1	6	10	\N
3698	1	7	11	\N
3698	1	8	12	\N
3698	1	9	13	5
3698	1	10	14	\N
3698	1	11	15	\N
3698	4	39	16	6
3698	3	27	17	7
3698	3	26	18	8
3698	3	25	19	9
3724	3	34	0	0
3724	3	33	1	\N
3724	3	32	2	\N
3724	3	31	3	1
3724	3	30	4	2
3724	2	21	5	\N
3724	3	29	6	3
3724	3	28	7	\N
3724	1	8	8	\N
3724	1	7	9	\N
3724	1	6	10	\N
3724	1	5	11	\N
3724	1	4	12	4
3724	2	19	13	5
3724	1	9	14	6
3724	1	10	15	7
3724	1	11	16	8
3726	3	34	0	0
3726	3	33	1	\N
3726	3	32	2	1
3726	3	31	3	2
3726	3	30	4	\N
3726	2	21	5	\N
3726	3	29	6	3
3726	3	28	7	4
3726	1	8	8	5
3726	1	7	9	6
3726	1	6	10	\N
3726	1	5	11	7
3726	1	4	12	8
3726	2	19	13	9
3726	1	9	14	\N
3726	1	10	15	\N
3726	1	11	16	\N
3726	1	12	17	10
3726	1	13	18	11
3728	3	34	0	0
3728	3	33	1	\N
3728	3	32	2	\N
3728	3	31	3	1
3728	3	30	4	2
3728	2	21	5	\N
3728	3	29	6	\N
3728	3	28	7	\N
3728	1	8	8	\N
3728	1	7	9	\N
3728	1	6	10	\N
3728	1	5	11	3
3728	1	4	12	4
3728	2	19	13	\N
3728	1	9	14	5
3728	1	10	15	\N
3728	1	11	16	6
3728	1	12	17	7
3728	1	13	18	8
3728	1	14	19	\N
3728	1	15	20	9
3730	3	34	0	0
3730	3	33	1	\N
3730	3	32	2	\N
3730	3	31	3	1
3730	3	30	4	\N
3730	2	21	5	2
3730	3	29	6	\N
3730	3	28	7	\N
3730	1	8	8	\N
3730	1	9	9	3
3730	1	10	10	4
3730	1	11	11	5
3730	1	12	12	6
3730	1	13	13	\N
3730	1	14	14	\N
3730	4	38	15	7
3730	4	37	16	8
3739	3	34	0	0
3739	3	33	1	\N
3739	3	32	2	1
3739	3	31	3	2
3739	3	30	4	3
3739	2	21	5	\N
3739	3	29	6	\N
3739	3	28	7	\N
3739	1	8	8	\N
3739	3	27	9	\N
3739	3	26	10	4
3739	4	40	11	5
3739	4	39	12	6
3743	3	34	0	0
3743	3	33	1	1
3743	3	32	2	\N
3743	3	31	3	2
3743	3	30	4	3
3743	2	21	5	\N
3743	4	40	6	4
3743	4	39	7	5
3743	1	11	8	6
3743	1	10	9	\N
3743	1	12	10	7
3747	3	34	0	0
3747	3	33	1	\N
3747	3	32	2	1
3747	3	31	3	2
3747	3	30	4	3
3747	2	21	5	\N
3747	4	40	6	\N
3747	4	39	7	4
3747	1	11	8	\N
3747	1	12	9	\N
3747	1	13	10	5
3747	1	14	11	\N
3747	4	38	12	6
3753	4	35	0	0
3753	4	36	1	1
3759	4	35	0	0
3759	4	36	1	1
3759	4	37	2	\N
3759	4	38	3	\N
3759	1	11	4	2
3759	1	10	5	\N
3759	1	9	6	\N
3759	1	8	7	3
3777	4	35	0	0
3777	4	36	1	\N
3777	4	37	2	1
3777	4	38	3	\N
3777	1	11	4	2
3777	1	10	5	\N
3777	1	9	6	\N
3777	1	8	7	\N
3777	1	7	8	\N
3777	1	6	9	\N
3777	1	5	10	3
3777	1	4	11	4
3777	2	19	12	5
3777	2	20	13	\N
3777	2	21	14	\N
3777	2	22	15	\N
3777	2	23	16	\N
3777	3	29	17	6
3777	3	28	18	7
3788	4	35	0	0
3788	4	36	1	1
3788	4	37	2	\N
3788	4	38	3	\N
3788	1	11	4	\N
3788	1	10	5	2
3788	1	9	6	3
3788	1	8	7	4
3788	1	7	8	5
3788	1	6	9	\N
3788	1	5	10	6
3788	1	4	11	7
3788	2	19	12	\N
3788	2	20	13	\N
3788	2	21	14	\N
3788	4	41	15	\N
3788	3	27	16	\N
3788	3	26	17	8
3793	4	35	0	0
3793	4	36	1	\N
3793	4	37	2	1
3793	4	38	3	2
3793	1	11	4	\N
3793	1	10	5	\N
3793	1	9	6	3
3793	1	8	7	\N
3793	3	27	8	4
3793	3	26	9	5
3793	3	28	10	\N
3793	3	29	11	\N
3793	2	21	12	\N
3793	2	20	13	6
3813	4	35	0	0
3813	4	36	1	1
3813	4	37	2	\N
3813	4	38	3	\N
3813	1	11	4	\N
3813	1	10	5	\N
3813	1	9	6	2
3813	1	8	7	3
3813	3	28	8	4
3813	3	29	9	5
3813	2	21	10	6
3813	3	30	11	\N
3813	3	31	12	\N
3813	3	32	13	7
3813	3	33	14	\N
3813	4	40	15	8
3815	4	35	0	0
3815	4	36	1	1
3815	4	37	2	\N
3815	4	38	3	\N
3815	1	11	4	2
3815	1	10	5	3
3815	1	9	6	\N
3815	1	8	7	\N
3815	3	28	8	4
3815	3	29	9	5
3815	2	21	10	\N
3815	4	40	11	\N
3815	4	41	12	6
3821	4	35	0	0
3821	4	36	1	1
3821	4	37	2	\N
3821	4	38	3	\N
3821	1	11	4	2
3821	1	12	5	\N
3821	1	13	6	\N
3821	1	14	7	\N
3821	4	39	8	3
3822	4	35	0	0
3822	4	36	1	\N
3822	4	37	2	\N
3822	4	38	3	\N
3822	1	11	4	1
3822	1	12	5	2
3822	1	13	6	\N
3822	1	14	7	\N
3822	4	39	8	\N
3822	4	40	9	3
3843	4	35	0	0
3843	4	36	1	\N
3843	4	37	2	\N
3843	4	38	3	1
3843	1	11	4	2
3843	4	39	5	3
3843	4	40	6	\N
3843	2	21	7	\N
3843	2	20	8	4
3843	2	19	9	5
3843	1	4	10	6
3843	1	5	11	7
3843	1	6	12	8
3843	1	7	13	\N
3843	1	8	14	\N
3843	3	28	15	9
3843	2	18	16	\N
3843	2	17	17	\N
3843	2	16	18	10
3844	4	35	0	0
3844	4	36	1	1
3844	4	37	2	\N
3844	4	38	3	\N
3844	1	11	4	2
3844	4	39	5	\N
3844	4	40	6	3
3844	2	21	7	4
3844	2	20	8	5
3844	2	19	9	\N
3844	1	4	10	6
3844	2	18	11	\N
3844	2	17	12	\N
3844	2	22	13	7
3854	4	35	0	0
3854	4	36	1	\N
3854	4	37	2	\N
3854	4	38	3	\N
3854	1	11	4	1
3854	4	39	5	\N
3854	4	40	6	\N
3854	2	21	7	2
3854	2	22	8	3
3854	2	23	9	4
3854	3	29	10	5
3854	3	28	11	\N
3854	1	8	12	6
3854	1	7	13	\N
3854	1	6	14	\N
3854	1	5	15	\N
3854	1	4	16	7
3854	1	3	17	8
3870	4	35	0	0
3870	4	36	1	\N
3870	4	37	2	\N
3870	4	38	3	\N
3870	1	11	4	1
3870	4	39	5	2
3870	4	40	6	3
3870	2	21	7	4
3870	3	29	8	5
3870	3	28	9	\N
3870	1	8	10	6
3870	3	27	11	\N
3870	3	26	12	\N
3870	3	30	13	\N
3870	3	31	14	7
3870	3	32	15	\N
3870	3	33	16	8
3877	4	36	0	0
3877	4	37	1	1
3877	4	38	2	\N
3877	1	11	3	2
3878	4	36	0	0
3878	4	37	1	\N
3878	4	38	2	1
3878	1	11	3	2
3878	1	10	4	3
3917	4	36	0	0
3917	4	37	1	1
3917	4	38	2	2
3917	1	11	3	3
3917	1	10	4	\N
3917	1	9	5	4
3917	1	8	6	5
3917	3	27	7	\N
3917	3	26	8	\N
3917	3	28	9	\N
3917	3	29	10	\N
3917	2	21	11	6
3917	2	20	12	\N
3917	2	19	13	\N
3917	1	4	14	\N
3917	1	3	15	7
3925	4	36	0	0
3925	4	37	1	1
3925	4	38	2	\N
3925	1	11	3	\N
3925	1	10	4	2
3925	1	9	5	3
3925	1	8	6	4
3925	3	28	7	\N
3925	3	29	8	5
3925	2	21	9	\N
3925	2	20	10	\N
3925	2	19	11	6
3925	1	4	12	7
3925	1	5	13	8
3925	1	6	14	9
3925	2	18	15	10
3925	2	17	16	11
3925	2	16	17	12
3928	4	36	0	0
3928	4	37	1	\N
3928	4	38	2	1
3928	1	11	3	\N
3928	1	10	4	2
3928	1	9	5	\N
3928	1	8	6	3
3928	3	28	7	4
3928	3	29	8	\N
3928	2	21	9	5
3928	2	20	10	6
3928	2	19	11	\N
3928	1	4	12	\N
3928	2	18	13	\N
3928	2	17	14	7
3928	2	22	15	\N
3928	2	23	16	8
3928	2	24	17	9
3957	4	36	0	0
3957	4	37	1	\N
3957	4	38	2	1
3957	1	11	3	\N
3957	4	39	4	2
3957	4	40	5	\N
3957	2	21	6	\N
3957	2	20	7	3
3957	2	19	8	4
3957	1	4	9	\N
3957	1	5	10	\N
3957	1	6	11	5
3957	1	7	12	\N
3957	1	8	13	6
3957	1	9	14	7
3957	3	27	15	8
3962	4	36	0	0
3962	4	37	1	1
3962	4	38	2	\N
3962	1	11	3	2
3962	4	39	4	\N
3962	4	40	5	3
3962	2	21	6	\N
3962	2	20	7	4
3962	2	19	8	\N
3962	1	4	9	5
3962	1	5	10	\N
3962	1	6	11	6
3962	1	7	12	\N
3962	1	8	13	7
3962	3	28	14	8
3962	2	18	15	9
3991	4	36	0	0
3991	4	37	1	1
3991	4	38	2	2
3991	1	11	3	\N
3991	4	39	4	\N
3991	4	40	5	\N
3991	2	21	6	3
3991	3	29	7	\N
3991	3	28	8	4
3991	1	8	9	5
3991	3	27	10	6
3991	3	26	11	7
3991	3	30	12	8
3991	3	31	13	\N
3991	3	32	14	\N
3991	3	33	15	9
3997	4	37	0	0
3997	4	36	1	\N
3997	4	38	2	1
3998	4	37	0	0
3998	4	36	1	1
3998	4	38	2	2
3998	1	11	3	3
4001	4	37	0	0
4001	4	36	1	1
4001	4	38	2	\N
4001	1	11	3	\N
4001	1	10	4	2
4001	1	9	5	3
4001	1	8	6	4
4002	4	37	0	0
4002	4	36	1	\N
4002	4	38	2	1
4002	1	11	3	2
4002	1	10	4	3
4002	1	9	5	\N
4002	1	8	6	4
4002	1	7	7	5
4003	4	37	0	0
4003	4	36	1	1
4003	4	38	2	2
4003	1	11	3	\N
4003	1	10	4	3
4003	1	9	5	4
4003	1	8	6	5
4003	1	7	7	6
4003	1	6	8	7
4011	4	37	0	0
4011	4	38	1	1
4011	1	11	2	2
4011	1	10	3	\N
4011	1	9	4	3
4011	1	8	5	4
4011	1	7	6	5
4011	1	6	7	\N
4011	1	5	8	6
4011	1	4	9	\N
4011	1	3	10	7
4011	1	2	11	8
4011	2	18	12	\N
4011	2	17	13	\N
4011	2	16	14	9
4015	4	37	0	0
4015	4	38	1	1
4015	1	11	2	2
4015	1	10	3	\N
4015	1	9	4	3
4015	1	8	5	4
4015	1	7	6	5
4015	1	6	7	\N
4015	1	5	8	\N
4015	1	4	9	\N
4015	2	18	10	6
4015	2	17	11	7
4015	2	19	12	8
4015	2	20	13	\N
4015	2	21	14	\N
4015	2	22	15	9
4021	4	37	0	0
4021	4	38	1	1
4021	1	11	2	2
4021	1	10	3	3
4021	1	9	4	\N
4021	1	8	5	\N
4021	1	7	6	4
4021	1	6	7	\N
4021	1	5	8	5
4021	1	4	9	\N
4021	2	19	10	\N
4021	2	20	11	\N
4021	2	21	12	\N
4021	3	29	13	\N
4021	3	30	14	\N
4021	3	31	15	6
4025	4	37	0	0
4025	4	38	1	\N
4025	1	11	2	\N
4025	1	10	3	\N
4025	1	9	4	1
4025	1	8	5	2
4025	1	7	6	3
4025	1	6	7	\N
4025	1	5	8	4
4025	1	4	9	\N
4025	2	19	10	\N
4025	2	20	11	5
4025	2	21	12	6
4025	3	30	13	7
4025	3	31	14	\N
4025	3	32	15	8
4025	3	33	16	9
4025	4	40	17	10
4034	4	37	0	0
4034	4	38	1	1
4034	1	11	2	\N
4034	1	10	3	2
4034	1	9	4	\N
4034	1	8	5	3
4034	3	27	6	\N
4034	3	26	7	\N
4034	3	28	8	\N
4034	3	29	9	\N
4034	2	21	10	4
4046	4	37	0	0
4046	4	38	1	\N
4046	1	11	2	1
4046	1	10	3	\N
4046	1	9	4	2
4046	1	8	5	3
4046	3	28	6	\N
4046	3	29	7	4
4046	2	21	8	\N
4046	2	20	9	5
4046	2	19	10	\N
4046	1	4	11	6
4046	1	5	12	\N
4046	1	6	13	7
4046	2	18	14	\N
4046	2	17	15	\N
4046	2	16	16	8
4053	4	37	0	0
4053	4	38	1	1
4053	1	11	2	2
4053	1	10	3	3
4053	1	9	4	4
4053	1	8	5	\N
4053	3	28	6	5
4053	3	29	7	\N
4053	2	21	8	6
4053	2	22	9	\N
4053	2	23	10	7
4053	3	30	11	8
4053	3	31	12	9
4053	3	32	13	10
4053	3	33	14	11
4054	4	37	0	0
4054	4	38	1	1
4054	1	11	2	\N
4054	1	10	3	2
4054	1	9	4	3
4054	1	8	5	\N
4054	3	28	6	4
4054	3	29	7	\N
4054	2	21	8	\N
4054	2	22	9	\N
4054	2	23	10	5
4054	3	30	11	6
4054	3	31	12	\N
4054	3	32	13	\N
4054	3	33	14	\N
4054	3	34	15	7
4069	4	37	0	0
4069	4	38	1	\N
4069	1	11	2	\N
4069	1	12	3	\N
4069	1	13	4	\N
4069	1	14	5	\N
4069	4	39	6	\N
4069	4	40	7	\N
4069	2	21	8	1
4069	2	20	9	\N
4069	2	19	10	\N
4069	1	4	11	2
4069	1	3	12	3
4083	4	37	0	0
4083	4	38	1	\N
4083	1	11	2	\N
4083	4	39	3	1
4083	4	40	4	\N
4083	2	21	5	2
4083	2	20	6	\N
4083	2	19	7	\N
4083	1	4	8	3
4083	1	5	9	\N
4083	1	6	10	\N
4083	1	7	11	4
4083	1	8	12	\N
4083	3	28	13	\N
4083	2	18	14	5
4093	4	37	0	0
4093	4	38	1	1
4093	1	11	2	2
4093	4	39	3	\N
4093	4	40	4	\N
4093	2	21	5	\N
4093	2	22	6	\N
4093	2	23	7	3
4093	3	29	8	\N
4093	3	28	9	4
4093	1	8	10	\N
4093	1	7	11	5
4093	1	6	12	6
4095	4	37	0	0
4095	4	38	1	\N
4095	1	11	2	1
4095	4	39	3	\N
4095	4	40	4	2
4095	2	21	5	3
4095	2	22	6	4
4095	2	23	7	\N
4095	3	29	8	\N
4095	3	28	9	\N
4095	1	8	10	5
4095	1	7	11	\N
4095	1	6	12	\N
4095	1	5	13	6
4095	1	4	14	7
4119	4	38	0	0
4119	1	11	1	1
4119	1	10	2	2
4119	1	9	3	\N
4119	1	8	4	3
4135	4	38	0	0
4135	1	11	1	1
4135	1	10	2	2
4135	1	9	3	3
4135	1	8	4	4
4135	1	7	5	\N
4135	1	6	6	\N
4135	1	5	7	5
4135	1	4	8	\N
4135	2	18	9	6
4135	2	17	10	7
4135	2	19	11	8
4135	2	20	12	\N
4135	2	21	13	\N
4135	2	22	14	9
4135	2	23	15	10
4135	2	24	16	11
4139	4	38	0	0
4139	1	11	1	\N
4139	1	10	2	1
4139	1	9	3	\N
4139	1	8	4	2
4139	1	7	5	\N
4139	1	6	6	\N
4139	1	5	7	\N
4139	1	4	8	\N
4139	2	19	9	\N
4139	2	20	10	3
4139	2	21	11	\N
4139	3	29	12	4
4139	3	30	13	5
4139	3	31	14	6
4155	4	38	0	0
4155	1	11	1	1
4155	1	10	2	2
4155	1	9	3	3
4155	1	8	4	\N
4155	3	27	5	4
4155	3	26	6	5
4155	3	28	7	\N
4155	3	29	8	\N
4155	2	21	9	\N
4155	2	20	10	\N
4155	2	19	11	6
4155	1	4	12	7
4168	4	38	0	0
4168	1	11	1	1
4168	1	10	2	\N
4168	1	9	3	\N
4168	1	8	4	2
4168	3	28	5	\N
4168	3	29	6	\N
4168	2	21	7	3
4168	2	22	8	\N
4168	2	23	9	4
4168	3	30	10	5
4173	4	38	0	0
4173	1	11	1	1
4173	1	10	2	2
4173	1	9	3	\N
4173	1	8	4	\N
4173	3	28	5	\N
4173	3	29	6	3
4173	2	21	7	\N
4173	3	30	8	\N
4173	3	31	9	\N
4173	3	32	10	4
4173	3	33	11	\N
4173	4	40	12	5
4177	4	38	0	0
4177	1	11	1	1
4177	1	10	2	2
4177	1	9	3	3
4177	1	8	4	4
4177	3	28	5	5
4177	3	29	6	6
4177	2	21	7	\N
4177	4	41	8	7
4177	1	12	9	8
4183	4	38	0	0
4183	1	11	1	\N
4183	1	12	2	1
4183	1	13	3	\N
4183	1	14	4	2
4183	4	39	5	\N
4183	4	40	6	3
4183	2	21	7	4
4192	4	38	0	0
4192	1	11	1	1
4192	4	39	2	\N
4192	4	40	3	2
4192	2	21	4	\N
4192	2	20	5	\N
4192	2	19	6	3
4192	1	4	7	4
4192	1	3	8	\N
4192	1	2	9	\N
4192	1	5	10	5
4192	1	6	11	\N
4192	1	7	12	6
4193	4	38	0	0
4193	1	11	1	\N
4193	4	39	2	\N
4193	4	40	3	1
4193	2	21	4	\N
4193	2	20	5	2
4193	2	19	6	\N
4193	1	4	7	3
4193	1	3	8	\N
4193	1	2	9	\N
4193	1	5	10	4
4193	1	6	11	5
4193	1	7	12	\N
4193	1	8	13	6
4209	4	38	0	0
4209	1	11	1	\N
4209	4	39	2	\N
4209	4	40	3	1
4209	2	21	4	2
4209	2	22	5	\N
4209	2	23	6	3
4209	3	29	7	\N
4209	3	28	8	4
4209	1	8	9	5
4220	4	38	0	0
4220	1	11	1	1
4220	4	39	2	\N
4220	4	40	3	2
4220	2	21	4	\N
4220	3	29	5	\N
4220	3	28	6	\N
4220	1	8	7	3
4220	1	7	8	4
4220	1	6	9	5
4220	1	5	10	6
4220	1	4	11	7
4220	2	18	12	\N
4220	2	17	13	\N
4220	2	19	14	8
4226	4	38	0	0
4226	1	11	1	\N
4226	4	39	2	\N
4226	4	40	3	1
4226	2	21	4	\N
4226	3	29	5	2
4226	3	28	6	\N
4226	1	8	7	\N
4226	1	9	8	\N
4226	3	27	9	\N
4226	3	26	10	3
4226	3	25	11	4
4231	4	38	0	0
4231	1	11	1	\N
4231	4	39	2	\N
4231	4	40	3	1
4231	2	21	4	\N
4231	3	29	5	2
4231	3	28	6	\N
4231	1	8	7	\N
4231	3	27	8	\N
4231	3	26	9	3
4231	3	30	10	\N
4231	3	31	11	\N
4231	3	32	12	\N
4231	3	33	13	4
4231	3	34	14	5
4234	4	38	0	0
4234	1	11	1	\N
4234	4	39	2	\N
4234	4	40	3	1
4234	2	21	4	\N
4234	4	41	5	\N
4234	4	37	6	2
4238	4	39	0	0
4238	1	11	1	1
4238	1	10	2	2
4244	4	39	0	0
4244	1	11	1	\N
4244	1	10	2	\N
4244	1	9	3	1
4244	1	8	4	2
4244	1	7	5	3
4244	1	6	6	\N
4244	1	5	7	\N
4244	1	4	8	4
4269	4	39	0	0
4269	1	11	1	1
4269	1	10	2	2
4269	1	9	3	\N
4269	1	8	4	\N
4269	1	7	5	\N
4269	1	6	6	3
4269	1	5	7	\N
4269	1	4	8	4
4269	2	19	9	\N
4269	2	20	10	\N
4269	2	21	11	5
4269	4	41	12	6
4269	3	27	13	\N
4269	3	26	14	\N
4269	3	25	15	7
4272	4	39	0	0
4272	1	11	1	1
4272	1	10	2	\N
4272	1	9	3	2
4272	1	8	4	3
4272	3	27	5	\N
4272	3	26	6	4
4272	3	28	7	\N
4272	3	29	8	\N
4272	2	21	9	5
4273	4	39	0	0
4273	1	11	1	\N
4273	1	10	2	1
4273	1	9	3	2
4273	1	8	4	\N
4273	3	27	5	\N
4273	3	26	6	\N
4273	3	28	7	\N
4273	3	29	8	\N
4273	2	21	9	3
4273	2	20	10	4
4279	4	39	0	0
4279	1	11	1	1
4279	1	10	2	2
4279	1	9	3	3
4279	1	8	4	\N
4279	3	28	5	4
4279	3	29	6	5
4279	2	21	7	\N
4279	2	20	8	\N
4279	2	19	9	6
4279	1	4	10	\N
4279	1	3	11	7
4279	1	2	12	8
4279	1	5	13	9
4287	4	39	0	0
4287	1	11	1	1
4287	1	10	2	\N
4287	1	9	3	2
4287	1	8	4	\N
4287	3	28	5	\N
4287	3	29	6	\N
4287	2	21	7	3
4287	2	20	8	\N
4287	2	19	9	4
4287	1	4	10	\N
4287	2	18	11	5
4287	2	17	12	\N
4287	2	22	13	6
4287	2	23	14	\N
4287	2	24	15	7
4306	4	39	0	0
4306	1	11	1	\N
4306	4	38	2	1
4306	4	37	3	2
4306	4	36	4	3
4306	4	40	5	\N
4306	2	21	6	\N
4306	2	20	7	4
4314	4	39	0	0
4314	4	40	1	1
4314	2	21	2	\N
4314	2	20	3	\N
4314	2	19	4	2
4314	1	4	5	\N
4314	1	3	6	3
4314	1	2	7	4
4314	1	5	8	\N
4314	1	6	9	5
4314	1	7	10	6
4317	4	39	0	0
4317	4	40	1	1
4317	2	21	2	2
4317	2	20	3	3
4317	2	19	4	4
4317	1	4	5	\N
4317	1	3	6	\N
4317	1	2	7	5
4317	1	5	8	6
4317	1	6	9	7
4317	1	7	10	\N
4317	1	8	11	\N
4317	1	9	12	8
4317	1	10	13	9
4334	4	39	0	0
4334	4	40	1	1
4334	2	21	2	2
4334	2	20	3	3
4334	2	19	4	4
4334	1	4	5	5
4334	1	5	6	6
4334	1	6	7	7
4334	1	7	8	8
4334	1	8	9	\N
4334	3	28	10	\N
4334	2	18	11	9
4334	2	17	12	\N
4334	2	16	13	10
4340	4	39	0	0
4340	4	40	1	1
4340	2	21	2	\N
4340	2	22	3	\N
4340	2	23	4	2
4340	3	29	5	\N
4340	3	28	6	3
4340	1	8	7	4
4343	4	39	0	0
4343	4	40	1	1
4343	2	21	2	2
4343	2	22	3	\N
4343	2	23	4	3
4343	3	29	5	\N
4343	3	28	6	\N
4343	1	8	7	4
4343	1	7	8	5
4343	1	6	9	\N
4343	1	5	10	6
4351	4	39	0	0
4351	4	40	1	\N
4351	2	21	2	1
4351	3	29	3	2
4351	3	28	4	\N
4351	1	8	5	3
4351	1	7	6	4
4351	1	6	7	5
4351	1	5	8	\N
4351	1	4	9	6
4351	2	18	10	\N
4351	2	17	11	\N
4351	2	19	12	7
4358	4	39	0	0
4358	4	40	1	\N
4358	2	21	2	1
4358	3	29	3	2
4358	3	28	4	\N
4358	1	8	5	3
4358	1	7	6	\N
4358	1	6	7	\N
4358	1	5	8	4
4358	1	4	9	\N
4358	2	19	10	5
4358	1	9	11	6
4358	1	10	12	\N
4358	1	11	13	\N
4358	1	12	14	\N
4358	1	13	15	\N
4358	1	14	16	7
4363	4	39	0	0
4363	4	40	1	1
4363	2	21	2	\N
4363	3	29	3	2
4363	3	28	4	3
4363	1	8	5	\N
4363	1	9	6	4
4363	1	10	7	\N
4363	1	11	8	5
4363	1	12	9	6
4363	1	13	10	7
4363	1	14	11	8
4363	4	38	12	\N
4363	4	37	13	\N
4363	4	36	14	9
4363	4	35	15	10
4368	4	39	0	0
4368	4	40	1	\N
4368	2	21	2	\N
4368	3	29	3	\N
4368	3	28	4	1
4368	1	8	5	2
4368	3	27	6	\N
4368	3	26	7	\N
4368	3	30	8	\N
4368	3	31	9	3
4375	4	40	0	0
4375	2	21	1	1
4375	2	20	2	2
4380	4	40	0	0
4380	2	21	1	\N
4380	2	20	2	\N
4380	2	19	3	\N
4380	1	4	4	\N
4380	1	3	5	1
4380	1	2	6	2
4380	1	1	7	3
4381	4	40	0	0
4381	2	21	1	\N
4381	2	20	2	1
4381	2	19	3	\N
4381	1	4	4	2
4381	1	3	5	\N
4381	1	2	6	3
4381	1	5	7	4
4416	4	40	0	0
4416	2	21	1	\N
4416	2	22	2	1
4416	2	23	3	\N
4416	3	29	4	2
4416	3	28	5	\N
4416	1	8	6	3
4416	1	7	7	\N
4416	1	6	8	4
4416	1	5	9	5
4416	1	4	10	\N
4416	1	3	11	\N
4416	1	2	12	6
4417	4	40	0	0
4417	2	21	1	1
4417	2	22	2	\N
4417	2	23	3	\N
4417	3	29	4	\N
4417	3	28	5	\N
4417	1	8	6	2
4417	1	7	7	\N
4417	1	6	8	\N
4417	1	5	9	3
4417	1	4	10	\N
4417	1	3	11	\N
4417	1	2	12	4
4417	1	1	13	5
4419	4	40	0	0
4419	2	21	1	1
4419	3	29	2	2
4419	3	28	3	\N
4419	1	8	4	3
4419	1	7	5	\N
4419	1	6	6	4
4419	1	5	7	5
4419	1	4	8	6
4419	1	3	9	7
4419	1	2	10	8
4419	2	18	11	9
4419	2	17	12	10
4428	4	40	0	0
4428	2	21	1	\N
4428	3	29	2	1
4428	3	28	3	\N
4428	1	8	4	2
4428	1	7	5	\N
4428	1	6	6	3
4428	1	5	7	4
4428	1	4	8	5
4428	2	19	9	6
4428	1	9	10	7
4428	1	10	11	\N
4428	1	11	12	\N
4428	1	12	13	\N
4428	1	13	14	\N
4428	1	14	15	8
4431	4	40	0	0
4431	2	21	1	\N
4431	3	29	2	\N
4431	3	28	3	1
4431	1	8	4	\N
4431	1	9	5	2
4431	1	10	6	3
4431	1	11	7	\N
4431	1	12	8	\N
4431	1	13	9	4
4431	1	14	10	5
4431	4	38	11	\N
4431	4	37	12	6
4439	4	40	0	0
4439	2	21	1	1
4439	3	29	2	2
4439	3	28	3	3
4439	1	8	4	4
4439	3	27	5	5
4439	3	26	6	6
4439	3	30	7	\N
4439	3	31	8	7
4443	4	40	0	0
4443	2	21	1	1
4443	3	30	2	\N
4443	3	31	3	\N
4443	3	32	4	2
4443	3	33	5	\N
4443	4	41	6	3
4457	4	40	0	0
4457	4	39	1	\N
4457	1	11	2	1
4457	1	10	3	2
4457	1	9	4	\N
4457	1	8	5	\N
4457	1	7	6	\N
4457	1	6	7	3
4457	1	5	8	4
4457	1	4	9	\N
4457	1	3	10	\N
4457	1	2	11	5
4457	2	18	12	6
4470	4	40	0	0
4470	4	39	1	1
4470	1	11	2	\N
4470	1	10	3	\N
4470	1	9	4	2
4470	1	8	5	3
4470	1	7	6	\N
4470	1	6	7	\N
4470	1	5	8	\N
4470	1	4	9	\N
4470	2	19	10	\N
4470	2	20	11	4
4470	2	21	12	\N
4470	3	29	13	5
4470	3	30	14	6
4470	3	31	15	\N
4470	3	32	16	7
4473	4	40	0	0
4473	4	39	1	1
4473	1	11	2	2
4473	1	10	3	\N
4473	1	9	4	\N
4473	1	8	5	3
4473	1	7	6	\N
4473	1	6	7	\N
4473	1	5	8	\N
4473	1	4	9	\N
4473	2	19	10	4
4473	2	20	11	5
4473	2	21	12	6
4473	3	30	13	\N
4473	3	31	14	7
4473	3	32	15	\N
4473	3	33	16	\N
4473	4	41	17	8
4476	4	40	0	0
4476	4	39	1	\N
4476	1	11	2	\N
4476	1	10	3	1
4476	1	9	4	2
4476	1	8	5	3
4476	1	7	6	4
4476	1	6	7	\N
4476	1	5	8	\N
4476	1	4	9	\N
4476	2	19	10	\N
4476	2	20	11	\N
4476	2	21	12	\N
4476	4	41	13	\N
4476	3	27	14	\N
4476	3	26	15	5
4486	4	40	0	0
4486	4	39	1	\N
4486	1	11	2	1
4486	1	10	3	2
4486	1	9	4	\N
4486	1	8	5	\N
4486	3	27	6	3
4486	3	26	7	4
4486	3	28	8	5
4486	3	29	9	\N
4486	2	21	10	\N
4486	2	20	11	6
4486	2	19	12	\N
4486	1	4	13	7
4486	1	3	14	8
4486	1	2	15	\N
4486	1	1	16	9
4524	4	41	0	0
4524	2	21	1	1
4524	2	20	2	\N
4524	2	19	3	2
4524	1	4	4	\N
4524	1	3	5	\N
4524	1	2	6	3
4524	1	5	7	\N
4524	1	6	8	4
4524	1	7	9	\N
4524	1	8	10	\N
4524	1	9	11	5
4524	1	10	12	\N
4524	1	11	13	6
4540	4	41	0	0
4540	2	21	1	1
4540	2	20	2	\N
4540	2	19	3	\N
4540	1	4	4	2
4540	1	5	5	\N
4540	1	6	6	\N
4540	1	7	7	\N
4540	1	8	8	\N
4540	3	28	9	\N
4540	2	18	10	3
4541	4	41	0	0
4541	2	21	1	1
4541	2	20	2	2
4541	2	19	3	3
4541	1	4	4	\N
4541	1	5	5	\N
4541	1	6	6	4
4541	1	7	7	\N
4541	1	8	8	5
4541	3	28	9	\N
4541	2	18	10	\N
4541	2	17	11	6
4552	4	41	0	0
4552	2	21	1	1
4552	2	22	2	\N
4552	2	23	3	2
4552	3	29	4	3
4552	3	28	5	\N
4552	1	8	6	4
4552	1	7	7	5
4552	1	6	8	6
4552	1	5	9	7
4552	1	4	10	8
4553	4	41	0	0
4553	2	21	1	1
4553	2	22	2	\N
4553	2	23	3	\N
4553	3	29	4	\N
4553	3	28	5	2
4553	1	8	6	\N
4553	1	7	7	3
4553	1	6	8	\N
4553	1	5	9	4
4553	1	4	10	5
4553	1	3	11	6
4557	4	41	0	0
4557	2	21	1	\N
4557	3	29	2	1
4557	3	28	3	2
4557	1	8	4	3
4557	1	7	5	\N
4557	1	6	6	\N
4557	1	5	7	\N
4557	1	4	8	4
4557	1	3	9	5
4557	1	2	10	6
4557	2	18	11	\N
4557	2	17	12	7
4560	4	41	0	0
4560	2	21	1	1
4560	3	29	2	\N
4560	3	28	3	2
4560	1	8	4	\N
4560	1	7	5	\N
4560	1	6	6	3
4560	1	5	7	\N
4560	1	4	8	\N
4560	2	18	9	\N
4560	2	17	10	4
4560	2	19	11	5
4560	2	20	12	6
4561	4	41	0	0
4561	2	21	1	\N
4561	3	29	2	1
4561	3	28	3	2
4561	1	8	4	3
4561	1	7	5	4
4561	1	6	6	\N
4561	1	5	7	5
4561	1	4	8	\N
4561	2	19	9	6
4561	1	9	10	7
4575	4	41	0	0
4575	2	21	1	1
4575	3	29	2	2
4575	3	28	3	\N
4575	1	8	4	3
4575	1	9	5	\N
4575	1	10	6	\N
4575	1	11	7	4
4575	4	39	8	5
4575	3	27	9	6
4575	3	26	10	7
4581	4	41	0	0
4581	2	21	1	\N
4581	3	29	2	1
4581	3	28	3	\N
4581	1	8	4	\N
4581	3	27	5	\N
4581	3	26	6	\N
4581	3	30	7	\N
4581	3	31	8	\N
4581	3	32	9	2
4581	3	33	10	\N
4581	3	34	11	3
4584	4	41	0	0
4584	2	21	1	\N
4584	3	30	2	1
4584	3	31	3	\N
4584	3	32	4	2
4584	3	33	5	3
4584	4	40	6	\N
4584	4	39	7	\N
4584	1	11	8	4
4604	4	41	0	0
4604	2	21	1	1
4604	4	40	2	\N
4604	4	39	3	2
4604	1	11	4	3
4604	1	10	5	4
4604	1	9	6	\N
4604	1	8	7	5
4604	3	27	8	6
4604	3	26	9	7
4604	3	28	10	\N
4604	3	29	11	8
4608	4	41	0	0
4608	2	21	1	1
4608	4	40	2	2
4608	4	39	3	3
4608	1	11	4	4
4608	1	10	5	5
4608	1	9	6	\N
4608	1	8	7	6
4608	3	28	8	\N
4608	1	12	9	7
4608	1	13	10	8
4608	1	14	11	\N
4608	1	15	12	9
4610	4	41	0	0
4610	2	21	1	\N
4610	4	40	2	\N
4610	4	39	3	\N
4610	1	11	4	1
4610	1	12	5	\N
4610	1	13	6	\N
4610	1	14	7	2
4610	4	38	8	\N
4610	4	37	9	3
4612	4	41	0	0
4612	2	21	1	\N
4612	4	40	2	1
4612	4	39	3	2
4612	1	11	4	\N
4612	1	12	5	\N
4612	1	13	6	\N
4612	1	14	7	\N
4612	4	38	8	\N
4612	4	37	9	\N
4612	4	36	10	\N
4612	4	35	11	3
4618	4	42	0	0
4618	4	41	1	\N
4618	2	21	2	\N
4618	2	20	3	\N
4618	2	19	4	\N
4618	1	4	5	1
4620	4	42	0	0
4620	4	41	1	1
4620	2	21	2	2
4620	2	20	3	\N
4620	2	19	4	\N
4620	1	4	5	3
4620	1	3	6	\N
4620	1	2	7	4
4647	4	42	0	0
4647	4	41	1	1
4647	2	21	2	\N
4647	2	20	3	\N
4647	2	19	4	\N
4647	1	4	5	\N
4647	2	18	6	2
4647	2	17	7	3
4647	2	22	8	4
4650	4	42	0	0
4650	4	41	1	\N
4650	2	21	2	1
4650	2	22	3	\N
4650	2	23	4	\N
4650	3	29	5	2
4667	4	42	0	0
4667	4	41	1	1
4667	2	21	2	\N
4667	3	29	3	2
4667	3	28	4	3
4667	1	8	5	4
4667	1	7	6	\N
4667	1	6	7	\N
4667	1	5	8	5
4667	1	4	9	6
4667	2	19	10	\N
4667	1	9	11	7
4667	1	10	12	8
4667	1	11	13	9
4673	4	42	0	0
4673	4	41	1	1
4673	2	21	2	\N
4673	3	29	3	\N
4673	3	28	4	2
4673	1	8	5	3
4673	1	9	6	4
4673	1	10	7	5
4673	1	11	8	\N
4673	1	12	9	6
4673	1	13	10	\N
4673	1	14	11	7
4673	4	38	12	8
4673	4	37	13	9
4674	4	42	0	0
4674	4	41	1	\N
4674	2	21	2	1
4674	3	29	3	\N
4674	3	28	4	2
4674	1	8	5	3
4674	1	9	6	4
4674	1	10	7	\N
4674	1	11	8	\N
4674	1	12	9	5
4674	1	13	10	\N
4674	1	14	11	\N
4674	4	38	12	6
4674	4	37	13	\N
4674	4	36	14	7
4688	4	42	0	0
4688	4	41	1	\N
4688	2	21	2	1
4688	3	30	3	2
4688	3	31	4	3
4688	3	32	5	\N
4688	3	33	6	4
4688	4	40	7	5
4688	4	39	8	6
4688	1	11	9	7
4704	4	42	0	0
4704	4	41	1	1
4704	2	21	2	\N
4704	4	40	3	\N
4704	4	39	4	2
4704	1	11	5	3
4704	1	10	6	\N
4704	1	9	7	\N
4704	1	8	8	4
4704	1	7	9	5
4704	1	6	10	\N
4704	1	5	11	6
4704	1	4	12	\N
4704	2	19	13	7
4704	3	27	14	8
4712	4	42	0	0
4712	4	41	1	1
4712	2	21	2	2
4712	4	40	3	\N
4712	4	39	4	\N
4712	1	11	5	3
4712	1	10	6	4
4712	1	9	7	\N
4712	1	8	8	\N
4712	3	28	9	5
4712	1	12	10	\N
4712	1	13	11	\N
4712	1	14	12	6
4712	1	15	13	7
4714	4	42	0	0
4714	4	41	1	1
4714	2	21	2	2
4714	4	40	3	\N
4714	4	39	4	\N
4714	1	11	5	\N
4714	1	12	6	3
4714	1	13	7	\N
4714	1	14	8	4
4714	4	38	9	5
4714	4	37	10	6
4727	5	44	0	0
4727	5	45	1	\N
4727	5	46	2	1
4727	5	47	3	2
4766	5	50	0	0
4766	5	49	1	\N
4767	1	1	0	0
4767	1	2	1	1
4767	1	3	2	\N
4767	1	4	3	2
4767	1	5	4	3
4767	1	6	5	\N
4767	1	7	6	\N
4767	1	8	7	4
4767	1	9	8	5
4767	1	10	9	\N
4767	1	11	10	6
4767	4	39	11	\N
4767	4	40	12	\N
4767	2	21	13	\N
4767	4	41	14	7
4767	3	27	15	8
4768	1	1	0	0
4768	1	2	1	1
4768	1	3	2	\N
4768	1	4	3	2
4768	1	5	4	3
4768	1	6	5	\N
4768	1	7	6	4
4768	1	8	7	5
4768	3	27	8	\N
4768	3	26	9	\N
4768	3	28	10	\N
4768	3	29	11	\N
4768	2	21	12	\N
4768	2	20	13	6
4769	1	1	0	0
4769	1	2	1	\N
4769	1	3	2	1
4769	1	4	3	\N
4769	1	5	4	\N
4769	1	6	5	\N
4769	1	7	6	\N
4769	1	8	7	\N
4769	3	28	8	\N
4769	3	29	9	\N
4769	2	21	10	2
4769	2	22	11	\N
4769	2	23	12	3
4769	3	30	13	4
4769	3	31	14	5
4769	3	32	15	6
4769	3	33	16	7
4770	1	1	0	0
4770	1	2	1	\N
4770	1	3	2	\N
4770	1	4	3	1
4770	2	19	4	2
4770	2	20	5	3
4770	2	21	6	4
4770	3	29	7	\N
4770	3	28	8	\N
4770	1	8	9	\N
4770	1	7	10	5
4770	1	6	11	\N
4770	1	9	12	\N
4770	1	10	13	6
4770	1	11	14	\N
4770	1	12	15	7
4771	1	1	0	0
4771	1	2	1	\N
4771	1	3	2	1
4771	1	4	3	2
4771	2	19	4	\N
4771	2	20	5	\N
4771	2	21	6	3
4771	3	29	7	\N
4771	3	28	8	4
4771	1	8	9	\N
4771	1	9	10	\N
4771	1	10	11	5
4771	1	11	12	6
4771	1	12	13	7
4771	1	13	14	8
4771	1	14	15	\N
4771	4	38	16	9
4771	4	37	17	\N
4771	4	36	18	10
4772	1	1	0	0
4772	1	2	1	1
4772	1	3	2	2
4772	1	4	3	\N
4772	2	19	4	\N
4772	2	20	5	\N
4772	2	21	6	3
4772	3	29	7	\N
4772	3	28	8	4
4772	1	8	9	\N
4772	1	9	10	5
4772	1	10	11	\N
4772	1	11	12	6
4772	1	12	13	7
4772	1	13	14	8
4772	1	14	15	9
4772	4	38	16	10
4772	4	37	17	11
4772	4	36	18	\N
4772	4	35	19	12
4773	1	1	0	0
4773	1	2	1	\N
4773	1	3	2	1
4773	1	4	3	2
4773	2	19	4	3
4773	2	20	5	4
4773	2	21	6	\N
4773	3	30	7	5
4773	3	31	8	\N
4773	3	32	9	\N
4773	3	33	10	6
4773	4	40	11	7
4773	4	39	12	8
4773	1	11	13	9
4774	1	1	0	0
4774	1	2	1	\N
4774	1	3	2	1
4774	1	4	3	2
4774	2	19	4	3
4774	2	20	5	4
4774	2	21	6	5
4774	4	40	7	6
4774	4	39	8	\N
4774	1	11	9	7
4774	1	10	10	\N
4774	1	9	11	\N
4774	1	8	12	8
4774	1	7	13	9
4774	1	6	14	10
4774	3	27	15	\N
4774	3	26	16	11
4774	3	25	17	12
4775	1	1	0	0
4775	1	2	1	1
4775	1	3	2	\N
4775	1	4	3	2
4775	2	19	4	3
4775	2	20	5	\N
4775	2	21	6	4
4775	4	40	7	5
4775	4	39	8	\N
4775	1	11	9	6
4775	1	12	10	\N
4775	1	13	11	\N
4775	1	14	12	7
4775	4	38	13	8
4775	4	37	14	\N
4775	4	36	15	\N
4775	4	35	16	9
4776	1	2	0	0
4776	1	3	1	1
4776	1	4	2	\N
4776	1	5	3	\N
4776	1	6	4	\N
4776	1	7	5	2
\.


--
-- Data for Name: rails; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.rails (rid, speed_limit) FROM stdin;
1	100
2	200
3	150
4	90
5	500
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.routes (route_id) FROM stdin;
22
36
42
50
85
91
92
105
114
124
132
134
135
139
155
157
158
167
171
178
206
208
239
262
276
301
313
315
339
369
376
380
384
387
397
410
422
424
427
431
455
467
468
477
483
487
488
495
497
516
519
536
542
554
580
590
634
635
637
649
655
683
684
685
689
690
695
696
714
728
732
734
741
745
746
747
753
761
768
771
795
823
824
835
842
866
869
872
906
916
923
964
981
983
989
992
998
1002
1008
1013
1022
1029
1033
1035
1041
1044
1049
1070
1081
1088
1091
1095
1110
1112
1113
1125
1126
1128
1158
1184
1191
1199
1205
1207
1212
1213
1220
1241
1251
1266
1278
1280
1284
1290
1317
1364
1370
1380
1393
1402
1407
1410
1412
1418
1432
1448
1451
1463
1464
1487
1488
1494
1506
1508
1515
1522
1535
1536
1546
1547
1552
1556
1562
1569
1578
1630
1646
1666
1669
1670
1676
1677
1690
1697
1704
1707
1713
1746
1757
1758
1765
1774
1780
1781
1784
1793
1795
1815
1817
1824
1830
1840
1842
1843
1844
1846
1858
1871
1896
1902
1906
1926
1930
1940
1953
1961
1975
2046
2048
2052
2062
2064
2068
2071
2074
2080
2098
2101
2102
2106
2107
2144
2162
2164
2175
2185
2186
2190
2195
2201
2205
2206
2208
2223
2227
2259
2274
2280
2299
2308
2316
2322
2346
2347
2361
2376
2401
2409
2419
2426
2429
2435
2440
2448
2450
2481
2504
2517
2519
2539
2542
2543
2557
2569
2571
2610
2641
2655
2656
2659
2660
2661
2666
2694
2695
2702
2712
2717
2720
2731
2744
2751
2752
2789
2792
2806
2810
2817
2830
2838
2840
2854
2860
2884
2886
2888
2890
2904
2912
2914
2921
2922
2923
2924
2926
2931
2936
2947
2954
2959
2964
2977
3021
3024
3032
3046
3048
3058
3062
3071
3104
3105
3115
3139
3141
3142
3153
3160
3178
3179
3186
3198
3207
3209
3211
3217
3221
3230
3232
3239
3248
3280
3318
3321
3323
3338
3344
3355
3373
3375
3416
3422
3441
3443
3444
3446
3457
3458
3461
3467
3473
3478
3503
3511
3513
3526
3529
3538
3563
3565
3572
3577
3581
3590
3610
3611
3612
3664
3690
3698
3724
3726
3728
3730
3739
3743
3747
3753
3759
3777
3788
3793
3813
3815
3821
3822
3843
3844
3854
3870
3877
3878
3917
3925
3928
3957
3962
3991
3997
3998
4001
4002
4003
4011
4015
4021
4025
4034
4046
4053
4054
4069
4083
4093
4095
4119
4135
4139
4155
4168
4173
4177
4183
4192
4193
4209
4220
4226
4231
4234
4238
4244
4269
4272
4273
4279
4287
4306
4314
4317
4334
4340
4343
4351
4358
4363
4368
4375
4380
4381
4416
4417
4419
4428
4431
4439
4443
4457
4470
4473
4476
4486
4524
4540
4541
4552
4553
4557
4560
4561
4575
4581
4584
4604
4608
4610
4612
4618
4620
4647
4650
4667
4673
4674
4688
4704
4712
4714
4727
4766
4767
4768
4769
4770
4771
4772
4773
4774
4775
4776
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.schedules (route_id, tid, day, "time", available_seats) FROM stdin;
22	328	Saturday	02:28:00	120
22	128	Sunday	04:46:00	220
22	344	Thursday	03:02:00	180
22	249	Tuesday	07:29:00	250
22	53	Wednesday	04:05:00	320
36	337	Friday	00:54:00	90
36	213	Monday	09:05:00	320
36	308	Sunday	03:53:00	320
36	237	Wednesday	06:03:00	180
36	76	Wednesday	08:30:00	90
42	58	Saturday	05:58:00	220
42	63	Saturday	09:21:00	250
42	264	Sunday	03:16:00	150
42	135	Tuesday	12:03:00	300
42	44	Wednesday	00:01:00	120
50	15	Saturday	07:20:00	300
50	288	Sunday	03:28:00	120
50	51	Thursday	03:16:00	150
50	89	Thursday	13:03:00	250
50	116	Wednesday	13:44:00	330
85	147	Sunday	08:47:00	220
85	16	Sunday	12:43:00	180
85	199	Thursday	06:52:00	220
85	244	Tuesday	13:41:00	300
85	313	Wednesday	01:14:00	150
91	101	Friday	09:09:00	180
91	71	Monday	05:21:00	250
91	138	Saturday	13:39:00	250
91	212	Wednesday	04:40:00	150
92	137	Friday	04:13:00	330
92	8	Monday	00:58:00	220
92	196	Tuesday	00:04:00	80
105	297	Monday	05:29:00	320
105	318	Sunday	11:49:00	90
105	246	Thursday	10:44:00	220
105	21	Thursday	17:16:00	80
114	317	Saturday	03:43:00	300
114	258	Thursday	10:27:00	180
114	11	Thursday	12:27:00	120
114	73	Tuesday	08:09:00	320
114	41	Wednesday	08:21:00	220
124	256	Saturday	04:20:00	80
124	347	Sunday	05:58:00	120
124	329	Wednesday	09:00:00	330
132	33	Friday	11:57:00	120
132	151	Monday	07:32:00	320
132	118	Monday	12:40:00	80
132	9	Wednesday	05:28:00	320
134	232	Monday	01:28:00	220
134	221	Monday	02:24:00	80
134	19	Saturday	10:58:00	320
134	184	Saturday	11:55:00	150
134	350	Thursday	00:37:00	330
135	94	Friday	03:05:00	300
135	253	Monday	10:47:00	330
135	185	Sunday	03:59:00	320
135	269	Sunday	06:52:00	90
139	32	Friday	07:23:00	250
139	67	Saturday	11:47:00	80
139	214	Tuesday	05:16:00	150
139	192	Wednesday	05:46:00	220
139	84	Wednesday	09:42:00	90
155	172	Monday	15:46:00	220
155	203	Saturday	04:13:00	90
155	48	Wednesday	03:39:00	120
157	126	Friday	15:07:00	220
157	98	Sunday	03:31:00	330
157	195	Tuesday	09:36:00	120
158	266	Friday	06:41:00	80
158	324	Friday	06:59:00	150
158	82	Monday	02:20:00	300
158	23	Tuesday	12:01:00	180
167	323	Monday	03:53:00	220
167	181	Sunday	11:33:00	320
167	77	Thursday	16:32:00	250
167	75	Wednesday	11:05:00	150
171	168	Sunday	12:52:00	180
171	140	Tuesday	03:39:00	300
171	303	Tuesday	13:58:00	330
178	60	Thursday	09:08:00	150
178	274	Tuesday	10:10:00	250
178	167	Wednesday	05:54:00	90
206	225	Saturday	04:01:00	150
206	306	Sunday	14:31:00	90
206	202	Thursday	04:48:00	320
208	65	Monday	08:16:00	80
208	260	Tuesday	03:49:00	300
208	302	Wednesday	01:14:00	80
239	85	Saturday	15:52:00	320
239	92	Sunday	04:14:00	150
239	208	Thursday	03:10:00	320
262	343	Monday	14:07:00	80
262	218	Saturday	01:45:00	300
262	171	Thursday	04:46:00	80
262	144	Thursday	09:38:00	120
276	162	Monday	13:29:00	150
276	45	Saturday	15:36:00	80
276	223	Sunday	03:25:00	320
276	309	Thursday	08:05:00	150
276	206	Tuesday	14:57:00	330
301	83	Friday	06:07:00	120
301	146	Saturday	13:35:00	220
301	36	Sunday	11:46:00	220
301	277	Thursday	04:45:00	120
301	312	Wednesday	10:28:00	150
313	320	Sunday	03:33:00	150
313	18	Thursday	02:08:00	220
313	56	Tuesday	07:29:00	320
313	136	Tuesday	13:57:00	250
313	173	Wednesday	12:15:00	90
315	103	Friday	12:55:00	330
315	86	Thursday	01:47:00	330
315	204	Thursday	12:28:00	220
339	262	Monday	04:26:00	150
339	335	Saturday	05:41:00	90
339	211	Sunday	07:21:00	320
339	22	Sunday	15:14:00	180
339	47	Wednesday	11:25:00	320
369	261	Monday	02:37:00	330
369	102	Monday	06:12:00	150
369	284	Thursday	08:19:00	150
376	54	Monday	11:22:00	80
376	5	Sunday	04:31:00	180
376	111	Wednesday	13:31:00	120
376	200	Wednesday	15:08:00	300
380	319	Monday	01:50:00	220
380	193	Thursday	15:48:00	300
380	157	Thursday	20:26:00	90
384	104	Friday	14:01:00	220
384	170	Friday	16:23:00	180
384	35	Sunday	10:36:00	150
387	148	Thursday	00:02:00	250
387	327	Thursday	09:37:00	150
387	20	Tuesday	02:13:00	150
397	10	Friday	15:37:00	320
397	62	Tuesday	07:19:00	220
397	29	Tuesday	13:12:00	320
397	325	Tuesday	14:45:00	180
410	315	Saturday	11:58:00	120
410	120	Sunday	08:15:00	220
410	61	Sunday	13:14:00	320
410	87	Tuesday	08:42:00	150
422	268	Friday	06:22:00	80
422	12	Monday	15:26:00	120
422	96	Saturday	17:17:00	250
422	4	Sunday	00:26:00	220
424	57	Friday	07:25:00	220
424	113	Friday	08:53:00	330
424	117	Sunday	04:43:00	330
424	130	Wednesday	02:09:00	180
427	231	Saturday	09:19:00	80
427	201	Thursday	12:56:00	80
427	267	Tuesday	07:21:00	220
431	72	Friday	02:48:00	180
431	240	Friday	04:40:00	330
431	190	Monday	10:44:00	150
431	139	Thursday	01:10:00	90
455	59	Monday	05:48:00	180
455	330	Monday	07:50:00	150
455	251	Saturday	02:58:00	250
455	17	Thursday	04:05:00	120
455	88	Thursday	04:27:00	300
467	95	Friday	10:45:00	150
467	164	Saturday	11:54:00	180
467	285	Sunday	02:55:00	300
468	46	Sunday	02:57:00	80
468	238	Thursday	08:57:00	180
468	176	Tuesday	16:03:00	320
468	154	Wednesday	15:22:00	150
477	271	Monday	07:00:00	320
477	165	Thursday	06:20:00	180
477	66	Tuesday	11:13:00	120
483	79	Sunday	17:59:00	90
483	6	Thursday	10:16:00	80
483	194	Tuesday	14:38:00	180
487	55	Monday	13:30:00	120
487	216	Sunday	13:59:00	90
487	80	Thursday	01:27:00	330
487	182	Thursday	08:14:00	250
487	189	Tuesday	12:31:00	150
488	282	Monday	08:46:00	330
488	334	Saturday	00:41:00	220
488	191	Saturday	09:06:00	80
488	292	Saturday	13:43:00	320
488	38	Tuesday	10:13:00	320
495	332	Monday	16:18:00	90
495	124	Sunday	05:20:00	300
495	114	Tuesday	12:44:00	300
495	220	Wednesday	03:04:00	180
497	188	Friday	03:33:00	320
497	273	Thursday	12:05:00	250
497	69	Tuesday	15:12:00	120
516	178	Monday	06:38:00	80
516	349	Saturday	18:09:00	300
516	241	Sunday	04:19:00	250
516	2	Sunday	10:20:00	90
519	141	Friday	08:03:00	80
519	275	Friday	10:20:00	80
519	283	Monday	08:51:00	330
519	149	Monday	18:36:00	80
519	265	Sunday	09:02:00	330
536	229	Sunday	02:27:00	80
536	316	Sunday	04:51:00	150
536	279	Thursday	17:52:00	120
542	160	Monday	14:02:00	80
542	239	Sunday	04:39:00	220
542	134	Wednesday	03:59:00	80
554	52	Friday	13:35:00	330
554	346	Thursday	06:10:00	250
554	255	Wednesday	12:50:00	300
580	50	Friday	10:45:00	330
580	252	Monday	06:45:00	80
580	7	Monday	14:13:00	250
580	263	Sunday	15:49:00	90
580	93	Wednesday	17:12:00	90
590	333	Sunday	10:11:00	80
590	248	Thursday	07:19:00	120
590	14	Tuesday	16:08:00	150
590	159	Wednesday	16:32:00	300
634	37	Friday	14:40:00	250
634	207	Monday	12:05:00	180
634	345	Sunday	00:41:00	120
634	145	Sunday	04:41:00	120
634	197	Tuesday	17:29:00	90
635	187	Saturday	00:14:00	320
635	158	Sunday	08:54:00	330
635	78	Tuesday	08:32:00	320
637	281	Friday	06:08:00	90
637	296	Friday	14:49:00	330
637	257	Sunday	13:12:00	90
637	26	Wednesday	08:33:00	180
649	295	Monday	04:33:00	220
649	112	Tuesday	00:01:00	250
649	331	Tuesday	11:40:00	320
655	338	Monday	01:40:00	120
655	224	Saturday	18:45:00	330
655	74	Thursday	08:34:00	80
655	272	Tuesday	12:10:00	180
655	39	Tuesday	15:54:00	220
683	30	Thursday	09:01:00	250
683	341	Thursday	09:02:00	300
683	280	Thursday	14:12:00	150
683	293	Tuesday	04:19:00	90
684	270	Friday	09:28:00	90
684	106	Monday	01:22:00	180
684	243	Wednesday	10:20:00	180
684	3	Wednesday	14:33:00	330
685	245	Friday	04:58:00	180
685	307	Friday	06:01:00	250
685	100	Saturday	12:37:00	320
685	228	Tuesday	12:38:00	330
685	219	Wednesday	05:55:00	180
689	314	Friday	00:25:00	80
689	304	Friday	12:26:00	300
689	34	Monday	12:09:00	90
689	322	Saturday	12:54:00	120
689	68	Tuesday	08:26:00	300
690	27	Monday	17:12:00	330
690	25	Saturday	09:10:00	120
690	286	Saturday	14:17:00	330
690	175	Tuesday	11:06:00	90
690	133	Wednesday	15:04:00	330
695	143	Friday	02:04:00	250
695	205	Saturday	15:15:00	330
695	131	Tuesday	08:33:00	90
696	300	Friday	08:40:00	150
696	179	Saturday	06:11:00	330
696	301	Tuesday	01:23:00	80
696	234	Tuesday	06:55:00	320
714	348	Sunday	18:56:00	330
714	153	Sunday	19:08:00	320
714	81	Thursday	07:11:00	150
714	123	Wednesday	11:31:00	320
728	250	Friday	00:49:00	80
728	310	Monday	06:32:00	300
728	242	Saturday	15:09:00	150
728	1	Thursday	16:28:00	150
728	142	Wednesday	09:33:00	220
732	311	Monday	09:43:00	220
732	186	Sunday	06:05:00	220
732	43	Wednesday	02:21:00	150
734	91	Monday	14:33:00	250
734	230	Wednesday	08:22:00	320
734	109	Wednesday	18:01:00	180
741	298	Saturday	05:17:00	300
741	235	Sunday	09:35:00	250
741	177	Sunday	11:17:00	80
741	99	Tuesday	12:06:00	150
745	31	Friday	01:43:00	330
745	127	Saturday	05:57:00	320
745	49	Sunday	02:52:00	250
745	122	Thursday	01:06:00	330
746	210	Friday	11:05:00	300
746	198	Monday	05:14:00	320
746	108	Tuesday	00:28:00	220
747	107	Sunday	01:57:00	180
747	290	Sunday	05:50:00	180
747	180	Tuesday	02:14:00	180
753	13	Friday	05:14:00	320
753	115	Sunday	10:05:00	180
753	156	Sunday	10:35:00	220
753	161	Thursday	00:29:00	80
761	166	Saturday	12:46:00	250
761	226	Sunday	18:11:00	300
761	24	Tuesday	02:09:00	330
761	215	Wednesday	00:29:00	90
768	125	Friday	17:18:00	90
768	278	Thursday	11:41:00	120
768	209	Tuesday	16:53:00	220
768	305	Wednesday	10:37:00	90
771	110	Friday	06:31:00	120
771	121	Monday	05:37:00	330
771	152	Monday	17:18:00	320
795	163	Saturday	14:00:00	300
795	217	Sunday	05:06:00	300
795	336	Thursday	09:23:00	90
795	222	Tuesday	04:41:00	150
823	254	Friday	10:41:00	150
823	183	Saturday	03:30:00	330
823	227	Saturday	04:52:00	250
823	326	Sunday	10:17:00	150
823	342	Thursday	12:31:00	330
824	42	Monday	08:31:00	120
824	169	Saturday	01:43:00	330
824	291	Tuesday	07:09:00	300
835	294	Friday	18:52:00	120
835	105	Saturday	15:38:00	150
835	28	Tuesday	00:04:00	320
842	132	Monday	08:19:00	320
842	321	Monday	19:45:00	300
842	70	Saturday	11:05:00	180
842	276	Saturday	13:21:00	330
842	119	Tuesday	16:21:00	180
866	233	Friday	05:17:00	90
866	155	Saturday	00:31:00	150
866	247	Saturday	15:51:00	220
866	90	Thursday	09:35:00	120
869	259	Sunday	07:56:00	220
869	129	Thursday	01:40:00	80
869	340	Tuesday	13:59:00	330
872	339	Monday	09:37:00	220
872	236	Saturday	03:12:00	180
872	287	Tuesday	09:41:00	250
872	97	Wednesday	01:16:00	180
872	150	Wednesday	07:21:00	220
906	299	Tuesday	05:32:00	250
906	64	Tuesday	13:30:00	250
906	174	Wednesday	15:10:00	90
916	345	Friday	13:08:00	120
916	40	Monday	04:57:00	330
916	321	Tuesday	13:05:00	300
916	289	Wednesday	02:00:00	300
923	75	Friday	15:50:00	150
923	325	Saturday	17:40:00	180
923	205	Sunday	14:06:00	330
923	38	Thursday	19:00:00	320
964	253	Saturday	03:15:00	330
964	130	Saturday	04:28:00	180
964	172	Saturday	14:13:00	220
964	256	Tuesday	02:23:00	80
981	295	Friday	14:42:00	220
981	208	Monday	02:02:00	320
981	276	Thursday	04:29:00	330
981	30	Tuesday	18:54:00	250
981	260	Wednesday	03:53:00	300
983	57	Monday	09:10:00	220
983	98	Sunday	08:16:00	330
983	78	Tuesday	12:01:00	320
989	290	Sunday	01:13:00	180
989	7	Thursday	18:22:00	250
989	237	Tuesday	03:29:00	180
989	266	Tuesday	13:04:00	80
989	280	Tuesday	21:44:00	150
992	124	Friday	10:30:00	300
992	25	Monday	08:32:00	120
992	64	Saturday	12:31:00	250
992	226	Thursday	12:08:00	300
998	62	Friday	05:14:00	220
998	151	Monday	13:30:00	320
998	202	Sunday	08:03:00	320
998	341	Tuesday	22:07:00	300
998	294	Tuesday	22:53:00	120
1002	299	Saturday	15:10:00	250
1002	93	Saturday	18:12:00	90
1002	79	Sunday	03:17:00	90
1002	209	Wednesday	04:58:00	220
1002	113	Wednesday	19:14:00	330
1008	271	Saturday	12:42:00	320
1008	80	Thursday	12:46:00	330
1008	165	Thursday	16:16:00	180
1008	147	Wednesday	01:14:00	220
1008	282	Wednesday	09:15:00	330
1013	166	Saturday	00:52:00	250
1013	304	Saturday	10:44:00	300
1013	26	Tuesday	00:01:00	180
1022	257	Monday	10:19:00	90
1022	339	Saturday	06:28:00	220
1022	200	Wednesday	08:55:00	300
1029	227	Monday	03:37:00	250
1029	46	Monday	14:14:00	80
1029	214	Tuesday	13:14:00	150
1033	134	Friday	08:15:00	80
1033	216	Saturday	13:22:00	90
1033	233	Sunday	03:59:00	90
1033	183	Sunday	04:12:00	330
1033	31	Wednesday	06:29:00	330
1035	146	Friday	12:27:00	220
1035	121	Sunday	07:53:00	330
1035	247	Sunday	16:21:00	220
1041	228	Friday	01:19:00	330
1041	350	Friday	07:24:00	330
1041	55	Sunday	13:41:00	120
1041	125	Thursday	16:39:00	90
1044	53	Friday	11:04:00	320
1044	141	Monday	08:33:00	80
1044	293	Saturday	11:34:00	90
1044	77	Saturday	17:16:00	250
1044	117	Thursday	03:46:00	330
1049	122	Friday	00:53:00	330
1049	289	Sunday	11:09:00	300
1049	48	Tuesday	10:43:00	120
1049	87	Wednesday	05:35:00	150
1049	89	Wednesday	12:43:00	250
1070	115	Friday	01:11:00	180
1070	274	Friday	06:41:00	250
1070	264	Monday	05:36:00	150
1070	338	Sunday	10:14:00	120
1070	323	Wednesday	03:46:00	220
1081	278	Saturday	15:01:00	120
1081	206	Sunday	06:33:00	330
1081	285	Thursday	06:51:00	300
1081	291	Tuesday	02:31:00	300
1088	10	Monday	05:03:00	320
1088	179	Monday	06:17:00	330
1088	50	Saturday	04:05:00	330
1088	199	Sunday	12:02:00	220
1088	331	Wednesday	05:39:00	320
1091	133	Monday	00:28:00	330
1091	328	Saturday	14:28:00	120
1091	229	Tuesday	00:57:00	80
1091	217	Tuesday	06:10:00	300
1091	333	Wednesday	02:15:00	80
1095	102	Friday	10:52:00	150
1095	212	Friday	16:58:00	150
1095	111	Saturday	01:06:00	120
1095	286	Saturday	18:37:00	330
1095	69	Sunday	07:33:00	120
1110	8	Monday	07:15:00	220
1110	97	Monday	08:08:00	180
1110	219	Saturday	08:02:00	180
1110	177	Saturday	08:04:00	80
1112	329	Sunday	17:14:00	330
1112	19	Thursday	07:02:00	320
1112	170	Thursday	16:26:00	180
1113	288	Sunday	09:24:00	120
1113	15	Thursday	14:47:00	300
1113	58	Tuesday	14:32:00	220
1125	308	Saturday	15:46:00	320
1125	116	Thursday	20:09:00	330
1125	5	Tuesday	12:51:00	180
1125	23	Tuesday	17:17:00	180
1126	47	Friday	20:12:00	320
1126	267	Thursday	20:09:00	220
1126	279	Wednesday	20:26:00	120
1128	2	Friday	01:03:00	90
1128	201	Saturday	00:35:00	80
1128	204	Saturday	06:42:00	220
1128	99	Tuesday	18:16:00	150
1158	6	Monday	11:05:00	80
1158	181	Saturday	02:46:00	320
1158	326	Saturday	11:03:00	150
1158	284	Sunday	03:01:00	150
1184	76	Friday	07:09:00	90
1184	245	Saturday	08:00:00	180
1184	275	Tuesday	09:17:00	80
1191	210	Monday	04:04:00	300
1191	86	Sunday	01:22:00	330
1191	182	Thursday	03:03:00	250
1191	342	Wednesday	09:13:00	330
1191	142	Wednesday	09:49:00	220
1199	160	Friday	00:45:00	80
1199	20	Saturday	11:00:00	150
1199	273	Sunday	10:28:00	250
1199	71	Tuesday	10:10:00	250
1199	343	Wednesday	02:38:00	80
1205	306	Monday	04:10:00	90
1205	143	Monday	08:37:00	250
1205	234	Monday	16:55:00	320
1205	191	Sunday	15:57:00	80
1205	258	Wednesday	14:09:00	180
1207	348	Friday	12:56:00	330
1207	251	Wednesday	00:18:00	250
1207	120	Wednesday	14:51:00	220
1207	150	Wednesday	15:35:00	220
1212	307	Friday	02:10:00	250
1212	32	Saturday	00:02:00	250
1212	104	Saturday	01:24:00	220
1212	45	Thursday	04:26:00	80
1213	248	Monday	07:46:00	120
1213	60	Saturday	00:06:00	150
1213	265	Sunday	01:55:00	330
1213	175	Thursday	06:48:00	90
1220	74	Monday	15:36:00	80
1220	118	Saturday	04:26:00	80
1220	215	Sunday	06:53:00	90
1220	33	Tuesday	01:13:00	120
1241	168	Monday	03:57:00	180
1241	190	Thursday	02:11:00	150
1241	292	Thursday	02:20:00	320
1241	65	Thursday	02:21:00	80
1251	192	Saturday	07:43:00	220
1251	272	Saturday	11:39:00	180
1251	330	Saturday	14:15:00	150
1251	240	Wednesday	13:20:00	330
1266	68	Friday	17:20:00	300
1266	318	Sunday	12:39:00	90
1266	155	Sunday	16:48:00	150
1266	305	Thursday	11:19:00	90
1266	73	Thursday	13:08:00	320
1278	144	Thursday	04:27:00	120
1278	211	Thursday	08:38:00	320
1278	221	Wednesday	02:34:00	80
1280	302	Friday	13:39:00	80
1280	85	Saturday	02:47:00	320
1280	238	Thursday	12:14:00	180
1280	128	Tuesday	01:05:00	220
1280	171	Wednesday	03:18:00	80
1284	54	Monday	06:23:00	80
1284	167	Sunday	17:56:00	90
1284	129	Wednesday	17:43:00	80
1290	22	Friday	11:42:00	180
1290	298	Sunday	09:50:00	300
1290	187	Sunday	10:19:00	320
1290	259	Tuesday	07:16:00	220
1290	42	Wednesday	02:09:00	120
1317	126	Friday	09:15:00	220
1317	114	Saturday	15:00:00	300
1317	94	Tuesday	12:36:00	300
1364	300	Friday	00:56:00	150
1364	27	Monday	01:38:00	330
1364	232	Monday	04:15:00	220
1364	313	Monday	09:56:00	150
1364	197	Tuesday	16:17:00	90
1370	239	Friday	01:03:00	220
1370	296	Monday	14:53:00	330
1370	301	Wednesday	07:50:00	80
1380	137	Friday	05:08:00	330
1380	13	Friday	06:51:00	320
1380	91	Saturday	18:29:00	250
1380	335	Sunday	05:51:00	90
1380	36	Sunday	09:08:00	220
1393	347	Saturday	05:49:00	120
1393	220	Saturday	16:36:00	180
1393	332	Thursday	10:09:00	90
1393	255	Tuesday	10:38:00	300
1393	311	Tuesday	11:37:00	220
1402	34	Monday	03:54:00	90
1402	236	Saturday	00:13:00	180
1402	176	Saturday	12:28:00	320
1402	139	Wednesday	02:10:00	90
1402	188	Wednesday	07:50:00	320
1407	334	Saturday	09:55:00	220
1407	159	Tuesday	06:47:00	300
1407	49	Tuesday	08:13:00	250
1407	1	Wednesday	03:00:00	150
1407	81	Wednesday	06:49:00	150
1410	195	Friday	14:12:00	120
1410	100	Thursday	10:32:00	320
1410	138	Wednesday	15:12:00	250
1412	163	Monday	13:45:00	300
1412	263	Sunday	04:53:00	90
1412	72	Thursday	14:23:00	180
1412	268	Tuesday	01:19:00	80
1418	303	Saturday	14:41:00	330
1418	41	Saturday	15:21:00	220
1418	174	Thursday	09:13:00	90
1432	225	Friday	21:44:00	150
1432	153	Monday	13:41:00	320
1432	207	Wednesday	11:08:00	180
1448	189	Friday	10:43:00	150
1448	324	Monday	15:16:00	150
1448	154	Sunday	00:38:00	150
1448	244	Thursday	11:47:00	300
1451	88	Friday	09:19:00	300
1451	17	Thursday	14:09:00	120
1451	193	Tuesday	03:26:00	300
1451	140	Wednesday	14:57:00	300
1463	18	Monday	11:30:00	220
1463	297	Saturday	02:28:00	320
1463	224	Sunday	13:38:00	330
1464	270	Monday	04:30:00	90
1464	83	Monday	11:56:00	120
1464	84	Sunday	00:17:00	90
1464	67	Sunday	10:50:00	80
1487	103	Friday	01:26:00	330
1487	346	Monday	02:37:00	250
1487	235	Tuesday	04:15:00	250
1488	40	Monday	11:44:00	330
1488	336	Saturday	01:36:00	90
1488	231	Wednesday	14:27:00	80
1494	28	Thursday	06:19:00	320
1494	66	Thursday	10:47:00	120
1494	246	Thursday	12:10:00	220
1506	14	Friday	14:53:00	150
1506	59	Saturday	14:29:00	180
1506	107	Sunday	16:58:00	180
1506	157	Tuesday	17:15:00	90
1506	145	Wednesday	09:15:00	120
1508	317	Friday	03:53:00	300
1508	312	Saturday	01:41:00	150
1508	184	Saturday	13:16:00	150
1508	35	Saturday	13:26:00	150
1508	106	Wednesday	05:08:00	180
1515	24	Saturday	00:06:00	330
1515	56	Sunday	03:28:00	320
1515	16	Wednesday	06:06:00	180
1522	218	Monday	12:54:00	300
1522	281	Tuesday	02:29:00	90
1522	82	Wednesday	14:54:00	300
1522	164	Wednesday	19:36:00	180
1535	108	Thursday	10:04:00	220
1535	173	Wednesday	11:52:00	90
1535	262	Wednesday	14:14:00	150
1536	213	Friday	06:58:00	320
1536	277	Monday	00:07:00	120
1536	43	Monday	08:22:00	150
1536	29	Thursday	12:23:00	320
1536	185	Tuesday	05:38:00	320
1546	92	Monday	02:48:00	150
1546	39	Saturday	07:56:00	220
1546	44	Tuesday	14:12:00	120
1547	349	Monday	20:01:00	300
1547	340	Saturday	06:37:00	330
1547	158	Tuesday	01:16:00	330
1552	131	Monday	13:26:00	90
1552	198	Saturday	20:18:00	320
1552	61	Wednesday	09:09:00	320
1556	51	Friday	14:44:00	150
1556	310	Saturday	12:18:00	300
1556	252	Saturday	20:25:00	80
1556	194	Wednesday	06:15:00	180
1556	9	Wednesday	11:00:00	320
1562	123	Sunday	16:53:00	320
1562	136	Thursday	06:48:00	250
1562	127	Tuesday	00:14:00	320
1569	105	Friday	10:05:00	150
1569	178	Tuesday	13:18:00	80
1569	230	Tuesday	15:02:00	320
1569	156	Wednesday	15:27:00	220
1578	162	Monday	09:16:00	150
1578	119	Saturday	01:33:00	180
1578	3	Saturday	13:47:00	330
1578	203	Sunday	01:28:00	90
1630	11	Friday	11:09:00	120
1630	90	Monday	03:03:00	120
1630	223	Thursday	12:25:00	320
1630	249	Tuesday	08:36:00	250
1630	243	Wednesday	17:10:00	180
1646	241	Friday	05:00:00	250
1646	148	Friday	19:23:00	250
1646	327	Tuesday	11:06:00	150
1666	109	Thursday	01:20:00	180
1666	132	Thursday	12:49:00	320
1666	70	Tuesday	12:15:00	180
1669	316	Friday	16:23:00	150
1669	52	Sunday	17:48:00	330
1669	319	Wednesday	17:09:00	220
1670	337	Friday	10:22:00	90
1670	169	Friday	15:31:00	330
1670	344	Friday	16:02:00	180
1670	314	Monday	10:25:00	80
1670	101	Saturday	04:42:00	180
1676	180	Sunday	22:26:00	180
1676	12	Tuesday	03:30:00	120
1676	110	Wednesday	01:27:00	120
1676	161	Wednesday	09:37:00	80
1677	186	Friday	12:50:00	220
1677	315	Friday	14:08:00	120
1677	196	Sunday	01:14:00	80
1677	322	Tuesday	05:59:00	120
1677	112	Tuesday	11:56:00	250
1690	283	Sunday	02:16:00	330
1690	269	Thursday	02:37:00	90
1690	261	Tuesday	11:37:00	330
1690	287	Wednesday	07:35:00	250
1697	95	Friday	14:16:00	150
1697	4	Thursday	02:42:00	220
1697	37	Tuesday	00:32:00	250
1697	250	Tuesday	06:12:00	80
1704	135	Friday	01:12:00	300
1704	254	Friday	09:40:00	150
1704	320	Sunday	16:05:00	150
1707	222	Friday	01:49:00	150
1707	309	Monday	01:45:00	150
1707	21	Sunday	04:31:00	80
1707	63	Thursday	05:43:00	250
1707	96	Wednesday	05:10:00	250
1713	242	Saturday	05:27:00	150
1713	149	Thursday	08:51:00	80
1713	152	Tuesday	16:17:00	320
1746	189	Monday	04:11:00	150
1746	75	Saturday	04:57:00	150
1746	28	Saturday	18:40:00	320
1746	134	Tuesday	05:43:00	80
1746	348	Wednesday	14:07:00	330
1757	170	Friday	01:25:00	180
1757	230	Saturday	06:00:00	320
1757	160	Sunday	08:54:00	80
1757	152	Tuesday	02:03:00	320
1758	51	Monday	15:55:00	150
1758	71	Sunday	04:28:00	250
1758	54	Sunday	07:02:00	80
1758	258	Tuesday	06:10:00	180
1765	125	Friday	07:22:00	90
1765	65	Monday	00:06:00	80
1765	165	Sunday	02:54:00	180
1765	176	Tuesday	11:55:00	320
1765	237	Wednesday	01:13:00	180
1774	104	Friday	04:07:00	220
1774	173	Sunday	03:53:00	90
1774	64	Tuesday	11:27:00	250
1774	179	Tuesday	13:43:00	330
1774	259	Wednesday	10:18:00	220
1780	184	Friday	05:06:00	150
1780	60	Monday	01:32:00	150
1780	155	Thursday	06:53:00	150
1780	202	Tuesday	03:23:00	320
1780	344	Tuesday	07:59:00	180
1781	166	Friday	13:28:00	250
1781	42	Saturday	14:16:00	120
1781	154	Tuesday	01:47:00	150
1781	146	Wednesday	11:10:00	220
1784	11	Monday	07:59:00	120
1784	137	Saturday	17:53:00	330
1784	296	Thursday	16:23:00	330
1793	5	Sunday	09:23:00	180
1793	100	Tuesday	07:12:00	320
1793	264	Tuesday	17:55:00	150
1793	43	Wednesday	11:11:00	150
1795	257	Friday	19:03:00	90
1795	291	Sunday	00:54:00	300
1795	143	Thursday	11:33:00	250
1795	131	Thursday	17:55:00	90
1795	241	Wednesday	04:33:00	250
1815	156	Friday	05:10:00	220
1815	77	Sunday	00:36:00	250
1815	268	Thursday	01:26:00	80
1815	135	Thursday	11:41:00	300
1815	148	Wednesday	00:07:00	250
1817	70	Friday	01:20:00	180
1817	269	Saturday	10:37:00	90
1817	333	Thursday	05:22:00	80
1824	250	Monday	07:10:00	80
1824	1	Saturday	07:04:00	150
1824	4	Tuesday	02:21:00	220
1824	38	Tuesday	12:24:00	320
1830	243	Friday	05:43:00	180
1830	245	Friday	13:58:00	180
1830	181	Monday	00:43:00	320
1830	221	Monday	08:31:00	80
1830	82	Sunday	04:01:00	300
1840	7	Thursday	13:34:00	250
1840	200	Tuesday	03:25:00	300
1840	62	Tuesday	05:38:00	220
1840	270	Tuesday	05:59:00	90
1842	347	Thursday	07:17:00	120
1842	197	Thursday	07:44:00	90
1842	6	Thursday	12:54:00	80
1842	21	Tuesday	01:03:00	80
1843	272	Friday	15:41:00	180
1843	249	Tuesday	04:34:00	250
1843	191	Wednesday	13:58:00	80
1844	207	Friday	11:04:00	180
1844	39	Saturday	14:10:00	220
1844	193	Tuesday	09:51:00	300
1844	13	Wednesday	12:17:00	320
1846	285	Friday	01:07:00	300
1846	110	Friday	13:22:00	120
1846	199	Thursday	10:20:00	220
1846	96	Wednesday	03:54:00	250
1858	35	Sunday	12:09:00	150
1858	91	Sunday	16:00:00	250
1858	56	Wednesday	13:33:00	320
1858	58	Wednesday	14:14:00	220
1858	286	Wednesday	18:55:00	330
1871	195	Friday	00:50:00	120
1871	18	Saturday	09:58:00	220
1871	274	Sunday	07:51:00	250
1871	15	Thursday	15:51:00	300
1871	147	Tuesday	04:40:00	220
1896	251	Friday	11:20:00	250
1896	222	Friday	14:39:00	150
1896	194	Monday	07:01:00	180
1902	326	Friday	06:39:00	150
1902	158	Monday	02:33:00	330
1902	59	Tuesday	04:01:00	180
1902	302	Tuesday	06:31:00	80
1902	112	Wednesday	01:24:00	250
1906	144	Monday	12:21:00	120
1906	281	Monday	13:38:00	90
1906	61	Thursday	02:39:00	320
1906	2	Thursday	14:41:00	90
1906	217	Wednesday	17:01:00	300
1926	140	Friday	08:20:00	300
1926	99	Monday	03:04:00	150
1926	41	Saturday	09:44:00	220
1926	332	Tuesday	12:43:00	90
1930	115	Friday	01:01:00	180
1930	231	Friday	14:38:00	80
1930	192	Monday	11:16:00	220
1930	254	Saturday	03:31:00	150
1940	24	Monday	08:33:00	330
1940	168	Thursday	09:12:00	180
1940	31	Wednesday	10:09:00	330
1953	37	Monday	06:20:00	250
1953	106	Monday	13:49:00	180
1953	284	Wednesday	13:40:00	150
1961	126	Friday	10:15:00	220
1961	216	Saturday	02:46:00	90
1961	47	Saturday	06:06:00	320
1961	248	Saturday	06:14:00	120
1975	8	Friday	10:54:00	220
1975	321	Saturday	14:29:00	300
1975	324	Thursday	06:11:00	150
1975	293	Thursday	06:12:00	90
1975	174	Wednesday	10:09:00	90
2046	336	Sunday	01:01:00	90
2046	123	Tuesday	13:17:00	320
2046	342	Wednesday	12:34:00	330
2048	343	Saturday	00:33:00	80
2048	263	Saturday	10:28:00	90
2048	226	Sunday	03:22:00	300
2048	345	Wednesday	06:44:00	120
2052	14	Monday	00:09:00	150
2052	98	Monday	07:54:00	330
2052	203	Saturday	05:23:00	90
2052	235	Sunday	08:38:00	250
2052	244	Thursday	06:17:00	300
2062	331	Friday	15:13:00	320
2062	57	Sunday	01:37:00	220
2062	307	Wednesday	19:05:00	250
2064	220	Monday	16:23:00	180
2064	208	Monday	19:53:00	320
2064	10	Tuesday	03:18:00	320
2064	323	Tuesday	05:18:00	220
2064	86	Wednesday	18:37:00	330
2068	297	Friday	04:01:00	320
2068	229	Monday	06:50:00	80
2068	283	Monday	17:19:00	330
2068	305	Thursday	12:25:00	90
2068	219	Tuesday	05:35:00	180
2071	276	Friday	07:26:00	330
2071	349	Monday	03:39:00	300
2071	25	Monday	07:16:00	120
2071	253	Saturday	08:28:00	330
2074	72	Monday	12:28:00	180
2074	236	Saturday	06:02:00	180
2074	164	Tuesday	05:05:00	180
2080	161	Saturday	03:09:00	80
2080	218	Saturday	13:09:00	300
2080	163	Tuesday	04:33:00	300
2080	223	Wednesday	04:05:00	320
2098	183	Monday	00:09:00	330
2098	320	Monday	15:24:00	150
2098	346	Sunday	04:57:00	250
2098	335	Tuesday	02:49:00	90
2098	180	Wednesday	06:08:00	180
2101	204	Friday	07:30:00	220
2101	55	Friday	07:51:00	120
2101	141	Saturday	15:46:00	80
2101	30	Thursday	05:59:00	250
2102	273	Monday	06:16:00	250
2102	128	Saturday	07:40:00	220
2102	97	Saturday	08:40:00	180
2106	12	Monday	00:54:00	120
2106	262	Tuesday	09:58:00	150
2106	136	Wednesday	02:46:00	250
2106	17	Wednesday	08:09:00	120
2107	246	Thursday	01:49:00	220
2107	261	Thursday	09:05:00	330
2107	171	Tuesday	01:37:00	80
2107	334	Wednesday	05:06:00	220
2144	132	Friday	06:30:00	320
2144	67	Friday	09:42:00	80
2144	312	Thursday	02:31:00	150
2144	127	Wednesday	03:31:00	320
2162	279	Monday	09:25:00	120
2162	139	Saturday	03:38:00	90
2162	81	Saturday	09:29:00	150
2162	210	Sunday	06:14:00	300
2164	44	Friday	10:03:00	120
2164	138	Saturday	12:04:00	250
2164	153	Sunday	12:55:00	320
2164	255	Tuesday	03:40:00	300
2164	303	Tuesday	06:51:00	330
2175	275	Monday	09:03:00	80
2175	308	Saturday	14:52:00	320
2175	114	Tuesday	14:47:00	300
2175	316	Wednesday	07:49:00	150
2185	40	Sunday	02:37:00	330
2185	215	Thursday	06:13:00	90
2185	80	Thursday	06:19:00	330
2185	247	Tuesday	08:19:00	220
2186	306	Thursday	02:24:00	90
2186	159	Thursday	15:56:00	300
2186	34	Thursday	16:38:00	90
2186	103	Tuesday	05:05:00	330
2190	33	Sunday	00:34:00	120
2190	142	Sunday	01:28:00	220
2190	298	Wednesday	00:42:00	300
2190	341	Wednesday	10:07:00	300
2195	201	Monday	00:43:00	80
2195	102	Monday	05:37:00	150
2195	309	Sunday	11:57:00	150
2195	186	Tuesday	03:24:00	220
2195	69	Tuesday	09:20:00	120
2201	232	Monday	17:31:00	220
2201	292	Sunday	05:43:00	320
2201	311	Tuesday	06:12:00	220
2201	129	Wednesday	17:56:00	80
2201	109	Wednesday	21:44:00	180
2205	288	Friday	06:12:00	120
2205	49	Friday	15:13:00	250
2205	88	Wednesday	17:48:00	300
2206	120	Friday	02:50:00	220
2206	94	Sunday	05:52:00	300
2206	162	Thursday	07:30:00	150
2206	27	Tuesday	16:18:00	330
2206	178	Wednesday	01:34:00	80
2208	187	Saturday	09:03:00	320
2208	206	Sunday	02:29:00	330
2208	101	Tuesday	01:46:00	180
2223	83	Friday	06:21:00	120
2223	256	Sunday	12:52:00	80
2223	16	Wednesday	03:03:00	180
2223	330	Wednesday	06:57:00	150
2227	118	Sunday	03:55:00	80
2227	19	Sunday	17:01:00	320
2227	85	Wednesday	18:41:00	320
2259	228	Sunday	18:03:00	330
2259	23	Thursday	15:23:00	180
2259	233	Thursday	16:48:00	90
2259	78	Tuesday	05:23:00	320
2274	119	Thursday	07:46:00	180
2274	214	Tuesday	10:21:00	150
2274	89	Wednesday	13:46:00	250
2280	22	Monday	15:57:00	180
2280	117	Thursday	06:58:00	330
2280	121	Tuesday	01:53:00	330
2299	319	Thursday	00:19:00	220
2299	151	Thursday	09:39:00	320
2299	108	Thursday	10:55:00	220
2308	224	Monday	03:45:00	330
2308	63	Monday	08:03:00	250
2308	111	Sunday	05:39:00	120
2308	172	Thursday	12:07:00	220
2316	93	Saturday	06:02:00	90
2316	116	Sunday	11:10:00	330
2316	289	Tuesday	00:21:00	300
2316	68	Tuesday	10:30:00	300
2316	213	Wednesday	12:58:00	320
2322	92	Monday	04:34:00	150
2322	242	Saturday	07:58:00	150
2322	84	Wednesday	03:36:00	90
2322	76	Wednesday	11:05:00	90
2346	205	Friday	06:44:00	330
2346	267	Friday	12:26:00	220
2346	20	Saturday	09:10:00	150
2346	74	Thursday	14:43:00	80
2346	145	Tuesday	03:45:00	120
2347	265	Sunday	09:34:00	330
2347	133	Thursday	05:33:00	330
2347	294	Thursday	13:21:00	120
2361	212	Monday	02:34:00	150
2361	328	Monday	05:03:00	120
2361	315	Saturday	13:28:00	120
2361	66	Thursday	13:14:00	120
2361	95	Tuesday	14:36:00	150
2376	177	Friday	19:28:00	80
2376	322	Sunday	05:36:00	120
2376	278	Sunday	11:02:00	120
2376	290	Thursday	04:01:00	180
2376	157	Thursday	20:17:00	90
2401	46	Saturday	11:40:00	80
2401	26	Tuesday	03:34:00	180
2401	327	Wednesday	12:10:00	150
2409	87	Friday	01:48:00	150
2409	339	Friday	15:09:00	220
2409	325	Tuesday	11:18:00	180
2419	198	Monday	02:15:00	320
2419	299	Monday	16:11:00	250
2419	29	Saturday	01:45:00	320
2419	287	Sunday	01:52:00	250
2426	48	Monday	01:53:00	120
2426	149	Sunday	11:36:00	80
2426	36	Thursday	10:24:00	220
2429	337	Friday	08:54:00	90
2429	271	Monday	07:56:00	320
2429	188	Saturday	08:37:00	320
2435	113	Friday	17:54:00	330
2435	73	Monday	14:10:00	320
2435	50	Saturday	19:49:00	330
2435	318	Thursday	00:19:00	90
2435	304	Tuesday	19:06:00	300
2440	3	Monday	14:06:00	330
2440	52	Saturday	19:31:00	330
2440	238	Tuesday	04:42:00	180
2448	225	Sunday	10:00:00	150
2448	182	Thursday	02:11:00	250
2448	185	Thursday	02:44:00	320
2448	340	Thursday	05:22:00	330
2448	90	Thursday	07:59:00	120
2450	266	Saturday	14:38:00	80
2450	252	Saturday	15:11:00	80
2450	169	Thursday	07:35:00	330
2450	227	Tuesday	13:27:00	250
2450	313	Wednesday	02:52:00	150
2481	314	Monday	07:04:00	80
2481	317	Saturday	05:40:00	300
2481	124	Tuesday	06:50:00	300
2504	167	Friday	04:24:00	90
2504	9	Saturday	20:55:00	320
2504	234	Wednesday	05:45:00	320
2517	79	Monday	16:18:00	90
2517	300	Tuesday	05:32:00	150
2517	32	Wednesday	02:26:00	250
2517	350	Wednesday	18:14:00	330
2519	295	Monday	14:50:00	220
2519	53	Sunday	02:12:00	320
2519	45	Thursday	01:40:00	80
2519	280	Thursday	08:16:00	150
2539	240	Saturday	02:14:00	330
2539	301	Thursday	05:55:00	80
2539	175	Tuesday	10:13:00	90
2539	239	Wednesday	08:41:00	220
2542	338	Friday	18:40:00	120
2542	107	Saturday	06:18:00	180
2542	150	Saturday	09:19:00	220
2542	209	Saturday	11:21:00	220
2543	282	Monday	05:38:00	330
2543	277	Saturday	14:09:00	120
2543	130	Sunday	13:35:00	180
2557	105	Thursday	01:57:00	150
2557	310	Thursday	07:45:00	300
2557	190	Thursday	11:18:00	150
2557	211	Wednesday	01:01:00	320
2557	122	Wednesday	13:49:00	330
2569	260	Monday	12:31:00	300
2569	196	Sunday	11:13:00	80
2569	329	Thursday	02:27:00	330
2571	133	Saturday	12:11:00	330
2571	191	Saturday	18:57:00	80
2571	271	Sunday	02:36:00	320
2571	36	Sunday	09:33:00	220
2571	239	Thursday	19:51:00	220
2610	205	Monday	00:01:00	330
2610	102	Saturday	15:13:00	150
2610	300	Thursday	09:04:00	150
2641	65	Saturday	15:56:00	80
2641	337	Sunday	07:06:00	90
2641	345	Thursday	06:08:00	120
2641	317	Wednesday	06:33:00	300
2655	117	Saturday	07:20:00	330
2655	138	Thursday	07:08:00	250
2655	53	Tuesday	12:13:00	320
2655	331	Wednesday	05:51:00	320
2656	157	Monday	07:04:00	90
2656	79	Monday	11:23:00	90
2656	257	Monday	18:55:00	90
2656	47	Saturday	08:44:00	320
2659	42	Friday	12:29:00	120
2659	88	Saturday	07:00:00	300
2659	163	Thursday	12:05:00	300
2659	164	Tuesday	09:21:00	180
2660	303	Friday	04:29:00	330
2660	188	Saturday	14:17:00	320
2660	158	Sunday	15:45:00	330
2661	155	Saturday	06:28:00	150
2661	267	Tuesday	02:00:00	220
2661	15	Tuesday	11:08:00	300
2661	159	Tuesday	11:17:00	300
2666	84	Friday	05:14:00	90
2666	105	Sunday	06:42:00	150
2666	196	Sunday	11:08:00	80
2666	35	Tuesday	14:47:00	150
2666	197	Wednesday	05:21:00	90
2694	145	Monday	02:52:00	120
2694	299	Monday	11:07:00	250
2694	347	Saturday	09:53:00	120
2694	91	Tuesday	07:21:00	250
2695	16	Friday	02:57:00	180
2695	222	Monday	11:49:00	150
2695	211	Monday	14:27:00	320
2702	315	Monday	01:03:00	120
2702	83	Sunday	16:21:00	120
2702	231	Thursday	06:59:00	80
2702	221	Tuesday	12:55:00	80
2712	90	Monday	01:20:00	120
2712	62	Sunday	01:13:00	220
2712	179	Sunday	09:09:00	330
2712	32	Thursday	10:56:00	250
2717	95	Monday	11:27:00	150
2717	229	Sunday	01:08:00	80
2717	110	Thursday	05:25:00	120
2717	115	Wednesday	03:05:00	180
2720	21	Saturday	03:08:00	80
2720	60	Saturday	07:10:00	150
2720	216	Sunday	07:04:00	90
2720	152	Thursday	12:20:00	320
2720	263	Wednesday	09:32:00	90
2731	106	Monday	10:52:00	180
2731	11	Saturday	09:18:00	120
2731	202	Thursday	04:25:00	320
2731	184	Thursday	10:27:00	150
2731	213	Thursday	11:15:00	320
2744	260	Friday	00:58:00	300
2744	285	Friday	15:09:00	300
2744	101	Monday	14:44:00	180
2744	233	Saturday	10:00:00	90
2744	200	Thursday	09:07:00	300
2751	336	Friday	07:29:00	90
2751	142	Monday	17:18:00	220
2751	75	Saturday	14:07:00	150
2751	119	Sunday	08:56:00	180
2751	334	Tuesday	12:52:00	220
2752	165	Friday	05:18:00	180
2752	223	Sunday	07:18:00	320
2752	316	Tuesday	11:03:00	150
2752	98	Wednesday	05:43:00	330
2789	118	Saturday	22:05:00	80
2789	116	Sunday	06:36:00	330
2789	161	Sunday	22:42:00	80
2789	112	Thursday	21:31:00	250
2789	34	Tuesday	19:58:00	90
2792	332	Saturday	00:39:00	90
2792	45	Saturday	05:20:00	80
2792	238	Thursday	18:23:00	180
2792	273	Thursday	19:07:00	250
2806	264	Monday	02:03:00	150
2806	254	Monday	05:02:00	150
2806	168	Saturday	12:24:00	180
2806	85	Wednesday	08:11:00	320
2810	293	Monday	08:21:00	90
2810	224	Saturday	10:27:00	330
2810	321	Saturday	10:29:00	300
2810	41	Tuesday	14:55:00	220
2817	313	Friday	06:15:00	150
2817	4	Friday	09:34:00	220
2817	194	Sunday	13:02:00	180
2817	218	Tuesday	02:48:00	300
2817	139	Wednesday	00:15:00	90
2830	261	Friday	07:24:00	330
2830	294	Wednesday	00:44:00	120
2830	349	Wednesday	15:06:00	300
2838	59	Friday	06:13:00	180
2838	141	Sunday	01:18:00	80
2838	276	Wednesday	08:16:00	330
2840	17	Friday	03:12:00	120
2840	136	Monday	04:00:00	250
2840	287	Monday	06:01:00	250
2840	246	Thursday	13:01:00	220
2840	204	Tuesday	04:55:00	220
2854	269	Sunday	08:34:00	90
2854	310	Thursday	06:06:00	300
2854	242	Tuesday	12:25:00	150
2854	243	Wednesday	08:58:00	180
2860	228	Friday	04:08:00	330
2860	247	Monday	16:25:00	220
2860	49	Sunday	14:28:00	250
2860	203	Tuesday	00:47:00	90
2860	28	Wednesday	05:55:00	320
2884	201	Friday	14:01:00	80
2884	30	Tuesday	03:52:00	250
2884	330	Tuesday	07:28:00	150
2884	272	Wednesday	14:58:00	180
2884	120	Wednesday	15:21:00	220
2886	18	Monday	15:05:00	220
2886	80	Sunday	12:41:00	330
2886	274	Sunday	15:53:00	250
2886	265	Thursday	05:30:00	330
2886	226	Wednesday	11:08:00	300
2888	156	Friday	11:20:00	220
2888	186	Monday	06:16:00	220
2888	259	Saturday	11:15:00	220
2888	305	Sunday	13:24:00	90
2890	333	Monday	11:57:00	80
2890	160	Monday	13:51:00	80
2890	55	Saturday	06:48:00	120
2904	281	Friday	06:53:00	90
2904	153	Monday	14:38:00	320
2904	268	Saturday	14:13:00	80
2904	248	Tuesday	00:06:00	120
2912	227	Monday	11:54:00	250
2912	87	Saturday	04:43:00	150
2912	128	Thursday	15:56:00	220
2912	195	Wednesday	05:41:00	120
2914	326	Saturday	10:54:00	150
2914	66	Sunday	01:26:00	120
2914	107	Tuesday	08:05:00	180
2921	312	Thursday	17:21:00	150
2921	122	Thursday	18:51:00	330
2921	71	Wednesday	05:34:00	250
2922	296	Friday	00:20:00	330
2922	325	Saturday	12:43:00	180
2922	48	Thursday	16:48:00	120
2922	244	Tuesday	01:46:00	300
2923	253	Monday	08:27:00	330
2923	220	Monday	13:04:00	180
2923	5	Thursday	13:55:00	180
2923	252	Wednesday	17:29:00	80
2924	170	Monday	01:25:00	180
2924	324	Tuesday	03:43:00	150
2924	346	Wednesday	13:26:00	250
2926	235	Friday	17:19:00	250
2926	225	Saturday	13:40:00	150
2926	39	Thursday	06:16:00	220
2931	52	Monday	00:57:00	330
2931	56	Monday	09:15:00	320
2931	288	Saturday	11:57:00	120
2931	230	Saturday	13:31:00	320
2931	301	Sunday	08:13:00	80
2936	96	Sunday	12:18:00	250
2936	343	Thursday	08:27:00	80
2936	61	Tuesday	07:34:00	320
2936	341	Wednesday	02:51:00	300
2947	340	Sunday	09:14:00	330
2947	148	Wednesday	07:19:00	250
2947	63	Wednesday	09:26:00	250
2947	100	Wednesday	15:51:00	320
2954	9	Monday	06:34:00	320
2954	209	Sunday	05:45:00	220
2954	147	Thursday	07:12:00	220
2954	162	Tuesday	08:28:00	150
2954	304	Tuesday	20:09:00	300
2959	199	Friday	18:50:00	220
2959	82	Monday	13:26:00	300
2959	70	Saturday	08:32:00	180
2959	93	Sunday	17:42:00	90
2959	176	Wednesday	07:24:00	320
2964	124	Friday	14:31:00	300
2964	249	Thursday	09:18:00	250
2964	350	Tuesday	05:00:00	330
2977	309	Friday	14:09:00	150
2977	214	Tuesday	12:53:00	150
2977	27	Wednesday	00:53:00	330
3021	328	Saturday	03:30:00	120
3021	171	Saturday	13:12:00	80
3021	123	Thursday	12:38:00	320
3021	323	Thursday	15:07:00	220
3024	127	Monday	01:42:00	320
3024	111	Monday	04:32:00	120
3024	130	Saturday	19:59:00	180
3024	198	Tuesday	12:43:00	320
3032	46	Friday	16:06:00	80
3032	270	Tuesday	10:56:00	90
3032	182	Tuesday	15:37:00	250
3032	69	Wednesday	20:41:00	120
3046	266	Monday	02:01:00	80
3046	140	Monday	09:08:00	300
3046	342	Saturday	02:05:00	330
3046	33	Thursday	12:34:00	120
3046	297	Wednesday	05:22:00	320
3048	14	Monday	00:11:00	150
3048	149	Monday	07:22:00	80
3048	241	Thursday	14:49:00	250
3048	320	Wednesday	03:29:00	150
3058	314	Friday	07:54:00	80
3058	134	Friday	11:43:00	80
3058	240	Monday	06:49:00	330
3058	129	Tuesday	00:02:00	80
3058	26	Tuesday	07:29:00	180
3062	64	Friday	06:45:00	250
3062	44	Monday	07:01:00	120
3062	232	Saturday	10:28:00	220
3062	3	Saturday	11:23:00	330
3062	255	Thursday	03:49:00	300
3071	6	Friday	09:47:00	80
3071	74	Friday	13:18:00	80
3071	292	Monday	00:00:00	320
3071	57	Saturday	06:43:00	220
3104	114	Saturday	17:17:00	300
3104	327	Tuesday	18:01:00	150
3104	31	Tuesday	18:36:00	330
3105	92	Tuesday	10:40:00	150
3105	1	Tuesday	13:48:00	150
3105	192	Wednesday	01:52:00	220
3115	29	Friday	04:43:00	320
3115	76	Friday	15:06:00	90
3115	143	Sunday	08:10:00	250
3115	77	Tuesday	09:59:00	250
3115	169	Wednesday	15:49:00	330
3139	108	Saturday	06:25:00	220
3139	23	Sunday	15:52:00	180
3139	282	Thursday	07:45:00	330
3139	25	Thursday	15:52:00	120
3139	67	Tuesday	06:08:00	80
3141	311	Sunday	05:25:00	220
3141	208	Sunday	15:25:00	320
3141	19	Sunday	18:38:00	320
3142	81	Monday	09:13:00	150
3142	54	Saturday	09:52:00	80
3142	286	Thursday	06:53:00	330
3153	306	Sunday	15:51:00	90
3153	97	Tuesday	00:37:00	180
3153	348	Tuesday	10:47:00	330
3153	58	Wednesday	12:59:00	220
3153	146	Wednesday	14:19:00	220
3160	338	Monday	00:46:00	120
3160	190	Monday	04:01:00	150
3160	175	Saturday	03:28:00	90
3178	237	Friday	04:31:00	180
3178	245	Friday	20:47:00	180
3178	10	Saturday	12:53:00	320
3179	2	Monday	17:52:00	90
3179	7	Sunday	03:42:00	250
3179	104	Sunday	13:11:00	220
3179	278	Tuesday	01:21:00	120
3186	206	Monday	06:05:00	330
3186	210	Sunday	12:00:00	300
3186	335	Thursday	04:47:00	90
3186	344	Wednesday	11:50:00	180
3186	189	Wednesday	16:48:00	150
3198	38	Thursday	01:04:00	320
3198	279	Tuesday	12:03:00	120
3198	154	Wednesday	03:56:00	150
3198	166	Wednesday	06:23:00	250
3198	131	Wednesday	14:56:00	90
3207	121	Friday	02:35:00	330
3207	295	Monday	15:20:00	220
3207	137	Saturday	08:43:00	330
3207	329	Saturday	14:02:00	330
3207	177	Sunday	02:29:00	80
3209	68	Friday	03:06:00	300
3209	99	Friday	15:29:00	150
3209	217	Thursday	08:32:00	300
3209	51	Tuesday	02:02:00	150
3209	89	Wednesday	03:42:00	250
3211	132	Sunday	08:30:00	320
3211	256	Thursday	06:50:00	80
3211	43	Tuesday	14:19:00	150
3217	37	Monday	11:48:00	250
3217	234	Saturday	17:11:00	320
3217	193	Wednesday	04:13:00	300
3217	250	Wednesday	10:26:00	80
3221	40	Monday	09:31:00	330
3221	262	Tuesday	02:11:00	150
3221	307	Wednesday	14:32:00	250
3230	289	Friday	07:29:00	300
3230	151	Thursday	06:31:00	320
3230	212	Tuesday	14:36:00	150
3232	318	Saturday	08:09:00	90
3232	73	Saturday	13:24:00	320
3232	219	Sunday	05:51:00	180
3232	290	Sunday	14:11:00	180
3239	284	Saturday	13:54:00	150
3239	181	Sunday	11:38:00	320
3239	94	Sunday	14:19:00	300
3248	275	Monday	18:37:00	80
3248	298	Thursday	12:09:00	300
3248	187	Wednesday	13:42:00	320
3248	251	Wednesday	17:11:00	250
3280	302	Saturday	03:12:00	80
3280	339	Sunday	02:26:00	220
3280	125	Tuesday	15:43:00	90
3318	150	Friday	01:40:00	220
3318	167	Friday	01:55:00	90
3318	308	Friday	15:15:00	320
3318	20	Thursday	18:54:00	150
3321	126	Saturday	06:11:00	220
3321	8	Sunday	02:59:00	220
3321	280	Thursday	12:19:00	150
3321	183	Wednesday	05:16:00	330
3323	178	Monday	02:31:00	80
3323	13	Tuesday	00:28:00	320
3323	24	Tuesday	17:32:00	330
3323	322	Wednesday	18:04:00	120
3338	78	Saturday	11:07:00	320
3338	135	Thursday	08:08:00	300
3338	22	Tuesday	03:44:00	180
3338	173	Tuesday	12:12:00	90
3338	291	Tuesday	15:23:00	300
3344	109	Monday	03:11:00	180
3344	283	Thursday	07:24:00	330
3344	319	Tuesday	10:23:00	220
3344	180	Wednesday	06:09:00	180
3355	103	Friday	10:38:00	330
3355	86	Saturday	05:52:00	330
3355	12	Wednesday	06:31:00	120
3373	174	Friday	03:02:00	90
3373	72	Friday	03:34:00	180
3373	50	Wednesday	04:11:00	330
3373	172	Wednesday	05:47:00	220
3375	185	Friday	12:45:00	320
3375	144	Saturday	03:38:00	120
3375	236	Saturday	08:13:00	180
3375	207	Wednesday	07:06:00	180
3375	258	Wednesday	10:47:00	180
3416	113	Monday	01:41:00	330
3416	277	Monday	21:36:00	120
3416	215	Saturday	02:09:00	90
3416	195	Tuesday	10:16:00	120
3422	345	Friday	08:49:00	120
3422	137	Friday	18:34:00	330
3422	287	Saturday	11:32:00	250
3422	194	Tuesday	02:01:00	180
3441	112	Monday	15:45:00	250
3441	46	Monday	16:50:00	80
3441	24	Thursday	09:09:00	330
3441	270	Tuesday	15:16:00	90
3443	158	Sunday	00:50:00	330
3443	244	Thursday	03:02:00	300
3443	207	Tuesday	14:58:00	180
3443	12	Wednesday	10:17:00	120
3444	150	Sunday	13:15:00	220
3444	2	Sunday	16:51:00	90
3444	248	Thursday	12:47:00	120
3444	298	Thursday	14:53:00	300
3444	196	Tuesday	16:43:00	80
3446	241	Sunday	13:01:00	250
3446	311	Sunday	20:00:00	220
3446	263	Tuesday	03:18:00	90
3446	209	Tuesday	06:29:00	220
3446	54	Tuesday	07:49:00	80
3457	18	Friday	04:47:00	220
3457	102	Monday	00:53:00	150
3457	42	Monday	06:02:00	120
3457	180	Saturday	07:03:00	180
3458	72	Monday	05:00:00	180
3458	80	Monday	13:32:00	330
3458	293	Saturday	12:50:00	90
3458	132	Tuesday	04:40:00	320
3458	148	Wednesday	10:57:00	250
3461	149	Friday	08:59:00	80
3461	273	Friday	09:34:00	250
3461	146	Monday	04:49:00	220
3461	243	Saturday	08:52:00	180
3461	262	Sunday	14:16:00	150
3467	236	Friday	14:09:00	180
3467	321	Monday	12:04:00	300
3467	20	Sunday	11:36:00	150
3467	156	Tuesday	09:17:00	220
3473	301	Saturday	04:18:00	80
3473	165	Thursday	04:07:00	180
3473	304	Wednesday	06:35:00	300
3478	57	Friday	14:32:00	220
3478	330	Thursday	04:13:00	150
3478	101	Tuesday	03:25:00	180
3478	70	Tuesday	09:50:00	180
3478	238	Wednesday	04:06:00	180
3503	155	Friday	11:30:00	150
3503	109	Monday	03:19:00	180
3503	325	Saturday	01:53:00	180
3511	294	Friday	02:45:00	120
3511	27	Sunday	12:17:00	330
3511	279	Tuesday	03:55:00	120
3511	276	Wednesday	02:18:00	330
3511	141	Wednesday	07:12:00	80
3513	307	Monday	11:34:00	250
3513	32	Sunday	00:06:00	250
3513	284	Thursday	04:30:00	150
3513	68	Thursday	16:38:00	300
3526	309	Sunday	01:01:00	150
3526	22	Thursday	03:13:00	180
3526	135	Tuesday	10:43:00	300
3526	278	Wednesday	05:29:00	120
3526	268	Wednesday	07:49:00	80
3529	7	Friday	10:04:00	250
3529	162	Tuesday	15:07:00	150
3529	251	Tuesday	16:45:00	250
3538	226	Saturday	15:59:00	300
3538	175	Thursday	17:48:00	90
3538	339	Tuesday	08:22:00	220
3563	202	Monday	11:18:00	320
3563	198	Tuesday	00:56:00	320
3563	247	Tuesday	12:03:00	220
3563	303	Wednesday	11:31:00	330
3565	53	Friday	01:53:00	320
3565	184	Monday	16:00:00	150
3565	153	Thursday	00:40:00	320
3565	49	Thursday	06:04:00	250
3565	327	Tuesday	16:47:00	150
3572	329	Friday	19:40:00	330
3572	107	Friday	20:29:00	180
3572	139	Sunday	21:08:00	90
3572	40	Tuesday	03:50:00	330
3572	76	Wednesday	14:37:00	90
3577	3	Friday	04:27:00	330
3577	221	Friday	04:53:00	80
3577	275	Friday	07:13:00	80
3581	56	Saturday	01:47:00	320
3581	31	Sunday	15:06:00	330
3581	58	Thursday	21:34:00	220
3581	84	Wednesday	08:44:00	90
3590	103	Saturday	09:49:00	330
3590	246	Saturday	15:16:00	220
3590	269	Sunday	06:28:00	90
3590	160	Tuesday	12:22:00	80
3590	159	Wednesday	13:54:00	300
3610	10	Monday	08:21:00	320
3610	88	Thursday	01:48:00	300
3610	320	Tuesday	01:25:00	150
3610	174	Tuesday	05:19:00	90
3611	302	Friday	13:51:00	80
3611	257	Saturday	08:57:00	90
3611	299	Sunday	01:43:00	250
3611	223	Sunday	14:36:00	320
3611	43	Tuesday	03:52:00	150
3612	166	Sunday	10:33:00	250
3612	6	Thursday	03:41:00	80
3612	305	Tuesday	13:23:00	90
3664	116	Friday	03:53:00	330
3664	34	Saturday	03:33:00	90
3664	86	Sunday	07:18:00	330
3664	44	Tuesday	12:53:00	120
3690	77	Friday	13:34:00	250
3690	16	Monday	02:43:00	180
3690	91	Thursday	13:46:00	250
3690	66	Tuesday	04:39:00	120
3690	190	Wednesday	05:45:00	150
3698	237	Saturday	07:44:00	180
3698	131	Sunday	11:36:00	90
3698	147	Thursday	01:00:00	220
3698	178	Tuesday	07:44:00	80
3698	181	Wednesday	10:04:00	320
3724	130	Friday	02:07:00	180
3724	291	Monday	13:17:00	300
3724	119	Saturday	01:04:00	180
3724	256	Wednesday	01:36:00	80
3724	99	Wednesday	01:57:00	150
3726	328	Friday	12:04:00	120
3726	288	Saturday	04:11:00	120
3726	338	Sunday	01:51:00	120
3726	4	Wednesday	10:42:00	220
3728	255	Friday	10:15:00	300
3728	142	Saturday	07:41:00	220
3728	25	Thursday	03:22:00	120
3728	348	Thursday	11:45:00	330
3728	197	Wednesday	02:04:00	90
3730	79	Monday	12:56:00	90
3730	258	Sunday	09:42:00	180
3730	171	Tuesday	04:10:00	80
3739	118	Friday	06:54:00	80
3739	90	Monday	00:03:00	120
3739	336	Wednesday	03:14:00	90
3743	172	Monday	06:59:00	220
3743	185	Saturday	04:05:00	320
3743	30	Sunday	11:39:00	250
3743	28	Wednesday	02:35:00	320
3743	129	Wednesday	17:35:00	80
3747	61	Sunday	08:16:00	320
3747	322	Thursday	05:00:00	120
3747	283	Tuesday	13:07:00	330
3747	326	Wednesday	18:01:00	150
3753	55	Saturday	17:09:00	120
3753	213	Sunday	07:03:00	320
3753	296	Sunday	18:17:00	330
3753	222	Tuesday	09:47:00	150
3759	199	Monday	14:47:00	220
3759	281	Sunday	16:21:00	90
3759	217	Tuesday	16:25:00	300
3759	233	Tuesday	17:13:00	90
3759	323	Wednesday	04:46:00	220
3777	214	Friday	00:29:00	150
3777	45	Friday	07:27:00	80
3777	349	Monday	03:07:00	300
3777	239	Saturday	08:43:00	220
3777	110	Sunday	11:08:00	120
3788	201	Monday	03:05:00	80
3788	144	Saturday	14:43:00	120
3788	216	Thursday	12:48:00	90
3788	33	Tuesday	03:35:00	120
3788	93	Wednesday	12:16:00	90
3793	145	Monday	16:44:00	120
3793	36	Saturday	06:15:00	220
3793	143	Thursday	16:29:00	250
3813	203	Monday	12:29:00	90
3813	267	Thursday	06:17:00	220
3813	343	Thursday	11:11:00	80
3815	317	Friday	03:21:00	300
3815	259	Friday	16:57:00	220
3815	224	Sunday	07:10:00	330
3815	289	Sunday	18:06:00	300
3815	220	Thursday	13:29:00	180
3821	350	Monday	09:20:00	330
3821	231	Saturday	12:46:00	80
3821	83	Sunday	13:11:00	120
3821	253	Thursday	00:17:00	330
3822	170	Sunday	14:22:00	180
3822	277	Thursday	15:18:00	120
3822	229	Wednesday	14:15:00	80
3843	316	Monday	05:13:00	150
3843	308	Monday	13:59:00	320
3843	17	Thursday	04:24:00	120
3843	163	Tuesday	05:36:00	300
3843	260	Wednesday	08:19:00	300
3844	8	Saturday	02:33:00	220
3844	337	Tuesday	12:55:00	90
3844	104	Wednesday	04:05:00	220
3854	340	Friday	03:07:00	330
3854	87	Thursday	02:05:00	150
3854	177	Thursday	07:00:00	80
3854	334	Tuesday	00:52:00	220
3854	333	Tuesday	12:21:00	80
3870	206	Friday	01:37:00	330
3870	315	Friday	02:04:00	120
3870	111	Sunday	06:19:00	120
3870	331	Tuesday	14:26:00	320
3877	245	Friday	09:10:00	180
3877	157	Sunday	06:44:00	90
3877	169	Thursday	11:45:00	330
3878	285	Monday	03:48:00	300
3878	297	Saturday	05:54:00	320
3878	125	Sunday	05:24:00	90
3878	161	Sunday	16:35:00	80
3878	230	Wednesday	01:45:00	320
3917	335	Friday	15:09:00	90
3917	342	Sunday	09:04:00	330
3917	115	Thursday	07:11:00	180
3917	240	Thursday	13:15:00	330
3917	151	Wednesday	09:27:00	320
3925	14	Monday	13:02:00	150
3925	69	Sunday	06:22:00	120
3925	347	Tuesday	01:41:00	120
3925	113	Wednesday	10:09:00	330
3925	48	Wednesday	14:30:00	120
3928	332	Friday	02:31:00	90
3928	5	Sunday	05:29:00	180
3928	173	Thursday	01:41:00	90
3928	117	Tuesday	00:05:00	330
3957	94	Friday	12:03:00	300
3957	59	Monday	13:57:00	180
3957	266	Monday	14:55:00	80
3957	313	Sunday	05:36:00	150
3962	187	Saturday	08:36:00	320
3962	9	Sunday	00:07:00	320
3962	218	Sunday	11:03:00	300
3962	234	Tuesday	16:09:00	320
3991	41	Monday	09:05:00	220
3991	73	Saturday	00:32:00	320
3991	138	Thursday	02:48:00	250
3991	306	Thursday	08:43:00	90
3991	96	Wednesday	13:07:00	250
3997	295	Friday	02:44:00	220
3997	189	Friday	19:03:00	150
3997	13	Thursday	03:28:00	320
3997	280	Wednesday	04:05:00	150
3998	344	Saturday	09:03:00	180
3998	272	Sunday	13:27:00	180
3998	89	Tuesday	17:32:00	250
4001	292	Sunday	18:41:00	320
4001	182	Thursday	16:37:00	250
4001	39	Tuesday	05:29:00	220
4001	71	Wednesday	22:37:00	250
4002	205	Thursday	16:59:00	330
4002	85	Thursday	18:05:00	320
4002	232	Tuesday	08:21:00	220
4003	29	Friday	17:13:00	320
4003	290	Saturday	09:21:00	180
4003	286	Thursday	13:05:00	330
4003	11	Thursday	20:03:00	120
4003	128	Tuesday	07:41:00	220
4011	212	Friday	00:19:00	150
4011	105	Wednesday	11:11:00	150
4011	219	Wednesday	12:12:00	180
4011	154	Wednesday	13:20:00	150
4011	15	Wednesday	14:12:00	300
4015	225	Sunday	00:40:00	150
4015	122	Sunday	00:44:00	330
4015	97	Thursday	04:33:00	180
4021	82	Friday	00:44:00	300
4021	136	Monday	12:31:00	250
4021	300	Tuesday	10:30:00	150
4021	75	Wednesday	09:52:00	150
4025	134	Friday	09:52:00	80
4025	346	Friday	13:54:00	250
4025	51	Monday	12:21:00	150
4025	78	Monday	13:36:00	320
4034	120	Friday	18:25:00	220
4034	23	Saturday	05:14:00	180
4034	254	Sunday	15:05:00	150
4034	310	Thursday	13:06:00	300
4034	106	Wednesday	16:20:00	180
4046	38	Friday	00:40:00	320
4046	312	Thursday	12:35:00	150
4046	21	Tuesday	08:51:00	80
4053	140	Friday	09:01:00	300
4053	215	Monday	17:24:00	90
4053	108	Thursday	16:26:00	220
4053	62	Tuesday	01:40:00	220
4054	265	Sunday	13:57:00	330
4054	341	Tuesday	13:33:00	300
4054	252	Wednesday	06:25:00	80
4069	63	Saturday	07:52:00	250
4069	50	Sunday	18:53:00	330
4069	188	Thursday	17:41:00	320
4083	52	Saturday	09:44:00	330
4083	274	Saturday	14:58:00	250
4083	261	Thursday	04:14:00	330
4083	123	Tuesday	10:41:00	320
4083	92	Wednesday	13:32:00	150
4093	127	Sunday	07:12:00	320
4093	65	Sunday	09:47:00	80
4093	282	Thursday	04:09:00	330
4095	228	Friday	11:31:00	330
4095	164	Saturday	06:09:00	180
4095	250	Saturday	07:57:00	80
4095	192	Sunday	05:43:00	220
4119	191	Saturday	16:51:00	80
4119	74	Saturday	22:26:00	80
4119	35	Sunday	10:42:00	150
4119	183	Tuesday	01:13:00	330
4135	324	Monday	11:39:00	150
4135	314	Saturday	10:26:00	80
4135	133	Wednesday	02:29:00	330
4135	19	Wednesday	04:51:00	320
4139	227	Saturday	13:10:00	250
4139	26	Sunday	04:44:00	180
4139	124	Wednesday	00:40:00	300
4155	47	Friday	18:03:00	320
4155	100	Sunday	14:52:00	320
4155	67	Thursday	07:10:00	80
4155	193	Thursday	16:16:00	300
4155	211	Tuesday	04:31:00	320
4168	121	Friday	07:58:00	330
4168	210	Friday	16:58:00	300
4168	37	Tuesday	12:57:00	250
4168	81	Wednesday	08:27:00	150
4173	114	Monday	09:14:00	300
4173	60	Thursday	10:59:00	150
4173	64	Wednesday	01:57:00	250
4177	200	Friday	06:20:00	300
4177	318	Friday	11:07:00	90
4177	95	Sunday	10:41:00	150
4177	168	Tuesday	10:30:00	180
4177	186	Wednesday	05:58:00	220
4183	98	Friday	10:28:00	330
4183	208	Monday	21:11:00	320
4183	167	Sunday	07:54:00	90
4192	271	Sunday	17:35:00	320
4192	176	Thursday	03:44:00	320
4192	126	Tuesday	14:59:00	220
4192	249	Wednesday	06:27:00	250
4192	1	Wednesday	09:49:00	150
4193	179	Monday	08:49:00	330
4193	242	Tuesday	08:59:00	150
4193	264	Wednesday	10:15:00	150
4193	204	Wednesday	15:25:00	220
4209	314	Friday	18:19:00	80
4209	319	Monday	05:46:00	220
4209	235	Tuesday	11:41:00	250
4209	152	Wednesday	08:38:00	320
4220	269	Friday	06:32:00	90
4220	343	Friday	13:50:00	80
4220	110	Friday	16:39:00	120
4220	25	Saturday	15:38:00	120
4226	12	Saturday	08:20:00	120
4226	117	Sunday	05:12:00	330
4226	262	Sunday	10:16:00	150
4226	157	Thursday	18:02:00	90
4226	245	Tuesday	07:30:00	180
4231	306	Friday	07:43:00	90
4231	62	Friday	11:40:00	220
4231	113	Tuesday	07:43:00	330
4231	293	Wednesday	06:44:00	90
4234	88	Monday	09:38:00	300
4234	152	Monday	13:48:00	320
4234	156	Saturday	04:13:00	220
4234	36	Sunday	09:13:00	220
4234	227	Wednesday	13:35:00	250
4238	248	Friday	15:45:00	120
4238	50	Thursday	20:56:00	330
4238	123	Tuesday	22:40:00	320
4238	125	Wednesday	01:52:00	90
4244	129	Friday	18:47:00	80
4244	43	Saturday	06:34:00	150
4244	115	Sunday	17:36:00	180
4244	38	Thursday	15:37:00	320
4269	212	Monday	02:53:00	150
4269	185	Sunday	00:25:00	320
4269	54	Tuesday	12:33:00	80
4272	286	Monday	17:30:00	330
4272	290	Saturday	09:04:00	180
4272	94	Saturday	16:21:00	300
4272	44	Sunday	11:04:00	120
4273	333	Monday	12:36:00	80
4273	91	Saturday	13:30:00	250
4273	80	Wednesday	10:58:00	330
4273	3	Wednesday	16:57:00	330
4279	340	Monday	11:01:00	330
4279	96	Sunday	15:24:00	250
4279	339	Tuesday	12:42:00	220
4279	300	Wednesday	02:40:00	150
4279	186	Wednesday	16:49:00	220
4287	18	Monday	15:06:00	220
4287	26	Tuesday	05:52:00	180
4287	173	Wednesday	06:01:00	90
4306	298	Monday	00:55:00	300
4306	4	Monday	08:17:00	220
4306	47	Monday	14:14:00	320
4306	297	Tuesday	16:02:00	320
4314	213	Sunday	10:35:00	320
4314	192	Thursday	19:35:00	220
4314	224	Tuesday	13:41:00	330
4317	141	Friday	12:51:00	80
4317	235	Saturday	14:27:00	250
4317	70	Tuesday	06:05:00	180
4334	69	Friday	02:02:00	120
4334	58	Tuesday	12:52:00	220
4334	215	Tuesday	14:55:00	90
4334	279	Wednesday	10:33:00	120
4340	337	Monday	17:36:00	90
4340	165	Sunday	10:20:00	180
4340	114	Thursday	09:12:00	300
4343	63	Friday	10:02:00	250
4343	181	Saturday	01:33:00	320
4343	158	Saturday	10:47:00	330
4343	112	Sunday	02:18:00	250
4343	11	Wednesday	14:54:00	120
4351	31	Friday	13:36:00	330
4351	272	Saturday	11:00:00	180
4351	206	Sunday	13:16:00	330
4351	261	Tuesday	09:31:00	330
4351	93	Wednesday	08:12:00	90
4358	146	Friday	03:35:00	220
4358	132	Sunday	03:13:00	320
4358	83	Wednesday	01:39:00	120
4363	174	Monday	03:49:00	90
4363	260	Monday	09:58:00	300
4363	168	Thursday	13:28:00	180
4363	56	Tuesday	12:45:00	320
4363	49	Tuesday	13:24:00	250
4368	321	Monday	01:25:00	300
4368	8	Monday	14:06:00	220
4368	347	Monday	16:38:00	120
4368	32	Tuesday	11:38:00	250
4375	178	Friday	20:19:00	80
4375	2	Saturday	22:39:00	90
4375	310	Sunday	14:01:00	300
4380	89	Monday	04:37:00	250
4380	86	Monday	07:51:00	330
4380	101	Monday	17:59:00	180
4380	133	Saturday	07:47:00	330
4381	85	Monday	13:28:00	320
4381	175	Thursday	14:54:00	90
4381	242	Wednesday	16:11:00	150
4416	40	Saturday	02:14:00	330
4416	346	Sunday	09:35:00	250
4416	191	Sunday	15:23:00	80
4416	65	Tuesday	16:40:00	80
4417	234	Monday	07:31:00	320
4417	210	Saturday	03:58:00	300
4417	289	Thursday	15:43:00	300
4419	60	Monday	14:24:00	150
4419	284	Sunday	09:53:00	150
4419	81	Wednesday	04:05:00	150
4428	1	Monday	05:27:00	150
4428	16	Sunday	07:04:00	180
4428	75	Sunday	13:08:00	150
4428	294	Wednesday	08:02:00	120
4431	30	Friday	12:44:00	250
4431	217	Monday	01:12:00	300
4431	177	Monday	08:50:00	80
4439	55	Friday	08:55:00	120
4439	312	Saturday	06:13:00	150
4439	64	Sunday	02:57:00	250
4439	68	Thursday	10:45:00	300
4443	313	Friday	17:38:00	150
4443	131	Wednesday	10:24:00	90
4443	277	Wednesday	16:42:00	120
4457	59	Friday	12:40:00	180
4457	138	Friday	12:56:00	250
4457	160	Monday	04:21:00	80
4457	299	Thursday	04:37:00	250
4470	214	Saturday	01:18:00	150
4470	61	Sunday	00:25:00	320
4470	170	Sunday	07:47:00	180
4470	303	Tuesday	16:29:00	330
4473	111	Friday	02:26:00	120
4473	311	Friday	05:59:00	220
4473	295	Thursday	11:05:00	220
4473	33	Tuesday	11:02:00	120
4473	228	Wednesday	02:57:00	330
4476	183	Friday	02:51:00	330
4476	66	Sunday	06:29:00	120
4476	350	Tuesday	12:06:00	330
4486	74	Friday	09:03:00	80
4486	216	Saturday	00:27:00	90
4486	162	Thursday	12:44:00	150
4486	53	Wednesday	01:39:00	320
4486	276	Wednesday	11:40:00	330
4524	180	Friday	06:35:00	180
4524	256	Sunday	06:12:00	80
4524	164	Sunday	10:49:00	180
4524	19	Thursday	11:26:00	320
4524	349	Wednesday	00:20:00	300
4540	317	Monday	00:03:00	300
4540	275	Saturday	01:06:00	80
4540	116	Saturday	06:00:00	330
4540	148	Sunday	00:19:00	250
4540	163	Wednesday	15:30:00	300
4541	196	Monday	14:25:00	80
4541	48	Sunday	03:13:00	120
4541	122	Thursday	07:29:00	330
4552	79	Saturday	09:19:00	90
4552	226	Wednesday	04:30:00	300
4552	246	Wednesday	08:42:00	220
4553	237	Friday	00:46:00	180
4553	223	Saturday	00:53:00	320
4553	34	Sunday	03:33:00	90
4557	255	Monday	00:27:00	300
4557	335	Tuesday	02:32:00	90
4557	126	Tuesday	06:55:00	220
4557	135	Wednesday	01:13:00	300
4557	23	Wednesday	04:13:00	180
4560	109	Monday	09:37:00	180
4560	253	Sunday	00:00:00	330
4560	291	Thursday	11:56:00	300
4560	323	Tuesday	06:42:00	220
4560	143	Wednesday	13:05:00	250
4561	190	Friday	06:44:00	150
4561	209	Monday	06:34:00	220
4561	189	Saturday	00:44:00	150
4561	264	Thursday	07:09:00	150
4561	76	Thursday	15:27:00	90
4575	87	Friday	05:57:00	150
4575	155	Saturday	02:34:00	150
4575	84	Saturday	15:49:00	90
4575	203	Tuesday	04:27:00	90
4581	128	Sunday	02:12:00	220
4581	119	Sunday	08:58:00	180
4581	207	Thursday	02:46:00	180
4581	229	Wednesday	07:22:00	80
4581	341	Wednesday	16:52:00	300
4584	282	Saturday	01:10:00	330
4584	247	Saturday	20:49:00	220
4584	265	Thursday	01:41:00	330
4584	225	Tuesday	05:38:00	150
4604	37	Tuesday	07:13:00	250
4604	263	Wednesday	03:20:00	90
4604	98	Wednesday	05:39:00	330
4608	328	Monday	03:42:00	120
4608	324	Monday	16:11:00	150
4608	334	Saturday	06:13:00	220
4608	243	Wednesday	02:30:00	180
4610	108	Saturday	09:47:00	220
4610	194	Thursday	13:35:00	180
4610	278	Tuesday	20:18:00	120
4612	220	Friday	12:11:00	180
4612	201	Saturday	07:16:00	80
4612	252	Wednesday	03:57:00	80
4612	130	Wednesday	12:46:00	180
4618	204	Thursday	16:46:00	220
4618	249	Thursday	19:02:00	250
4618	150	Tuesday	00:35:00	220
4620	104	Monday	15:46:00	220
4620	283	Thursday	17:25:00	330
4620	17	Tuesday	00:35:00	120
4647	208	Friday	02:38:00	320
4647	151	Saturday	01:58:00	320
4647	308	Sunday	04:41:00	320
4647	176	Tuesday	00:57:00	320
4650	120	Friday	02:30:00	220
4650	137	Saturday	05:05:00	330
4650	233	Thursday	09:26:00	90
4650	166	Wednesday	09:32:00	250
4667	136	Friday	13:54:00	250
4667	106	Monday	12:23:00	180
4667	316	Saturday	13:36:00	150
4667	332	Thursday	09:26:00	90
4673	5	Friday	00:16:00	180
4673	46	Saturday	14:30:00	80
4673	331	Saturday	17:35:00	320
4673	154	Tuesday	11:31:00	150
4673	103	Wednesday	00:55:00	330
4674	167	Monday	05:23:00	90
4674	236	Sunday	09:05:00	180
4674	251	Thursday	00:06:00	250
4688	121	Saturday	15:04:00	330
4688	258	Sunday	05:32:00	180
4688	239	Sunday	09:19:00	220
4688	318	Thursday	07:18:00	90
4688	345	Tuesday	06:22:00	120
4704	322	Friday	07:54:00	120
4704	320	Monday	03:30:00	150
4704	327	Saturday	02:12:00	150
4704	274	Saturday	05:00:00	250
4704	254	Saturday	08:43:00	150
4712	57	Friday	04:02:00	220
4712	200	Friday	11:31:00	300
4712	134	Sunday	04:09:00	80
4712	222	Tuesday	05:31:00	150
4712	77	Wednesday	07:59:00	250
4714	51	Sunday	18:41:00	150
4714	22	Thursday	07:51:00	180
4714	250	Tuesday	05:52:00	80
4714	202	Tuesday	16:49:00	320
4727	147	Friday	06:34:00	220
4727	92	Friday	18:01:00	150
4727	273	Saturday	18:04:00	250
4727	142	Saturday	19:56:00	220
4766	13	Saturday	00:39:00	320
4766	100	Sunday	03:29:00	320
4766	230	Wednesday	08:33:00	320
4767	73	Monday	10:41:00	320
4767	197	Saturday	05:37:00	90
4767	41	Sunday	08:59:00	220
4768	161	Monday	10:24:00	80
4768	211	Saturday	02:08:00	320
4768	24	Tuesday	13:46:00	330
4769	193	Saturday	07:53:00	300
4769	240	Sunday	04:46:00	330
4769	221	Tuesday	09:46:00	80
4769	195	Wednesday	09:14:00	120
4770	72	Monday	08:00:00	180
4770	342	Saturday	13:14:00	330
4770	20	Sunday	11:33:00	150
4770	330	Thursday	04:48:00	150
4771	244	Monday	14:50:00	300
4771	6	Sunday	14:43:00	80
4771	271	Thursday	07:56:00	320
4771	205	Thursday	13:05:00	330
4772	90	Friday	08:17:00	120
4772	67	Thursday	01:51:00	80
4772	149	Tuesday	11:08:00	80
4773	179	Monday	01:58:00	330
4773	29	Saturday	05:56:00	320
4773	304	Thursday	05:20:00	300
4773	348	Tuesday	07:59:00	330
4774	140	Friday	05:56:00	300
4774	45	Friday	09:25:00	80
4774	27	Friday	13:08:00	330
4774	39	Sunday	11:53:00	220
4774	231	Thursday	04:17:00	80
4775	285	Saturday	04:26:00	300
4775	42	Sunday	09:02:00	120
4775	127	Thursday	10:28:00	320
4775	315	Tuesday	08:34:00	120
4776	78	Saturday	12:18:00	320
4776	159	Tuesday	06:10:00	300
4776	305	Wednesday	08:09:00	90
\.


--
-- Data for Name: stations; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.stations (sid, name, open_hour, close_hour, street, town, postal) FROM stdin;
1	S1	00:00:00	23:59:00	235 E Garvey Ave	Monterey Park	CA 91755-1811
2	S2	00:00:00	23:59:00	1527 Franklin Avenue	Mineola	NY 11501-4827
3	S3	00:00:00	23:59:00	1065 N Aviation Blvd	Manhattan Beach	CA 90266-621 
4	S4	00:00:00	23:59:00	6112 Enterprise Rd	Summit	MS 39666-7589
5	S5	00:00:00	23:59:00	255 Butler Ave	Lancaster	PA 17601-6308
6	S6	00:00:00	23:59:00	845 Dracut Ln	Schaumburg	IL 60173-5927
7	S7	00:00:00	23:59:00	3252 N 49th St	Pennsauken	NJ 08109-2120
8	S8	00:00:00	23:59:00	1565 Franklin Avenue	Mineola	NY 11501-4808
9	S9	00:00:00	23:59:00	753 Stillwater Ave, Ste 5	Bangor	ME 04401-3633
10	S10	00:00:00	23:59:00	4626 N Harlem Ave	Harwood Heights	IL 60706-4714
11	S11	00:00:00	23:59:00	9950 W 116th Pl	Overland Park	KS 66210-3103
12	S12	00:00:00	23:59:00	18214 Via Calma	Rowland Heights	CA 91748-3350
13	S13	00:00:00	23:59:00	7870 SE 171st Buchanan Pl	Lady Lake	FL 32162-8313
14	S14	00:00:00	23:59:00	734 Wampler Dr	Charleston	SC 29412-9157
15	S15	00:00:00	23:59:00	109 Shartom Dr	Augusta	GA 30907-4712
16	S16	00:00:00	23:59:00	110 W Arrow Hwy	Upland	CA 91786-5238
17	S17	00:00:00	23:59:00	1001 E Grant St, Unit F1	Santa Ana	CA 92701-8527
18	S18	00:00:00	23:59:00	721 Ninth Ave	New York	NY 10019-7256
19	S19	00:00:00	23:59:00	13 Fraternity Row	Gainesville	FL 32603-2174
20	S20	00:00:00	23:59:00	17403 Harlan D	Yorba Linda	CA 92886-1876
21	S21	00:00:00	23:59:00	19870 NW 54th Ave	Miami Gardens	FL 33055-1668
22	S22	00:00:00	23:59:00	1060 Beam Rd	Denver	PA 17517-9746
23	S23	00:00:00	23:59:00	1700 McHenry Ave, Ste 23	Modesto	CA 95350-4329
24	S24	00:00:00	23:59:00	5529 Joshua St	Lansing	MI 48911-3960
25	S25	00:00:00	23:59:00	19991 Santa Maria Ave	Castro Valley	CA 94546-4262
26	S26	00:00:00	23:59:00	805 SE Broad St	Metter	GA 30439-3932
27	S27	00:00:00	23:59:00	21710 Lundy Dr	Farmington Hills	MI 48336-4639
28	S28	00:00:00	23:59:00	4347 W 176th St	Torrance	CA 90504-3127
29	S29	00:00:00	23:59:00	218 Ash Ave	Ames	IA 50014-7115
30	S30	00:00:00	23:59:00	1635 Camile Pl	Santa Ana	CA 92703-4401
31	S31	00:00:00	23:59:00	109 Fountain Oaks Cir, Apt 63	Sacramento	CA 95831-5147
32	S32	00:00:00	23:59:00	1600 N Wilmot Rd	Tucson	AZ 85712-4456
33	S33	00:00:00	23:59:00	304 Shamrock Pl	Richardson	TX 75081-3960
34	S34	00:00:00	23:59:00	121 Spring Garden Dr	Hutto	TX 78634-4015
35	S35	00:00:00	23:59:00	8141 S East St	Indianapolis	IN 46227-2725
36	S36	00:00:00	23:59:00	2138 Nimrick Ln	San Jose	CA 95124-6015
37	S37	00:00:00	23:59:00	12605 Beach Blvd	Stanton	CA 90680-4007
38	S38	00:00:00	23:59:00	3621 Sterling Woods Dr	Eugene	OR 97408-7201
39	S39	00:00:00	23:59:00	1900 68th Ave	Greeley	CO 80634-7967
40	S40	00:00:00	23:59:00	6131 Monterey Rd, Apt 1	Los Angeles	CA 90042-4328
41	S41	00:00:00	23:59:00	6218 Mershon St	Philadelphia	PA 19149-3014
42	S42	00:00:00	23:59:00	155 Mineola Boulevard	Mineola	NY 11501-3920
43	S43	00:00:00	23:59:00	5012 W 163rd St	Stilwell	KS 66085-8243
44	S44	00:00:00	23:59:00	16502 Trailway Dr	Macomb	MI 48042-5777
45	S45	00:00:00	23:59:00	20918 State Highway 59	Noel	MO 64854-8278
46	S46	00:00:00	23:59:00	2044 22nd St	San Pablo	CA 94806-3539
47	S47	00:00:00	23:59:00	1272 70th St	Brooklyn	NY 11228-1406
48	S48	00:00:00	23:59:00	632 State St	White Haven	PA 18661-4028
49	S49	00:00:00	23:59:00	2111 E Belt Line Rd	Richardson	TX 75081-3900
50	S50	00:00:00	23:59:00	64711 E County Line Rd	Millersburg	IN 46543-9741
\.


--
-- Data for Name: trails; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.trails (rid, sid, "position", distance) FROM stdin;
1	1	0	0
1	2	1	94
1	3	2	22
1	4	3	70
1	5	4	71
1	6	5	81
1	7	6	35
1	8	7	96
1	9	8	32
1	10	9	21
1	11	10	33
1	12	11	75
1	13	12	10
1	14	13	28
1	15	14	21
2	16	0	0
2	17	1	76
2	18	2	43
2	4	3	47
2	19	4	16
2	20	5	80
2	21	6	19
2	22	7	24
2	23	8	84
2	24	9	100
3	25	0	0
3	26	1	85
3	27	2	90
3	8	3	53
3	28	4	89
3	29	5	39
3	21	6	66
3	30	7	87
3	31	8	11
3	32	9	36
3	33	10	49
3	34	11	72
4	35	0	0
4	36	1	29
4	37	2	42
4	38	3	57
4	11	4	11
4	39	5	18
4	40	6	13
4	21	7	11
4	41	8	65
4	42	9	30
5	43	0	0
5	44	1	28
5	45	2	85
5	46	3	44
5	47	4	21
5	48	5	68
5	49	6	97
5	50	7	41
\.


--
-- Data for Name: trains; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.trains (tid, name, description, speed_kmh, seats, cost_km) FROM stdin;
1	T1	Passenger, Mail & Cargo	75	150	6
2	T2	Passenger, Mail & Cargo	100	90	41
3	T3	Express Passenger with Dining	175	330	94
4	T4	Passenger, Mail & Cargo	150	220	29
5	T5	Passenger & Cargo	200	180	14
6	T6	Passenger with Dining	175	80	9
7	T7	Passenger & Cargo	75	250	5
8	T8	Passenger & Cargo	150	220	59
9	T9	Passenger & Cargo	75	320	171
10	T10	Passenger with Dining	75	320	43
11	T11	Passenger	100	120	12
12	T12	Passenger & Mail	50	120	84
13	T13	Passenger & Cargo	50	320	192
14	T14	Passenger, Mail & Cargo	50	150	135
15	T15	Passenger with Dining	175	300	26
16	T16	Passenger with Dining	150	180	6
17	T17	Passenger & Mail	125	120	5
18	T18	Passenger & Cargo	150	220	73
19	T19	Passenger & Cargo	150	320	85
20	T20	Passenger	125	150	54
21	T21	Passenger	200	80	6
22	T22	Passenger	175	180	36
23	T23	Passenger	100	180	9
24	T24	Express Passenger & Mail	150	330	33
25	T25	Passenger, Mail & Cargo	100	120	24
26	T26	Passenger, Mail & Cargo	125	180	29
27	T27	Express Passenger, Mail & Carg	200	330	58
28	T28	Passenger & Mail	200	320	72
29	T29	Passenger with Dining	100	320	16
30	T30	Passenger & Cargo	75	250	117
31	T31	Express Passenger with Dining	175	330	28
32	T32	Passenger	200	250	31
33	T33	Passenger	100	120	36
34	T34	Passenger, Mail & Cargo	75	90	3
35	T35	Passenger & Mail	175	150	4
36	T36	Passenger	75	220	15
37	T37	Passenger & Mail	150	250	67
38	T38	Passenger & Mail	175	320	91
39	T39	Passenger, Mail & Cargo	125	220	18
40	T40	Express Passenger & Mail	200	330	83
41	T41	Passenger	150	220	29
42	T42	Passenger with Dining	200	120	6
43	T43	Passenger & Mail	150	150	35
44	T44	Passenger & Mail	150	120	36
45	T45	Passenger	125	80	19
46	T46	Passenger	125	80	6
47	T47	Passenger	100	320	16
48	T48	Passenger	125	120	24
49	T49	Passenger, Mail & Cargo	200	250	19
50	T50	Express Passenger & Cargo	150	330	22
51	T51	Passenger, Mail & Cargo	150	150	2
52	T52	Express Passenger & Mail	150	330	11
53	T53	Passenger, Mail & Cargo	75	320	107
54	T54	Passenger	100	80	24
55	T55	Passenger, Mail & Cargo	125	120	19
56	T56	Passenger	75	320	107
57	T57	Passenger, Mail & Cargo	125	220	53
58	T58	Passenger	100	220	99
59	T59	Passenger & Cargo	50	180	72
60	T60	Passenger & Mail	50	150	105
61	T61	Passenger & Mail	75	320	149
62	T62	Passenger, Mail & Cargo	125	220	53
63	T63	Passenger & Cargo	50	250	75
64	T64	Passenger	150	250	67
65	T65	Passenger & Mail	75	80	21
66	T66	Passenger	125	120	1
67	T67	Passenger & Mail	75	80	43
68	T68	Passenger & Mail	175	300	26
69	T69	Passenger, Mail & Cargo	175	120	7
70	T70	Passenger with Dining	200	180	18
71	T71	Passenger & Mail	200	250	63
72	T72	Passenger	200	180	23
73	T73	Passenger	150	320	21
74	T74	Passenger, Mail & Cargo	100	80	4
75	T75	Passenger & Mail	125	150	36
76	T76	Passenger	75	90	42
77	T77	Passenger, Mail & Cargo	100	250	75
78	T78	Passenger & Mail	175	320	18
79	T79	Passenger with Dining	50	90	81
80	T80	Express Passenger with Dining	50	330	33
81	T81	Passenger & Mail	125	150	42
82	T82	Passenger & Mail	175	300	43
83	T83	Passenger with Dining	75	120	56
84	T84	Passenger with Dining	100	90	23
85	T85	Passenger, Mail & Cargo	50	320	64
86	T86	Express Passenger with Dining	175	330	38
87	T87	Passenger & Cargo	200	150	19
88	T88	Passenger, Mail & Cargo	150	300	6
89	T89	Passenger, Mail & Cargo	150	250	25
90	T90	Passenger & Mail	100	120	6
91	T91	Passenger & Mail	125	250	3
92	T92	Passenger & Cargo	125	150	6
93	T93	Passenger	200	90	11
94	T94	Passenger & Mail	50	300	18
95	T95	Passenger & Cargo	75	150	9
96	T96	Luxary Passenger & Cargo	50	250	25
97	T97	Passenger & Mail	150	180	42
98	T98	Express Passenger with Dining	150	330	77
99	T99	Passenger & Mail	50	150	105
100	T100	Passenger & Cargo	50	320	192
101	T101	Passenger & Mail	125	180	36
102	T102	Passenger & Mail	50	150	6
103	T103	Express Passenger	50	330	99
104	T104	Passenger & Cargo	50	220	44
105	T105	Passenger with Dining	150	150	5
106	T106	Passenger with Dining	200	180	5
107	T107	Passenger with Dining	175	180	31
108	T108	Passenger, Mail & Cargo	75	220	117
109	T109	Passenger & Cargo	125	180	43
110	T110	Passenger, Mail & Cargo	125	120	14
111	T111	Passenger & Cargo	200	120	12
112	T112	Passenger with Dining	150	250	5
113	T113	Express Passenger & Mail	100	330	149
114	T114	Passenger, Mail & Cargo	75	300	2
115	T115	Passenger	125	180	65
116	T116	Express Passenger, Mail & Carg	200	330	33
117	T117	Express Passenger	75	330	11
118	T118	Passenger & Mail	75	80	53
119	T119	Passenger & Mail	50	180	144
120	T120	Passenger & Mail	75	220	59
121	T121	Express Passenger with Dining	50	330	99
122	T122	Express Passenger	125	330	26
123	T123	Passenger & Mail	200	320	4
124	T124	Passenger with Dining	125	300	108
125	T125	Passenger with Dining	75	90	24
126	T126	Passenger with Dining	150	220	51
127	T127	Passenger & Mail	150	320	43
128	T128	Passenger, Mail & Cargo	150	220	73
129	T129	Passenger & Mail	100	80	28
130	T130	Passenger	175	180	51
131	T131	Passenger with Dining	150	90	3
132	T132	Passenger with Dining	125	320	115
133	T133	Express Passenger	150	330	99
134	T134	Passenger	100	80	28
135	T135	Passenger with Dining	200	300	6
136	T136	Passenger & Cargo	125	250	4
137	T137	Express Passenger & Cargo	150	330	11
138	T138	Passenger with Dining	150	250	58
139	T139	Passenger, Mail & Cargo	125	90	22
140	T140	Passenger & Cargo	125	300	72
141	T141	Passenger & Cargo	50	80	4
142	T142	Passenger, Mail & Cargo	175	220	31
143	T143	Luxary Passenger	50	250	25
144	T144	Passenger & Mail	50	120	6
145	T145	Passenger & Mail	100	120	36
146	T146	Passenger with Dining	125	220	53
147	T147	Passenger & Mail	125	220	35
148	T148	Passenger & Mail	200	250	63
149	T149	Passenger & Cargo	200	80	8
150	T150	Passenger, Mail & Cargo	175	220	63
151	T151	Passenger, Mail & Cargo	200	320	48
152	T152	Passenger, Mail & Cargo	125	320	13
153	T153	Passenger, Mail & Cargo	175	320	91
154	T154	Passenger	150	150	15
155	T155	Passenger	75	150	6
156	T156	Passenger, Mail & Cargo	200	220	11
157	T157	Passenger & Cargo	200	90	14
158	T158	Express Passenger & Cargo	200	330	33
159	T159	Passenger with Dining	200	300	53
160	T160	Passenger	50	80	64
161	T161	Passenger, Mail & Cargo	150	80	11
162	T162	Passenger & Mail	175	150	21
163	T163	Luxary Passenger with Dining	50	300	24
164	T164	Passenger & Cargo	125	180	22
165	T165	Passenger & Cargo	50	180	126
166	T166	Passenger & Cargo	175	250	64
167	T167	Passenger & Cargo	150	90	3
168	T168	Passenger & Cargo	150	180	12
169	T169	Express Passenger, Mail & Carg	175	330	47
170	T170	Passenger	50	180	144
171	T171	Passenger with Dining	75	80	5
172	T172	Passenger & Cargo	100	220	66
173	T173	Passenger & Cargo	100	90	18
174	T174	Passenger & Mail	175	90	23
175	T175	Passenger	200	90	5
176	T176	Passenger	100	320	96
177	T177	Passenger	200	80	14
178	T178	Passenger, Mail & Cargo	50	80	8
179	T179	Express Passenger & Mail	175	330	19
180	T180	Passenger & Mail	125	180	58
181	T181	Passenger & Mail	100	320	128
182	T182	Passenger & Cargo	200	250	25
183	T183	Express Passenger with Dining	175	330	75
184	T184	Passenger & Mail	150	150	1
185	T185	Passenger	75	320	21
186	T186	Passenger & Cargo	175	220	38
187	T187	Passenger	125	320	64
188	T188	Passenger & Mail	200	320	8
189	T189	Passenger & Mail	100	150	68
190	T190	Passenger & Cargo	75	150	1
191	T191	Passenger with Dining	125	80	13
192	T192	Passenger, Mail & Cargo	175	220	6
193	T193	Passenger, Mail & Cargo	175	300	69
194	T194	Passenger, Mail & Cargo	100	180	54
195	T195	Passenger with Dining	50	120	24
196	T196	Passenger, Mail & Cargo	125	80	19
197	T197	Passenger & Cargo	100	90	9
198	T198	Passenger & Cargo	50	320	96
199	T199	Passenger, Mail & Cargo	100	220	33
200	T200	Passenger & Cargo	100	300	45
201	T201	Passenger, Mail & Cargo	50	80	72
202	T202	Passenger & Mail	75	320	128
203	T203	Passenger with Dining	50	90	27
204	T204	Passenger with Dining	100	220	33
205	T205	Express Passenger, Mail & Carg	75	330	154
206	T206	Express Passenger & Mail	125	330	132
207	T207	Passenger & Mail	200	180	32
208	T208	Passenger	75	320	171
209	T209	Passenger & Mail	150	220	44
210	T210	Passenger, Mail & Cargo	125	300	12
211	T211	Passenger	125	320	38
212	T212	Passenger	150	150	4
213	T213	Passenger, Mail & Cargo	200	320	64
214	T214	Passenger & Cargo	150	150	25
215	T215	Passenger, Mail & Cargo	75	90	3
216	T216	Passenger, Mail & Cargo	75	90	6
217	T217	Passenger with Dining	75	300	2
218	T218	Passenger, Mail & Cargo	125	300	108
219	T219	Passenger	75	180	96
220	T220	Passenger, Mail & Cargo	75	180	96
221	T221	Passenger & Mail	125	80	26
222	T222	Passenger	100	150	23
223	T223	Passenger & Cargo	200	320	56
224	T224	Express Passenger & Cargo	75	330	198
225	T225	Passenger with Dining	175	150	13
226	T226	Passenger	175	300	51
227	T227	Passenger, Mail & Cargo	75	250	5
228	T228	Express Passenger & Cargo	150	330	44
229	T229	Passenger	100	80	8
230	T230	Passenger, Mail & Cargo	150	320	85
231	T231	Passenger & Cargo	100	80	28
232	T232	Passenger & Mail	175	220	44
233	T233	Passenger & Mail	150	90	15
234	T234	Passenger & Cargo	50	320	16
235	T235	Passenger	150	250	33
236	T236	Passenger & Mail	75	180	84
237	T237	Passenger	125	180	65
238	T238	Passenger with Dining	75	180	108
239	T239	Passenger with Dining	175	220	44
240	T240	Express Passenger, Mail & Carg	175	330	85
241	T241	Passenger with Dining	175	250	71
242	T242	Passenger & Mail	150	150	1
243	T243	Passenger with Dining	100	180	54
244	T244	Passenger & Cargo	175	300	6
245	T245	Passenger	150	180	54
246	T246	Passenger, Mail & Cargo	125	220	88
247	T247	Passenger	75	220	44
248	T248	Passenger & Mail	200	120	12
249	T249	Passenger	75	250	83
250	T250	Passenger with Dining	175	80	23
251	T251	Passenger with Dining	175	250	57
252	T252	Passenger, Mail & Cargo	200	80	14
253	T253	Express Passenger	175	330	38
254	T254	Passenger & Mail	100	150	68
255	T255	Passenger	50	300	12
256	T256	Passenger & Mail	75	80	53
257	T257	Passenger & Mail	175	90	13
258	T258	Passenger with Dining	150	180	6
259	T259	Passenger with Dining	200	220	28
260	T260	Passenger, Mail & Cargo	200	300	75
261	T261	Express Passenger & Cargo	200	330	66
262	T262	Passenger, Mail & Cargo	75	150	1
263	T263	Passenger with Dining	50	90	45
264	T264	Passenger & Mail	50	150	105
265	T265	Express Passenger	175	330	94
266	T266	Passenger, Mail & Cargo	200	80	2
267	T267	Passenger & Mail	50	220	88
268	T268	Passenger & Mail	175	80	18
269	T269	Passenger & Mail	175	90	3
270	T270	Passenger & Cargo	125	90	32
271	T271	Passenger & Cargo	50	320	32
272	T272	Passenger	75	180	12
273	T273	Passenger & Cargo	200	250	31
274	T274	Passenger & Mail	100	250	25
275	T275	Passenger & Mail	75	80	27
276	T276	Express Passenger	175	330	47
277	T277	Passenger & Mail	150	120	16
278	T278	Passenger, Mail & Cargo	200	120	24
279	T279	Passenger, Mail & Cargo	175	120	1
280	T280	Passenger with Dining	75	150	3
281	T281	Passenger, Mail & Cargo	50	90	36
282	T282	Express Passenger, Mail & Carg	150	330	88
283	T283	Express Luxary Passenger with 	50	330	297
284	T284	Passenger	75	150	7
285	T285	Passenger	200	300	38
286	T286	Express Passenger	125	330	119
287	T287	Passenger & Cargo	100	250	113
288	T288	Passenger	175	120	27
289	T289	Passenger	175	300	6
290	T290	Passenger, Mail & Cargo	175	180	21
291	T291	Passenger	75	300	12
292	T292	Passenger with Dining	200	320	24
293	T293	Passenger, Mail & Cargo	50	90	36
294	T294	Passenger & Mail	150	120	36
295	T295	Passenger	125	220	79
296	T296	Express Passenger, Mail & Carg	175	330	19
297	T297	Passenger with Dining	200	320	48
298	T298	Passenger & Cargo	100	300	15
299	T299	Passenger with Dining	50	250	175
300	T300	Passenger & Cargo	175	150	4
301	T301	Passenger	200	80	14
302	T302	Passenger with Dining	50	80	48
303	T303	Express Passenger & Mail	150	330	33
304	T304	Passenger	175	300	77
305	T305	Passenger with Dining	150	90	3
306	T306	Passenger	150	90	9
307	T307	Passenger with Dining	100	250	13
308	T308	Passenger & Mail	175	320	46
309	T309	Passenger with Dining	200	150	3
310	T310	Passenger, Mail & Cargo	100	300	75
311	T311	Passenger & Cargo	175	220	63
312	T312	Passenger with Dining	100	150	3
313	T313	Passenger & Mail	150	150	3
314	T314	Passenger, Mail & Cargo	150	80	3
315	T315	Passenger	150	120	8
316	T316	Passenger & Cargo	125	150	3
317	T317	Passenger & Mail	125	300	36
318	T318	Passenger & Mail	125	90	18
319	T319	Passenger	150	220	66
320	T320	Passenger, Mail & Cargo	150	150	5
321	T321	Passenger, Mail & Cargo	175	300	34
322	T322	Passenger & Cargo	150	120	4
323	T323	Passenger, Mail & Cargo	200	220	11
324	T324	Passenger, Mail & Cargo	50	150	75
325	T325	Passenger	200	180	23
326	T326	Passenger & Cargo	50	150	75
327	T327	Passenger & Cargo	200	150	19
328	T328	Passenger & Mail	175	120	14
329	T329	Express Passenger	150	330	11
330	T330	Passenger & Mail	75	150	9
331	T331	Passenger, Mail & Cargo	100	320	64
332	T332	Passenger with Dining	50	90	9
333	T333	Passenger & Mail	50	80	24
334	T334	Passenger with Dining	100	220	11
335	T335	Passenger with Dining	175	90	13
336	T336	Passenger & Mail	50	90	9
337	T337	Passenger	100	90	18
338	T338	Passenger & Cargo	100	120	6
339	T339	Passenger with Dining	200	220	28
340	T340	Express Passenger & Mail	125	330	132
341	T341	Passenger with Dining	75	300	2
342	T342	Express Passenger	200	330	17
343	T343	Passenger & Cargo	100	80	36
344	T344	Passenger, Mail & Cargo	100	180	27
345	T345	Passenger & Mail	150	120	28
346	T346	Passenger	175	250	29
347	T347	Passenger & Mail	175	120	27
348	T348	Express Passenger & Cargo	200	330	5
349	T349	Passenger & Mail	150	300	7
350	T350	Express Passenger	150	330	11
\.


--
-- Data for Name: trips; Type: TABLE DATA; Schema: express_railway; Owner: zinan
--

COPY express_railway.trips (trip_id, pid) FROM stdin;
\.


--
-- Name: itinerary_trip_id_seq; Type: SEQUENCE SET; Schema: express_railway; Owner: zinan
--

SELECT pg_catalog.setval('express_railway.itinerary_trip_id_seq', 1, false);


--
-- Name: trips_trip_id_seq; Type: SEQUENCE SET; Schema: express_railway; Owner: zinan
--

SELECT pg_catalog.setval('express_railway.trips_trip_id_seq', 1, false);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (pid);


--
-- Name: itinerary itinerary_pk; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.itinerary
    ADD CONSTRAINT itinerary_pk PRIMARY KEY (trip_id, route_id, day);


--
-- Name: legs paths_pk; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.legs
    ADD CONSTRAINT paths_pk PRIMARY KEY (route_id, rid, sid);


--
-- Name: rails rails_pkey; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.rails
    ADD CONSTRAINT rails_pkey PRIMARY KEY (rid);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (route_id);


--
-- Name: schedules schedules_pk; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.schedules
    ADD CONSTRAINT schedules_pk PRIMARY KEY (route_id, tid, day, "time");


--
-- Name: stations stations_pkey; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (sid);


--
-- Name: trails trails_pk; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.trails
    ADD CONSTRAINT trails_pk PRIMARY KEY (rid, sid);


--
-- Name: trains trains_pkey; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.trains
    ADD CONSTRAINT trains_pkey PRIMARY KEY (tid);


--
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (trip_id);


--
-- Name: itinerary add_reservation; Type: TRIGGER; Schema: express_railway; Owner: zinan
--

CREATE TRIGGER add_reservation AFTER INSERT ON express_railway.itinerary FOR EACH ROW EXECUTE PROCEDURE public.update_seats();


--
-- Name: itinerary itinerary_route_id_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.itinerary
    ADD CONSTRAINT itinerary_route_id_fkey FOREIGN KEY (route_id) REFERENCES express_railway.routes(route_id);


--
-- Name: itinerary itinerary_tid_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.itinerary
    ADD CONSTRAINT itinerary_tid_fkey FOREIGN KEY (tid) REFERENCES express_railway.trains(tid);


--
-- Name: itinerary itinerary_trip_id_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.itinerary
    ADD CONSTRAINT itinerary_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES express_railway.trips(trip_id);


--
-- Name: legs legs_rid_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.legs
    ADD CONSTRAINT legs_rid_fkey FOREIGN KEY (rid) REFERENCES express_railway.rails(rid);


--
-- Name: legs legs_route_id_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.legs
    ADD CONSTRAINT legs_route_id_fkey FOREIGN KEY (route_id) REFERENCES express_railway.routes(route_id);


--
-- Name: legs legs_sid_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.legs
    ADD CONSTRAINT legs_sid_fkey FOREIGN KEY (sid) REFERENCES express_railway.stations(sid);


--
-- Name: schedules schedules_route_id_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.schedules
    ADD CONSTRAINT schedules_route_id_fkey FOREIGN KEY (route_id) REFERENCES express_railway.routes(route_id);


--
-- Name: schedules schedules_tid_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.schedules
    ADD CONSTRAINT schedules_tid_fkey FOREIGN KEY (tid) REFERENCES express_railway.trains(tid);


--
-- Name: trails trails_rid_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.trails
    ADD CONSTRAINT trails_rid_fkey FOREIGN KEY (rid) REFERENCES express_railway.rails(rid);


--
-- Name: trails trails_sid_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.trails
    ADD CONSTRAINT trails_sid_fkey FOREIGN KEY (sid) REFERENCES express_railway.stations(sid);


--
-- Name: trips trips_pid_fkey; Type: FK CONSTRAINT; Schema: express_railway; Owner: zinan
--

ALTER TABLE ONLY express_railway.trips
    ADD CONSTRAINT trips_pid_fkey FOREIGN KEY (pid) REFERENCES express_railway.customers(pid);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

