# cs1555 Project -- Railway system
-----
ExpressRailway is a new American company that is going to be active in the field of
domestic travel within America. The aim of the company is to establish an information
system through which customers can be informed about stations, trains, routes, delays, etc.

# Initialization
-----
* run `init_db.sql` to create all schemas and triggers

* run `init_func.sql` to create all commands

* run `insert_data.sql` to create all data

Note: if you are using **DataGrip** and want to view the data in the tables, you may need to manually make **express_railway schema** visible by **select shown schemas**

# How to use the functions
-----
Note: `examples.sql` provides a sample run of the following functions.

### 1. view customer info
`view_customer(id int)`

Input: **customer_id**

`returns record`

Output: **first name, last name, street, town, postal**

### 2. add a customer
`add_customer(fname varchar, lname varchar, street varchar, town varchar, postal char)`

Input: **first name, last name, street, town, postal**

`returns int`

Output: **customer id**

### 3. edit customer info
`edit_customer(id int, fname varchar, lname varchar, street varchar, town varchar, postal char)`

Input: **customer id, first name, last name, street, town, postal**

`returns record`

Output: **first name, last name, street, town, postal**

### 4. reserve a route
Note: If **more than one** same routes are available, a random one will be reserved. If there are no available routes, nothing will be reserved.

`reserve_route(pid int, route_id int, day varchar)`

Input: **customer id, route id, day ('Saturday', 'Sunday', etc.)**

`returns table(trip int, t time, train int)`

Output: **trip id, route's time, route's train id**

### 5. find a single route between two stations [optional sorting]

Input: **start station id, destination station id, day ('Saturday', 'Sunday', etc.)**

* *Without Sorting*

  `find_single_route(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time)`

  Output: **route id, train id, route's time**


* *Sort by fewest stops*

  `find_route_fewest_stops(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, counts integer)`

  Output: **route id, train id, route's time, stop counts**


* *Sort by most stations*

  `find_route_most_stations(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, counts integer)`

  Output: **route id, train id, route's time, station counts**


* *Sort by least distance*

  `find_route_least_distance(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, distance integer)`

  Output: **route id, train id, route's time, travel distance**


* *Sort by most distance*

  `find_route_most_distance(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, distance integer)`

  Output: **route id, train id, route's time, travel distance**


* *Sort by lowest price*

  `find_route_lowest_price(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, price integer)`

  Output: **route id, train id, route's time, price**


* *Sort by highest price*

  `find_route_highest_price(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, price integer)`

  Output: **route id, train id, route's time, price**


* *Sort by least time*

  `find_route_least_time(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, travel_time interval)`

  Output: **route id, train id, route's time, travel time**


* *Sort by most time*

  `find_route_most_time(sid1 int, sid2 int, target_day varchar)`

  `returns table(route integer, train integer, t time, travel_time interval)`

  Output: **route id, train id, route's time, travel time**


### 6. find combos of two routes between two stations [optional sorting]

Input: **start station id, destination station id, day ('Saturday', 'Sunday', etc.)**

* *Without Sorting*

  `find_route_combo(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer int,
  route2 integer, t2 time, train2 integer)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id**


* *Sort by fewest stops*

  `find_combo_fewest_stops(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, counts integer)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, stop counts**


* *Sort by most stations*

  `find_combo_most_stations(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, counts integer)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, station counts**


* *Sort by least distance*

  `find_combo_least_distance(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, distance integer)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, travel distance**


* *Sort by most distance*

  `find_combo_most_distance(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, distance integer)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, travel distance**


* *Sort by lowest price*

  `find_combo_lowest_price(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, price integer)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, price**


* *Sort by highest price*

  `find_combo_highest_price(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, price integer)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, price**


* *Sort by least time*

  `find_combo_least_time(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, travel_time interval)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, travel time**


* *Sort by most time*

  `find_combo_most_time(sid1 int, sid2 int, target_day varchar)`

  `returns table(route1 integer, t1 time, train1 integer, transfer integer,
  route2 integer, t2 time, train2 integer, travel_time interval)`

  Output: **route1 id, route1 time, route1 train id, transfer station id, route2 id, route2 time, route2 train id, travel time**


### 7. find all trains that pass through a specific station at a specific day/time
`find_trains4station(sid integer, day varchar, t time)`

Input: **station id, day('Saturday', 'Sunday', etc.), time('03:30', '01:20', etc)**

`returns table(trains integer)`

Output: **train id**


### 8. find the routes that travel more than one rail line
`find_routes_multi_railines()`

Input: None

`returns table(route integer, rail_counts bigint)`

Output: **route id, number of rails that the route passes**


### 9. find similar routes that have same stations but different stops
`find_similar_routes()`

Input: None

`returns table(route1 integer, route2 integer)`

Output: **route1 id, route2 id**


### 10. find any stations through which all trains pass through
`find_stations_all_trains_pass()`

Input: None

`returns table(sid integer, name varchar, open time, close time, street varchar, town varchar, postal char)`

Output: **station id, station name, open time, close time, street, town, postal**


### 11. find trains that do not stop at certain station
`find_trains_not_pass(sid int)`

Input: **station id**

`returns table(train int, name varchar, desciption varchar)`

Output: **train id, train name, train description**


### 12. find route that stops at least X% percent of the stations
`find_routes_percent(threshold int)`

Input: **percent threshold**

`returns table(route integer, percent bigint)`

Output: **route id, actual number of percent that the route stops**


### 13. display the schedule of a route
`display_route_schedules(route_id int)`

Input: **route id**

`returns table(train int, day varchar, t time)`

Output: route's **train id, day, time**


### 14. find seats of a route on a day and time
`find_available_seats(route_id int, day varchar, t time)`

Input: **route id, day('Saturday', 'Sunday', etc.), time('03:30', '01:20', etc)**

`returns table(train int, available_seats int)`

Output: **train id, remaining seats**
