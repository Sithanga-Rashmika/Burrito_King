package com.product;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cart.cart;
import com.connection.DBConnection;



public class menu_db_util {

	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static PreparedStatement pst = null;
	
	
	
	public static List<product> getAllProduct(String Category){
		ArrayList<product> itemList = new ArrayList<>();
		
		try {
			con = DBConnection.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT * FROM product WHERE category='"+Category+"'";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				int pid = rs.getInt(1);
				String name = rs.getString(2);
				String category = rs.getString(3);
				BigDecimal price = rs.getBigDecimal(4);
				String img = rs.getString(5);
				String description = rs.getString(6);
				
				product items = new product(pid, name, category, price, img, description);
				itemList.add(items);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		return itemList;
	}
	
	public static List<cart> getCartProducts(ArrayList<cart> cartList) {
        List<cart> book = new ArrayList<>();
        try {
            if (cartList.size() > 0) {
            	 con = DBConnection.getConnection();

                for (cart item : cartList) {
                    String query = "select * from product where pid=?";
                    pst = con.prepareStatement(query);
                    pst.setInt(1, item.getPid());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        cart row = new cart();
                        row.setPid(rs.getInt(1));
                        row.setName(rs.getString(2));
                        row.setCategory(rs.getString(3));
                        row.setPrice(rs.getBigDecimal(4).multiply(BigDecimal.valueOf(item.getQuantity())));
                        row.setImg(rs.getString(5));
                        row.setQuantity(item.getQuantity());
                        book.add(row);

                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return book;
    }
	
	
	public static double getTotalCart(ArrayList<cart> cartList) {
	    double sum = 0;
	    
	    try {
	        if (cartList.size() > 0) {
	            con = DBConnection.getConnection();
	            for (cart item : cartList) {
	                String query = "select price from product where pid=?";
	                pst = con.prepareStatement(query);
	                pst.setInt(1, item.getPid());
	                rs = pst.executeQuery();
	                

	                while (rs.next()) {
	                    sum += rs.getBigDecimal(1).doubleValue() * item.getQuantity();
	                }
	            }
	        } else {
	            System.out.println("cartList is empty.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } 
	    return sum;
	}


	
}
