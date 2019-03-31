script = open('sql/insert_data.sql', 'w')

# insert stations data
script.write('-- insert stations data\n')
script.write('delete from express_railway.stations;\n')
with open('sample_data/Stations.txt', 'r') as f:
    stations = f.read().splitlines()
for s in stations:
    s = s.split(';')
    script.write(
        "insert into express_railway.stations "
        "VALUES({}, '{}', '{}', '{}', '{}', '{}', '{}');\n".format(
        s[0], s[1], s[2], s[3], s[5], s[6], s[7]))

# insert customers data
script.write('-- insert customers data\n')
script.write('delete from express_railway.customers;\n')
with open('sample_data/Customers.txt', 'r') as f:
    customers = f.read().splitlines()
for c in customers:
    c = c.split(';')
    script.write(
            "insert into express_railway.customers "
            "VALUES({}, '{}', '{}', '{}', '{}', '{}');\n".format(
            c[0], c[1], c[2], c[3], c[4], c[5]))

# insert trains data
seats = {} # for seats reference
script.write('-- insert trains data\n')
script.write('delete from express_railway.trains;\n')
with open('sample_data/Trains.txt', 'r') as f:
    trains = f.read().splitlines()
for t in trains:
    t = t.split(';')
    seats[t[0]] = t[4]
    script.write(
            "insert into express_railway.trains "
            "VALUES({}, '{}', '{}', {}, {}, {});\n".format(
            t[0], t[1], t[2], t[3], t[4], t[5]))

# insert rails data
station2rail = {}   # for routes reference
script.write('-- insert rails data\n')
script.write('delete from express_railway.rails;\n')
script.write('delete from express_railway.trails;\n')
with open('sample_data/RailLines.txt', 'r') as f:
    rails = f.read().splitlines()
for r in rails:
    r = r.split(';')
    script.write(
                "insert into express_railway.rails "
                "VALUES({}, {});\n".format(
                r[0], r[1]))
    distance_addup = 0
    current_position = -1
    stations = r[2].split(', ')
    distance = r[3].split(', ')
    for i in range(len(stations)):
        distance_addup += int(distance[i])
        current_position += 1
        script.write(
                "insert into express_railway.trails "
                "VALUES({}, {}, {}, {});\n".format(
                r[0], stations[i], current_position, distance[i]))
        if stations[i] not in station2rail:
            station2rail[stations[i]] = r[0]


# insert routes data
script.write('-- insert routes data\n')
script.write('delete from express_railway.routes;\n')
script.write('delete from express_railway.legs;\n')
with open('sample_data/Routes.txt', 'r') as f:
    routes = f.read().splitlines()
for r in routes:
    r = r.split(';')
    script.write(
                "insert into express_railway.routes "
                "VALUES({});\n".format(
                r[0]))
    current_position = -1
    current_stop = 0
    stations = r[1].split(', ')
    stops = r[2].split(', ')
    for i in range(len(stations)):
        current_position += 1
        if stations[i] in stops:
            stop_count = str(current_stop)
            current_stop += 1
        else:
            stop_count = 'null'

        script.write(
                "insert into express_railway.legs "
                "VALUES({}, {}, {}, {}, {});\n".format(
                r[0], station2rail[stations[i]],
                stations[i], current_position,
                stop_count))

# insert schedules data
script.write('-- insert schedules data\n')
script.write('delete from express_railway.schedules;\n')
with open('sample_data/RouteSched.txt', 'r') as f:
    schedules = f.read().splitlines()
for s in schedules:
    s = s.split(';')
    script.write(
            "insert into express_railway.schedules "
            "VALUES({}, {}, '{}', '{}', {});\n".format(
            s[0], s[3], s[1], s[2], seats[s[3]]))





script.close()
