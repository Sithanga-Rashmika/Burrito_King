package com.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/become_VIP_servlet")
public class become_VIP_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email = request.getParameter("email");
		String uid = request.getParameter("uid");
		
		boolean isTrue;
		
		isTrue = user_db_util.vipRequest(uid, email);
		
		if (isTrue) {
			if(request.getSession().getAttribute("uid") != null) {
				request.getSession().removeAttribute("uid");
				request.setAttribute("successMessage", "Welcome to VIP community..!!");
	            request.getRequestDispatcher("home.jsp").forward(request, response);
			}else {
				response.sendRedirect("updateUser.jsp");
			}
        } else {
            request.setAttribute("errorMessage", "Something went wrong!");
            request.getRequestDispatcher("user.jsp").forward(request, response);
        }
		
		
		
	}

}
