package com.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/order_cancel_servlet")
public class order_cancel_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		String oid = request.getParameter("oid");
		boolean isTrue;

		isTrue = order_db_util.cancelOrder(oid);
		if(isTrue == true) {
			request.setAttribute("successMessage", "Order Cancelled!");
        	request.getRequestDispatcher("user.jsp").forward(request, response);
		}else {
			request.setAttribute("errorMessage", "Order Cancelled failed!");
			request.getRequestDispatcher("user.jsp").forward(request, response);
		}
	}

}
