-- create schema for the project
drop schema if exists express_railway cascade;
create schema express_railway;

-- create tables for each relationship
drop table if exists express_railway.stations;
create table express_railway.stations (
  sid INTEGER PRIMARY KEY,
  addr VARCHAR(255),
  open_hour INTEGER check ( open_hour between 0 and 24),
  close_hour INTEGER check ((close_hour between 0 and 24) and close_hour > open_hour)
);

drop table if exists express_railway.distance;
create table express_railway.distance (
  sid1 INTEGER references express_railway.stations(sid),
  sid2 INTEGER references express_railway.stations(sid),
  distance INTEGER,
  constraint distance_pk PRIMARY KEY (sid1, sid2)
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
  distance INTEGER,
  constraint trails_pk PRIMARY KEY (rid, sid)
);

drop table if exists express_railway.routes;
create table express_railway.routes (
  route_id INTEGER PRIMARY KEY
);

drop table if exists express_railway.paths;
create table express_railway.paths (
  route_id INTEGER references express_railway.routes(route_id),
  rid INTEGER references express_railway.rails(rid),
  sid INTEGER references express_railway.stations(sid),
  position INTEGER,
  stop BOOLEAN,
  constraint paths_pk PRIMARY KEY (route_id, rid, sid)
);

drop table if exists expressRailway.trains;
create table express_railway.trains (
  tid INTEGER PRIMARY KEY,
  top_speed INTEGER,
  seats_available INTEGER,
  price_mile FLOAT
);

drop table if exists express_railway.passengers;
create table express_railway.passengers (
  pid INTEGER PRIMARY KEY,
  fname VARCHAR(20),
  lname VARCHAR(20),
  email VARCHAR(50),
  phone CHAR(10),
  city  VARCHAR(20),
  state VARCHAR(20),
  zip VARCHAR(5)
);

drop table if exists express_railway.schedules;
create table express_railway.schedules (
  route_id INTEGER references express_railway.routes(route_id),
  tid INTEGER references express_railway.trains(tid),
  day INTEGER check ( day >= 1 and day <= 7 ),
  time INTEGER check (time >= 1 and time <= 24),
  constraint schedules_pk PRIMARY KEY (route_id, tid, day, time)
);

commit;