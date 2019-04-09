import java.sql.*;  //import the file containing definitions for the parts
import java.text.ParseException;  //needed by java for database connection and manipulation


public class ExpressRailwayDriver {
    private static Connection connection; //used to hold the jdbc connection to the DB
    private Statement statement; //used to create an instance of the connection
    private PreparedStatement prepStatement; //used to create a prepared statement, that will be later reused
    private ResultSet resultSet; //used to hold the result of your query (if one exists)
    private String query;  //this will hold the query we are using
	  private String dataFolder; //this will be the folder location to store data

    public ExpressRailwayDriver() {
      final String currentDir = System.getProperty("user.dir");
    	this.dataFolder = currentDir.substring(0, currentDir.length() - 3) + "data";
      importDatabase();
    }

    public void importDatabase() {
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

  public static void main(String args[]) throws SQLException
  {
    /* Making a connection to a DB causes certain exceptions.  In order to handle
	   these, you either put the DB stuff in a try block or have your function
	   throw the Exceptions and handle them later.  For this demo I will use the
	   try blocks */

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
	    ExpressRailwayDriver demo = new ExpressRailwayDriver();

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
	}
  }
}
