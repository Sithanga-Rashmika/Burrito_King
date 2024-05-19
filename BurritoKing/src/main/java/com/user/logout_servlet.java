package com.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/logout_servlet")
public class logout_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		
		try {
			if(request.getSession().getAttribute("uid") != null) {
				request.getSession().removeAttribute("uid");
				session.invalidate();
				response.sendRedirect("login.jsp");
			}else {
				response.sendRedirect("home.jsp");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
