package com.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

	public static String url = "jdbc:mysql://localhost:3306/resturent";
	public static String username = "root";
	public static String password = "Sithanga@1231";
	public static Connection con;

	public static Connection getConnection() {

		try {
			Class.forName("com.mysql.jdbc.Driver");

			con = DriverManager.getConnection(url, username, password);
			System.out.println("Database connection successfull..!!!");

		} catch (Exception e) {
			System.out.println("Database connection is not success..!!!");
		}

		return con;
	}

}
