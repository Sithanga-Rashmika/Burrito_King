package com.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.order.order;
import com.order.order_db_util;


@WebServlet("/get_user_servlet")
public class get_user_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session = request.getSession();
		String uid = (String) session.getAttribute("uid");
		
		List<user> userDetails = user_db_util.getUser(uid);
		request.setAttribute("userDetails", userDetails);

		request.setAttribute("activeTab", "1");
		request.getRequestDispatcher("user.jsp").forward(request, response);
	}

}
