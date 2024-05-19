package com.user;

import java.io.IOException;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/register_servlet")
public class register_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final SecureRandom random = new SecureRandom();
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		String firstName = request.getParameter("fname");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		
		String uid = generateUniqueUID();
		
		boolean isTrue;
		
		try {
			isTrue = user_db_util.signUp(uid, firstName, lastName, email, pwd);
			if(isTrue) {
				request.setAttribute("successMessage", "Registration successful!");
			}else {
				request.setAttribute("errorMessage", "Registration failed!");
			}
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Something Went Wrong!");
		}
		request.getRequestDispatcher("register.jsp").forward(request, response);
	}
	private String generateUniqueUID() {
		int randomNumber = random.nextInt(90000000) + 10000000;
        return "UID_" + randomNumber;
	}

}
