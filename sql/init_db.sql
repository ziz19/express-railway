-- create schema for the project
drop schema if exists express_railway cascade;
create schema express_railway;

-- create tables for each relationship
drop table if exists express_railway.stations;
create table express_railway.stations (
  sid INTEGER PRIMARY KEY,
  name  VARCHAR(50),
  open_hour TIME,
  close_hour TIME,
  street VARCHAR(255),
  town VARCHAR(255),
  postal CHAR(13)
);

drop table if exists express_railway.rails;
create table express_railway.rails (
  rid INTEGER PRIMARY KEY,
  speed_limit INTEGER
);

drop table if exists express_railway.trails;
create table express_railway.trails (
  rid INTEGER references express_railway.rails(rid),
  sid INTEGER references express_railway.stations(sid),
  position INTEGER,
  distance INTEGER,
  constraint trails_pk PRIMARY KEY (rid, sid)
);

drop table if exists express_railway.routes;
create table express_railway.routes (
  route_id INTEGER PRIMARY KEY
);

drop table if exists express_railway.legs;
create table express_railway.legs (
  route_id INTEGER references express_railway.routes(route_id),
  rid INTEGER references express_railway.rails(rid),
  sid INTEGER references express_railway.stations(sid),
  position INTEGER,
  stop INTEGER,
  constraint paths_pk PRIMARY KEY (route_id, rid, sid)
);

drop table if exists express_railway.trains;
create table express_railway.trains (
  tid INTEGER PRIMARY KEY,
  name VARCHAR(50),
  description VARCHAR(255),
  speed_kmh INTEGER,
  seats INTEGER,
  cost_km FLOAT
);


drop table if exists express_railway.schedules;
create table express_railway.schedules (
  route_id INTEGER references express_railway.routes(route_id),
  tid INTEGER references express_railway.trains(tid),
  day VARCHAR(10),
  time TIME,
  available_seats INTEGER,
  constraint schedules_pk PRIMARY KEY (route_id, tid, day, time)
);

drop table if exists express_railway.customers;
create table express_railway.customers (
  pid INTEGER PRIMARY KEY,
  fname VARCHAR(20),
  lname VARCHAR(20),
  street  VARCHAR(255),
  town VARCHAR(255),
  postal CHAR(13)
);

drop table if exists express_railway.trips;
create table express_railway.trips (
  trip_id SERIAL PRIMARY KEY,
  pid INTEGER references express_railway.customers(pid)
);

drop table if exists express_railway.itinerary;
create table express_railway.itinerary (
  trip_id SERIAL references express_railway.trips(trip_id),
  route_id INTEGER references express_railway.routes(route_id),
  tid INTEGER references  express_railway.trains(tid),
  day VARCHAR(10),
  time time,
  constraint itinerary_pk PRIMARY KEY (trip_id, route_id, day)
);

drop function if exists update_seats() cascade;
create function update_seats()
returns trigger as
  $$
  begin
    update express_railway.schedules
    set available_seats = available_seats - 1
    where route_id = new.route_id and tid = new.tid and day = new.day and time = new.time;
    return new;
  end;
  $$ language plpgsql;

drop trigger if exists add_reservation on express_railway.itinerary;
create trigger add_reservation after insert on express_railway.itinerary
for each row execute procedure update_seats();

commit;
