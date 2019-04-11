select * from view_customer(106550) c(fname varchar, lname varchar, street varchar, town varchar, postal char(13));

select add_customer('Zinan', 'Zhuang', 'XXXXXXXXX Ave', 'Pittsburgh', 'PA 15555-1234');

select * from edit_customer(995507, 'Shijia', 'Liu', 'XXXXXXX Rd', 'Pittsburgh', 'PA XXXXX-1234')
  c(fname varchar, lname varchar, street varchar, town varchar, postal char(13));

select * from reserve_route(100706, 50, 'Thursday');


select find_single_route(1, 7, 'Saturday');
select find_route_fewest_stops(1,7,'Saturday');
select find_route_most_stations(1,7,'Saturday');
select find_route_least_distance(1, 7, 'Saturday');
select find_route_most_distance(1, 7, 'Saturday');
select find_route_lowest_price(1, 7, 'Saturday');
select find_route_highest_price(1, 7, 'Saturday');
select find_route_least_time(1, 7, 'Saturday');
select find_route_most_time(1, 7, 'Saturday');


select find_route_combo(1, 7, 'Saturday');
select find_combo_fewest_stops(1, 7, 'Saturday');
select find_combo_most_stations(1, 7, 'Saturday');
select find_combo_least_distance(1, 7, 'Saturday');
select find_combo_most_distance(1, 7, 'Saturday');
select find_combo_lowest_price(1, 7, 'Saturday');
select find_combo_highest_price(1, 7, 'Saturday');
select find_combo_least_time(1, 7, 'Saturday');
select find_combo_most_time(1, 7, 'Saturday');


select * from find_trains4station(1, 'Saturday', '02:28');

select * from find_routes_multi_railines();

select * from find_similar_routes();

select * from find_stations_all_trains_pass();

select * from find_trains_not_pass(3);

select * from find_routes_percent(50);

select * from display_route_schedules(22);

select * from find_available_seats(22, 'Saturday', '02:28');
