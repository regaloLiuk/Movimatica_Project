package com.movimatica.jmg.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connector {
		//private final static String url = "jdbc:postgresql://192.168.0.21:5432/jmg?autoReconnect=true&SSL=false";
		private final static String url = "jdbc:postgresql://localhost:5432/postgres?autoReconnect=true&SSL=false";
		private final static String user = "postgres";
		private final static String password = "test";
	 
		public static Connection getConnection() {
			try{
		    	DriverManager.registerDriver(new org.postgresql.Driver());
		    	Connection conn = DriverManager.getConnection(url, user, password);
		    	return conn;
		    }catch(SQLException e) {
		    	System.out.println("********************ERORE Connection.getConnection***************** " + e.getMessage());	return null;
		    }
			
	    }

}
