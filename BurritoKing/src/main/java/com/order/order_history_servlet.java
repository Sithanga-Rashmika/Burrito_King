package com.order;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/order_history_servlet")
public class order_history_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session = request.getSession();
		String uid = (String) session.getAttribute("uid");

		List<order> orderList2 = order_db_util.getOrdersHistory(uid);
		request.setAttribute("orderList2", orderList2);

		request.setAttribute("activeTab", "3");
		request.getRequestDispatcher("user.jsp").forward(request, response);
		
		
	}

}
