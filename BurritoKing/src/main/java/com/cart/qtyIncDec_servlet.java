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

@WebServlet("/qtyIncDec_servlet")
public class qtyIncDec_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());

		try {
			String action = request.getParameter("action");
			int pid = Integer.parseInt(request.getParameter("pid"));
			
			HttpSession session = request.getSession();
			ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");
			
			if (action != null && pid >= 1) {
				if (action.equals("inc")) {
					for (cart c : cart_list) {
						if (c.getPid() == pid) {
							int quantity = c.getQuantity();
							quantity++;
							c.setQuantity(quantity);
							
							List<cart> cartProduct = null;
				        	cartProduct = menu_db_util.getCartProducts(cart_list);

				        	double total = menu_db_util.getTotalCart(cart_list);

				        	request.setAttribute("cart_list", cartProduct);
				        	request.setAttribute("total", total);
							
							request.getRequestDispatcher("cart.jsp").forward(request, response);
						}
					}
				}

				if (action.equals("dec")) {
					for (cart c : cart_list) {
						if (c.getPid() == pid && c.getQuantity() > 1) {
							int quantity = c.getQuantity();
							quantity--;
							c.setQuantity(quantity);
							break;
						}
					}
					List<cart> cartProduct = null;
		        	cartProduct = menu_db_util.getCartProducts(cart_list);

		        	double total = menu_db_util.getTotalCart(cart_list);

		        	request.setAttribute("cart_list", cartProduct);
		        	request.setAttribute("total", total);
					
					request.getRequestDispatcher("cart.jsp").forward(request, response);
				}
			} else {
				request.getRequestDispatcher("cart.jsp").forward(request, response);
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
