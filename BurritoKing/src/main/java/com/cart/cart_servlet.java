package com.cart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.product.menu_db_util;

@WebServlet("/cart_servlet")
public class cart_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		HttpSession session = request.getSession();
		ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");

	        if (cart_list != null) {
	        	List<cart> cartProduct = null;
	        	cartProduct = menu_db_util.getCartProducts(cart_list);

	        	double total = menu_db_util.getTotalCart(cart_list);

	        	request.setAttribute("cart_list", cartProduct);
	        	request.setAttribute("total", total);
	        	
	        	session.setAttribute("cart_list_fullData",cartProduct );
	        	
				request.getRequestDispatcher("cart.jsp").forward(request, response);
	        }else {
	        	request.setAttribute("emptyCart", true);
	            request.getRequestDispatcher("cart.jsp").forward(request, response);
	        }
	
	}

}
