package com.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/login_servlet")
public class login_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("pwd");
		
		try {
			List<user> userDetails = user_db_util.login(email, password);
			if(userDetails.isEmpty()) {
				request.setAttribute("errorMessage", "Login failed!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}else {
				HttpSession session = request.getSession();
				user user = userDetails.get(0);
				session.setAttribute("uid", user.getUID());
                session.setAttribute("firstName", user.getFirstName());
                session.setAttribute("lastName", user.getLastName());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("status", user.getStatus());
                session.setAttribute("password", user.getPassword());
                session.setAttribute("rewards", user.getRewards());
                
                request.setAttribute("userDetails", userDetails);
            	request.setAttribute("successMessage", "Login successful!");
            	request.getRequestDispatcher("user.jsp").forward(request, response);
			}
		}catch(Exception e) {
			e.printStackTrace();
		    request.setAttribute("errorMessage", "Something went wrong!");
		    request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}
