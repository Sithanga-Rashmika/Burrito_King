package com.user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.connection.DBConnection;

public class user_db_util {

	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;

	public static boolean signUp(String uid, String firstName, String lastName, String email, String pwd) {
		boolean isSuccess = false;

		try {
			// establish db connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "INSERT INTO user VALUES('" + uid + "', '" + firstName + "', '" + lastName + "', 'Basic' , '"
					+ email + "', '" + pwd + "' , 0)";
			int res = stmt.executeUpdate(sql);

			if (res > 0) {
				isSuccess = true;
			} else {
				isSuccess = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSuccess;
	}

	public static List<user> login(String username, String password) {

		ArrayList<user> userDetails = new ArrayList<>();

		try {
			// create db connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT * FROM user WHERE email='" + username + "' and password='" + password + "'";
			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				String uid = rs.getString(1);
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				String status = rs.getString(4);
				String email = rs.getString(5);
				String pwd = rs.getString(6);
				int rewards = rs.getInt(7);
				user userData = new user(uid, firstName, lastName, status, email, pwd, rewards);
				userDetails.add(userData);// pass the user data into array list
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return userDetails;

	}

	public static boolean userUpdate(String uid, String firstName, String lastName, String pwd) {
		boolean isSuccess = false;

		try {
			// establish db connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE user SET firstName='" + firstName + "' , lastName='" + lastName + "' ,password='" + pwd
					+ "' WHERE UID='" + uid + "'";
			int res = stmt.executeUpdate(sql);

			if (res > 0) {
				isSuccess = true;
			} else {
				isSuccess = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSuccess;
	}

	public static List<user> getUser(String uid) {

		ArrayList<user> userDetails = new ArrayList<>();

		try {
			// create db connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT * FROM user WHERE UID='" + uid + "'";
			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				String UID = rs.getString(1);
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				String status = rs.getString(4);
				String email = rs.getString(5);
				String pwd = rs.getString(6);
				int rewards = rs.getInt(7);
				user userData = new user(UID, firstName, lastName, status, email, pwd, rewards);
				userDetails.add(userData);// pass the user data into array list
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return userDetails;

	}
	
	
	public static boolean vipRequest(String uid, String email) {
		boolean isSuccess = false;

		try {
			// establish db connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE user SET email='" + email + "', status='VIP' WHERE UID='" + uid + "'";
			int res = stmt.executeUpdate(sql);

			if (res > 0) {
				isSuccess = true;
			} else {
				isSuccess = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSuccess;
	}
	
	public static boolean updateRewards(String uid, int rewards) {
		boolean isSuccess = false;

		try {
			// establish db connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE user SET rewards = rewards + '"+rewards+"' WHERE UID='"+uid+"'";
			int res = stmt.executeUpdate(sql);

			if (res > 0) {
				isSuccess = true;
			} else {
				isSuccess = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSuccess;
	}
	
	public static boolean claimRewards(String uid , int reward) {
		boolean isSuccess = false;

		try {
			// establish db connection
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE user SET rewards = rewards - '"+reward+"' WHERE UID='"+uid+"'";
			int res = stmt.executeUpdate(sql);

			if (res > 0) {
				isSuccess = true;
			} else {
				isSuccess = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSuccess;
	}
}
