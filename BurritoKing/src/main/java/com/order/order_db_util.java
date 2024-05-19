package com.order;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.connection.DBConnection;


public class order_db_util {

	
	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	
	
	public static boolean placeOrder(String OID, String UID, String date, String specTime, String status, float total, String nameList) {
		boolean isSuccess = false;
		
		try {
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "INSERT INTO orders VALUES('"+OID+"', '"+UID+"', '"+date+"', '"+specTime+"' , '"+status+"', '"+total+"' , '"+nameList+"')";
			int res = stmt.executeUpdate(sql);
			
			if(res > 0) {
				isSuccess = true;
			}else {
				isSuccess = false;
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	public static List<order> getActiveOrders(String uid){
		ArrayList<order> orderList = new ArrayList<>();
		
		try {
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT * FROM orders WHERE status IN ('Placed', 'Await For Collection') AND UID ='"+uid+"' ORDER BY date DESC;";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				String OID = rs.getString(1);
				String UID = rs.getString(2);
				String date = rs.getString(3);
				String time = rs.getString(4);
				String status = rs.getString(5);
				float price = rs.getFloat(6);
				String nameList = rs.getString(7);
				
				order orders = new order(OID, UID, date, time, status, price, nameList);
				orderList.add(orders);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}
	
	public static List<order> getOrdersHistory(String uid){
		ArrayList<order> orderList = new ArrayList<>();
		
		try {
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT * FROM orders WHERE status IN ('Cancelled', 'Collected') AND UID ='"+uid+"' ORDER BY date DESC;";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				String OID = rs.getString(1);
				String UID = rs.getString(2);
				String date = rs.getString(3);
				String time = rs.getString(4);
				String status = rs.getString(5);
				float price = rs.getFloat(6);
				String nameList = rs.getString(7);
				
				order orders = new order(OID, UID, date, time, status, price, nameList);
				orderList.add(orders);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}
	
	public static boolean cancelOrder(String oid) {
		boolean isSuccess = false;
		
		try {
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE orders SET status='Cancelled' WHERE OID='"+oid+"' ";			
			int rs = stmt.executeUpdate(sql);
			
			if(rs>0) {
				isSuccess = true;
			}else {
				isSuccess = false;
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		
		return isSuccess; 
	}

	public static boolean updateOrder(String oid, String status) {
		boolean isSuccess = false;
		
		try {
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE orders SET status='"+status+"' WHERE OID='"+oid+"' ";			
			int rs = stmt.executeUpdate(sql);
			
			if(rs>0) {
				isSuccess = true;
			}else {
				isSuccess = false;
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		
		return isSuccess; 
	}
}
