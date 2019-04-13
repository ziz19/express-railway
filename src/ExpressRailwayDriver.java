import java.sql.*;  //import the file containing definitions for the parts
import java.text.ParseException;  //needed by java for database connection and manipulation
import java.util.Scanner;
import java.time.LocalTime;


public class ExpressRailwayDriver {
    private static Connection connection; //used to hold the jdbc connection to the DB
    private Statement statement; //used to create an instance of the connection
    private PreparedStatement prepStatement; //used to create a prepared statement, that will be later reused
    private ResultSet resultSet; //used to hold the result of your query (if one exists)
    private String query;  //this will hold the query we are using
    private String legend;  //this will hold the table name of result
    private String dataFolder; //this will be the folder location to store data
    private static Scanner input;

    public ExpressRailwayDriver() {
        final String currentDir = System.getProperty("user.dir");
    	this.dataFolder = currentDir.substring(0, currentDir.length() - 3) + "data";
        input = new Scanner(System.in);
    }

    public void importDatabase() {
    	try {
            /* delete all current data in the database */
            eraseDatabase();

    	    connection.setAutoCommit(false);
    	    statement = connection.createStatement();

            /* import stored data into database */
            statement.executeUpdate("copy express_railway.customers from '"
              + dataFolder + "/customers.dat';");
            statement.executeUpdate("copy express_railway.trains from '"
              + dataFolder + "/trains.dat';");
            statement.executeUpdate("copy express_railway.stations from '"
              + dataFolder + "/stations.dat';");
            statement.executeUpdate("copy express_railway.rails from '"
              + dataFolder + "/rails.dat';");
            statement.executeUpdate("copy express_railway.trails from '"
              + dataFolder + "/trails.dat';");
            statement.executeUpdate("copy express_railway.routes from '"
              + dataFolder + "/routes.dat';");
            statement.executeUpdate("copy express_railway.legs from '"
              + dataFolder + "/legs.dat';");
            statement.executeUpdate("copy express_railway.schedules from '"
              + dataFolder + "/schedules.dat';");
            statement.executeUpdate("copy express_railway.trips from '"
              + dataFolder + "/trips.dat';");
            statement.executeUpdate("copy express_railway.itinerary from '"
              + dataFolder + "/itinerary.dat';");
    	    connection.commit();
    	}
    	catch(Exception Ex)
    	{
    		System.out.println("Machine Error: " +
    				   Ex.toString());
    	}
    	finally{
    		try {
    			if (statement!=null) statement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void exportDatabase() {
    	try {
    	    connection.setAutoCommit(false);
    	    statement = connection.createStatement();

        /* export stored data into database */
        statement.executeUpdate("copy express_railway.customers to '"
          + dataFolder + "/customers.dat';");
        statement.executeUpdate("copy express_railway.trains to '"
          + dataFolder + "/trains.dat';");
        statement.executeUpdate("copy express_railway.stations to '"
          + dataFolder + "/stations.dat';");
        statement.executeUpdate("copy express_railway.rails to '"
          + dataFolder + "/rails.dat';");
        statement.executeUpdate("copy express_railway.trails to '"
          + dataFolder + "/trails.dat';");
        statement.executeUpdate("copy express_railway.routes to '"
          + dataFolder + "/routes.dat';");
        statement.executeUpdate("copy express_railway.legs to '"
          + dataFolder + "/legs.dat';");
        statement.executeUpdate("copy express_railway.schedules to '"
          + dataFolder + "/schedules.dat';");
        statement.executeUpdate("copy express_railway.trips to '"
          + dataFolder + "/trips.dat';");
        statement.executeUpdate("copy express_railway.itinerary to '"
          + dataFolder + "/itinerary.dat';");
    	    connection.commit();
    	}
    	catch(Exception Ex)
    	{
    		System.out.println("Machine Error: " +
    				   Ex.toString());
    	}
    	finally{
    		try {
    			if (statement!=null) statement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}

    }

    public void eraseDatabase() {
    	try {
    	    connection.setAutoCommit(false);
    	    statement = connection.createStatement();

        /* delete all current data in the database */
    	statement.executeUpdate("delete from express_railway.itinerary;");
        statement.executeUpdate("delete from express_railway.trips;");
        statement.executeUpdate("delete from express_railway.schedules;");
        statement.executeUpdate("delete from express_railway.legs;");
        statement.executeUpdate("delete from express_railway.routes;");
        statement.executeUpdate("delete from express_railway.trails;");
        statement.executeUpdate("delete from express_railway.rails;");
        statement.executeUpdate("delete from express_railway.trains;");
        statement.executeUpdate("delete from express_railway.stations;");
        statement.executeUpdate("delete from express_railway.customers;");
	    connection.commit();
    	}
    	catch(Exception Ex)
    	{
    		System.out.println("Machine Error: " +
    				   Ex.toString());
    	}
    	finally{
    		try {
    			if (statement!=null) statement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void searchSingleRoute(int origin, int destination, String day, int sortBy) {
        try {
                // determine sorting options
                switch (sortBy) {
                    case 1:
                        query = "select * from find_single_route(?,?,?);";
                        legend = "Route ID    Train ID    Time";
                        break;
                    case 2:
                        query = "select * from find_route_fewest_stops(?,?,?);";
                        legend = "Route ID    Train ID    Time    Stops";
                        break;
                    case 3:
                        query = "select * from find_route_most_stations(?,?,?);";
                        legend = "Route ID    Train ID    Time    Stations";
                        break;
                    case 4:
                        query = "select * from find_route_least_distance(?,?,?);";
                        legend = "Route ID    Train ID    Time    Distance";
                        break;
                    case 5:
                        query = "select * from find_route_most_distance(?,?,?);";
                        legend = "Route ID    Train ID    Time    Distance";
                        break;
                    case 6:
                        query = "select * from find_route_lowest_price(?,?,?);";
                        legend = "Route ID    Train ID    Time      Price";
                        break;
                    case 7:
                        query = "select * from find_route_highest_price(?,?,?);";
                        legend = "Route ID    Train ID    Time      Price";
                        break;
                    case 8:
                        query = "select * from find_route_least_time(?,?,?);";
                        legend = "Route ID    Train ID    Time    Travel Time";
                        break;
                    case 9:
                        query = "select * from find_route_most_time(?,?,?);";
                        legend = "Route ID    Train ID    Time    Travel Time";
                        break;
                }
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, origin);
                prepStatement.setInt(2, destination);
                prepStatement.setString(3, day);
                resultSet = prepStatement.executeQuery();

                // display the results by 10 at a time
        	    int counter = 0;
                boolean showMoreResults = true;
                System.out.println(legend);
        	    while(resultSet.next() && showMoreResults) {
        		System.out.printf("%-4d         %-3d      %s",
                    resultSet.getInt(1),
                    resultSet.getInt(2),
                    resultSet.getString(3));

                // if result is sorted, show sorting stat
                if(sortBy != 1)
                    System.out.println("    " + resultSet.getString(4));
                else
                    System.out.println();

                // ask user whether to show more results and reset counts
        		if(++counter == 10) {
                    System.out.println("\nEnter q to quit, anything to show more:");
                    showMoreResults = !"q".equals(input.nextLine());
                    if(showMoreResults) System.out.println(legend);
                    counter = 0;
                }
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void searchRouteCombo(int origin, int destination, String day, int sortBy) {
        try {
                // determine sorting options
                switch (sortBy) {
                    case 1:
                        query = "select * from find_route_combo(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID";
                        break;
                    case 2:
                        query = "select * from find_combo_fewest_stops(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Stops";
                        break;
                    case 3:
                        query = "select * from find_combo_most_stations(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Stations";
                        break;
                    case 4:
                        query = "select * from find_combo_least_distance(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Distance";
                        break;
                    case 5:
                        query = "select * from find_combo_most_distance(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Distance";
                        break;
                    case 6:
                        query = "select * from find_combo_lowest_price(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Price";
                        break;
                    case 7:
                        query = "select * from find_combo_highest_price(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Price";
                        break;
                    case 8:
                        query = "select * from find_combo_least_time(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Time";
                        break;
                    case 9:
                        query = "select * from find_combo_most_time(?,?,?);";
                        legend = "Route1 ID      Time      Train1 ID    Transfer Station ID"
                            + "    Route2 ID        Time      Train2 ID    Time";
                        break;
                }
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, origin);
                prepStatement.setInt(2, destination);
                prepStatement.setString(3, day);
                resultSet = prepStatement.executeQuery();

                // display the results by 10 at a time
        	    int counter = 0;
                boolean showMoreResults = true;
                System.out.println(legend);
        	    while(resultSet.next() && showMoreResults) {
        		System.out.printf("%-4d         %s      %-3d        %10d"
                    +"             %-4d         %s      %-3d",
                    resultSet.getInt(1),
                    resultSet.getTime(2),
                    resultSet.getInt(3),
                    resultSet.getInt(4),
                    resultSet.getInt(5),
                    resultSet.getString(6),
                    resultSet.getInt(7));

                // if result is sorted, show sorting stat
                if(sortBy != 1)
                    System.out.println("        " + resultSet.getString(8));
                else
                    System.out.println();

                // ask user whether to show more results and reset counts
        		if(++counter == 10) {
                    System.out.println("\nEnter q to quit, anything to show more:");
                    showMoreResults = !"q".equals(input.nextLine());
                    if(showMoreResults) System.out.println(legend);
                    counter = 0;
                }
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void viewCustomer(int customerID) {
        try {
                query = "select * from view_customer(?) c(fname varchar, lname varchar, street varchar, town varchar, postal char(13));";
                legend = "First Name    Last Name    Street                Town                Postal";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, customerID);
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%s          %s        %s          %s          %s\n",
                    resultSet.getString(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void addCustomer(String firstName, String lastName, String street, String town, String postal) {
        try {
                query = "select add_customer(?, ?, ?, ?, ?);";
                legend = "Customer ID";
                prepStatement = connection.prepareCall(query);
                prepStatement.setString(1, firstName);
                prepStatement.setString(2, lastName);
                prepStatement.setString(3, street);
                prepStatement.setString(4, town);
                prepStatement.setString(5, postal);
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-10d\n",
                    resultSet.getInt(1));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void editCustomer(int customerID, String firstName, String lastName, String street, String town, String postal) {
        try {
                query = "select * from edit_customer(?,?,?,?,?,?) c(fname varchar, lname varchar, street varchar, town varchar, postal char(13));";
                legend = "First Name    Last Name    Street                Town                Postal";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, customerID);
                prepStatement.setString(2, firstName);
                prepStatement.setString(3, lastName);
                prepStatement.setString(4, street);
                prepStatement.setString(5, town);
                prepStatement.setString(6, postal);
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println("Modified Customer Profile: ");
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%s          %s        %s          %s          %s\n",
                    resultSet.getString(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void reserveRoute(int customerID, int routeID, String day) {
        try {
                query = "select * from reserve_route(?,?,?);";
                legend = "Trip ID      Time      Train ID";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, customerID);
                prepStatement.setInt(2, routeID);
                prepStatement.setString(3, day);
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-2d    %s    %d\n",
                    resultSet.getInt(1),
                    resultSet.getTime(2),
                    resultSet.getInt(3));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void findTrains4Station(int stationID, String day, String time) {
        try {
                query = "select * from find_trains4station(?,?,?);";
                legend = "Train ID";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, stationID);
                prepStatement.setString(2, day);
                prepStatement.setObject(3, LocalTime.parse(time));
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%d\n",
                    resultSet.getInt(1));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void findMultiRailRoutes() {
        try {
                query = "select * from find_routes_multi_railines();";
                legend = "Route ID    Rail Counts";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-2d    %d\n",
                    resultSet.getInt(1),
                    resultSet.getInt(2));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void findSimilarRoutes() {
        try {
                query = "select * from find_similar_routes();";
                legend = "Route1 ID    Route2 ID";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-4d        %-4d\n",
                    resultSet.getInt(1),
                    resultSet.getInt(2));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void findStationsAllTrainsPass() {
        try {
                query = "select * from find_stations_all_trains_pass();";
                legend = "Station ID    Name    Open Time    Close Time    Street        Town        Postal";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-2d            %-4s    %s    %s    %s        %s        %s\n",
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getTime(3),
                    resultSet.getTime(4),
                    resultSet.getString(5),
                    resultSet.getString(6),
                    resultSet.getString(7));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void findTrainsNotPass(int stationID) {
        try {
                query = "select * from find_trains_not_pass(?);";
                legend = "Train ID    Name    Desciption";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, stationID);
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-2d          %s    %s\n",
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void findRoutesPercent(int threshold) {
        try {
                query = "select * from find_routes_percent(?);";
                legend = "Route ID    Percent";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, threshold);
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-4d        %d\n",
                    resultSet.getInt(1),
                    resultSet.getInt(2));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void displayRouteSchedules(int routeID) {
        try {
                query = "select * from display_route_schedules(?);";
                legend = "Train ID     Day        Time";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, routeID);
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-3d          %s    %s\n",
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getTime(3));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }

    public void findAvailableSeats(int routeID, String day, String time) {
        try {
                query = "select * from find_available_seats(?,?,?);";
                legend = "Train ID    Remaining Seats";
                prepStatement = connection.prepareCall(query);
                prepStatement.setInt(1, routeID);
                prepStatement.setString(2, day);
                prepStatement.setObject(3, LocalTime.parse(time));
                resultSet = prepStatement.executeQuery();

                // display results
                System.out.println(legend);
        	    while(resultSet.next()) {
        		System.out.printf("%-3d          %d\n",
                    resultSet.getInt(1),
                    resultSet.getInt(2));
        	    }
        	    resultSet.close();
        } catch(SQLException Ex) {
        	    System.out.println("Error running the sample queries.  Machine Error: " +
        			       Ex.toString());
    	}
    	finally{
    		try {
    			if (statement != null) statement.close();
    			if (prepStatement != null) prepStatement.close();
    		} catch (SQLException e) {
    			System.out.println("Cannot close Statement. Machine error: "+e.toString());
    		}
    	}
    }


    public static void main(String args[]) throws SQLException {
        String username, password;
        username = "postgres"; //This is your username in the PostgreSQL server
        password = "postgres"; //This is your password in the PostgreSQL server

    	try{
    	    // Register the PostgreSQL driver.
            Class.forName("org.postgresql.Driver");

    	    // Provide the location of the database
    	    String url = "jdbc:postgresql://localhost:5432/";

    	    //create a connection to DB on class3.cs.pitt.edu
    	    connection = DriverManager.getConnection(url, username, password);
    	    ExpressRailwayDriver db = new ExpressRailwayDriver();
            // db.searchSingleRoute(1, 7, "Saturday", 9);
            // db.searchRouteCombo(1, 7, "Saturday", 2);
            // db.viewCustomer(106550);
            // db.addCustomer("Zinan", "Zhuang", "XXXXXX AVE", "Pittsburgh", "PA 15555-1234");
            // db.editCustomer(995507, "Shijia", "Liu", "XXXXXX Rd", "Pittsburgh", "PA XXXXX-1234");
            // db.reserveRoute(100706, 50, "Wednesday");
            // db.findMultiRailRoutes();
            // db.findSimilarRoutes();
            // db.findStationsAllTrainsPass();
            // db.findTrainsNotPass(3);
            // db.findRoutesPercent(50);
            // db.displayRouteSchedules(22);
            // db.findAvailableSeats(22, "Saturday", "02:28");
            // db.findTrains4Station(1, "Saturday", "02:28");
            // db.importDatabase();

            /* main run of the client app */
            boolean isRunning = true;
            int mode = 0;
            while(isRunning) {
                switch(mode) {
                    case 0:
                        mode = displayLoginScreen();
                        break;
                    case 1:
                        mode = displayAdminScreen(db);
                        break;
                    case 2:
                        mode = displayServiceScreen(db);
                        break;
                    case 3:
                        isRunning = false;
                        break;
                    case 4:
                        mode = displayThankList();
                    default:
                        mode = 0;
                }
            }
    	}
    	catch(Exception Ex)  {
    	    System.out.println("Error connecting to database.  Machine Error: " +
    			       Ex.toString());
    	}
    	finally
    	{
    		/*
    		 * NOTE: the connection should be created once and used through out the whole project;
    		 * Is very expensive to open a connection therefore you should not close it after every operation on database
    		 */
    		connection.close();
            System.out.println("Connection closed.");
    	}
    }

    public static int displayLoginScreen() {
        System.out.println("\nWelcome to Express Railway Database Terminal");
        System.out.println("This is the Login Screen. Please enter:");
        System.out.println("  1 -- if you are a data administrator");
        System.out.println("  2 -- if you need passenger services");
        System.out.println("  3 -- to exit the program");
        System.out.println("  4 -- THANK LIST\n");
        return Integer.parseInt(input.nextLine());
    }

    public static int displayAdminScreen(ExpressRailwayDriver db) {
        System.out.println("\nDear Data Admin, you can enter:");
        System.out.println("  1 -- to import the database");
        System.out.println("  2 -- to export the database");
        System.out.println("  3 -- to erase the database");
        System.out.println("  4 -- go back to login screen\n");

        int operation = Integer.parseInt(input.nextLine());
        switch(operation) {
            case 1:
                System.out.println("\nCaution! This will overwrite the data in the database.");
                System.out.println("Enter yes or y to continue, anything else to quit:");
                String confirm = input.nextLine();
                if("yes".equals(confirm) || "y".equals(confirm)) {
                    System.out.printf("Importing Data.......................");
                    db.importDatabase();
                    System.out.println("Done");
                }
                break;
            case 2:
                System.out.println("\nCaution! This will overwrite the data in your data folder.");
                System.out.println("Enter yes or y to continue, anything else to quit:");
                confirm = input.nextLine();
                if("yes".equals(confirm) || "y".equals(confirm)) {
                    System.out.printf("Exporting Data.......................");
                    db.exportDatabase();
                    System.out.println("Done");
                }
                break;
            case 3:
                System.out.println("\nCaution! This will remove all data in the database.");
                System.out.println("Enter yes or y to continue, anything else to quit:");
                confirm = input.nextLine();
                if("yes".equals(confirm) || "y".equals(confirm)) {
                    System.out.printf("Deleting Data.......................");
                    db.eraseDatabase();
                    System.out.println("Done");
                }
                break;
            case 4:
                return 0;
        }
        return 1;
    }

    public static int displayServiceScreen(ExpressRailwayDriver db) {
        System.out.println("\nPassenger Services are listed below");
        System.out.println("Please select your operation by entering:\n");
        System.out.println("Customer Services  ------------------------------");
        System.out.println("  1. Add a passenger");
        System.out.println("  2. Edit an existing passenger");
        System.out.println("  3. View an existing passenger info\n");
        System.out.println("Trip Services  ----------------------------------");
        System.out.println("  4. Find a single route between two stations");
        System.out.println("  5. Find a route combo between two stations");
        System.out.println("  6. Reserve a route for a passenger\n");
        System.out.println("Advanced Searches -------------------------------");
        System.out.println("  7. Find trains that pass a station at day & time");
        System.out.println("  8. Find routes that travel multiple railines");
        System.out.println("  9. Find similar routes");
        System.out.println("  10. Find stations which all trains pass");
        System.out.println("  11. Find trains that do not stop at a station");
        System.out.println("  12. Find routes that stop at x% stations or more");
        System.out.println("  13. Display the schedule of a route");
        System.out.println("  14. Find seats of a route at day & time\n");
        System.out.println("Others  -----------------------------------------");
        System.out.println("  15. Go back to login screen\n");

        int operation = Integer.parseInt(input.nextLine());
        switch(operation) {
            case 1:
                System.out.println("What's the first name?");
                String fname = input.nextLine();
                System.out.println("What's the last name?");
                String lname = input.nextLine();
                System.out.println("What's the street address?");
                String street = input.nextLine();
                System.out.println("What's the town address?");
                String town = input.nextLine();
                System.out.println("What's the postal address?");
                String postal = input.nextLine();
                System.out.println("\nKeep your ID safe.");
                db.addCustomer(fname, lname, street, town, postal);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 2:
                System.out.println("What's the passenger ID?");
                int cid = Integer.parseInt(input.nextLine());
                System.out.println("What's the first name?");
                fname = input.nextLine();
                System.out.println("What's the last name?");
                lname = input.nextLine();
                System.out.println("What's the street address?");
                street = input.nextLine();
                System.out.println("What's the town address?");
                town = input.nextLine();
                System.out.println("What's the postal address?");
                postal = input.nextLine();
                System.out.println("\nWe are editing your data......");
                db.editCustomer(cid, fname, lname, street, town, postal);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 3:
                System.out.println("What's the passenger ID?");
                cid = Integer.parseInt(input.nextLine());
                System.out.println("\nWe are retrieving your data......");
                db.viewCustomer(cid);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 4:
                System.out.println("What's the start station ID?");
                int origin = Integer.parseInt(input.nextLine());
                System.out.println("What's the destination station ID?");
                int destination = Integer.parseInt(input.nextLine());
                System.out.println("What is the day you want to travel?");
                System.out.println("Enter Monday, Tuesday, Wednesday, etc.");
                String day = input.nextLine();
                System.out.println("Do you want to sort by:");
                System.out.println("  1. nothing");
                System.out.println("  2. fewest stops");
                System.out.println("  3. most stations");
                System.out.println("  4. least distance");
                System.out.println("  5. most distance");
                System.out.println("  6. lowest price");
                System.out.println("  7. highest price");
                System.out.println("  8. least time");
                System.out.println("  9. most time");
                int sortBy = Integer.parseInt(input.nextLine());
                System.out.println("\nWe are find your routes......");
                db.searchSingleRoute(origin, destination, day, sortBy);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 5:
                System.out.println("What's the start station ID?");
                origin = Integer.parseInt(input.nextLine());
                System.out.println("What's the destination station ID?");
                destination = Integer.parseInt(input.nextLine());
                System.out.println("What is the day you want to travel?");
                System.out.println("Enter Monday, Tuesday, Wednesday, etc.");
                day = input.nextLine();
                System.out.println("Do you want to sort by:");
                System.out.println("  1. nothing");
                System.out.println("  2. fewest stops");
                System.out.println("  3. most stations");
                System.out.println("  4. least distance");
                System.out.println("  5. most distance");
                System.out.println("  6. lowest price");
                System.out.println("  7. highest price");
                System.out.println("  8. least time");
                System.out.println("  9. most time");
                sortBy = Integer.parseInt(input.nextLine());
                System.out.println("\nWe are find your routes......");
                db.searchRouteCombo(origin, destination, day, sortBy);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 6:
                System.out.println("What's the passenger ID?");
                cid = Integer.parseInt(input.nextLine());
                System.out.println("What's the route ID?");
                int routeID = Integer.parseInt(input.nextLine());
                System.out.println("What is the day you want to travel?");
                System.out.println("Enter Monday, Tuesday, Wednesday, etc.");
                day = input.nextLine();
                System.out.println("\nNote! If there are more than one available options, a random one is reserved");
                System.out.println("Reserved Seat: ");
                db.reserveRoute(cid, routeID, day);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 7:
                System.out.println("What's the station ID?");
                int stationID = Integer.parseInt(input.nextLine());
                System.out.println("What is the day you want to travel?");
                System.out.println("Enter Monday, Tuesday, Wednesday, etc.");
                day = input.nextLine();
                System.out.println("What is the time you want to travel?");
                System.out.println("For example, 02:28, 03:30, 05:40, etc.");
                String time = input.nextLine();
                System.out.println("Finding trains that pass the station at this time......");
                db.findTrains4Station(stationID, day, time);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 8:
                System.out.println("Finding cross railines routes ......");
                db.findMultiRailRoutes();
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 9:
                System.out.println("Note: similar routes go through same stations, but stop differently");
                System.out.println("Finding similar routes.......This may take a while");
                db.findSimilarRoutes();
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 10:
                System.out.println("Finding stations that all trains pass......");
                db.findStationsAllTrainsPass();
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 11:
                System.out.println("What's the station ID?");
                stationID = Integer.parseInt(input.nextLine());
                System.out.println("Finding trains that do not pass this station.....");
                db.findTrainsNotPass(stationID);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 12:
                System.out.println("What's least number of percent for a route to stop?");
                int threshold = Integer.parseInt(input.nextLine());
                System.out.println("Finding routes that stops more or equal than that......");
                db.findRoutesPercent(threshold);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 13:
                System.out.println("What's the route ID?");
                routeID = Integer.parseInt(input.nextLine());
                System.out.println("Displaying all schedules......");
                db.displayRouteSchedules(routeID);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 14:
                System.out.println("What's the route ID?");
                routeID = Integer.parseInt(input.nextLine());
                System.out.println("What is the day you want to travel?");
                System.out.println("Enter Monday, Tuesday, Wednesday, etc.");
                day = input.nextLine();
                System.out.println("What is the time you want to travel?");
                System.out.println("For example, 02:28, 03:30, 05:40, etc.");
                time = input.nextLine();
                System.out.println("Finding remaining seats......");
                db.findAvailableSeats(routeID, day, time);
                System.out.println("Press enter to go back");
                input.nextLine();
                break;
            case 15:
                return 0;
        }
        return 2;
    }

    public static int displayThankList() {
        System.out.println("\nTech Lead:    Zinan Zhuang\uD83D\uDE06");
        System.out.println("Database Designer:    Zinan Zhuang\uD83D\uDE16");
        System.out.println("Database Programmer:    Zinan Zhuang\uD83D\uDE15");
        System.out.println("Application Programmer:    Zinan Zhuang\uD83E\uDD2F");
        System.out.println("Technical Advisor:    Constantinos Costa\uD83D\uDE0E, Xiaozhong Zhang\uD83E\uDD14");
        return 0;
    }
}
