package com.cart;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/addto_cart_servlet")
public class addto_cart_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		try {
			ArrayList<cart> cartList = new ArrayList<>();
			
			int pid = Integer.parseInt(request.getParameter("pid"));
			cart cart = new cart();
			cart.setPid(pid);
			cart.setQuantity(1);
			
			HttpSession session = request.getSession();
			ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");
			
			if(cart_list == null) {
				cartList.add(cart);
				session.setAttribute("cart-list", cartList);
				request.getRequestDispatcher("menu?category=Burrito").forward(request, response);
			}else {
				cartList = cart_list;
				boolean exist =false;
				
				for(cart c:cartList) {
					if(c.getPid() == pid) {
						exist = true;	
						request.setAttribute("itemExists", true);
						request.getRequestDispatcher("menu").forward(request, response);
					}	
				}
				if(!exist) {
					cartList.add(cart);
					request.getRequestDispatcher("menu?category=Burrito").forward(request, response);
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
