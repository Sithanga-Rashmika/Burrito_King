package com.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updare_user_servlet")
public class updare_user_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uid = request.getParameter("uid");
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lastName");
        String pwd = request.getParameter("pwd");

        boolean isTrue = user_db_util.userUpdate(uid, firstName, lastName, pwd);

        if (isTrue) {
            request.setAttribute("successMessage", "Update successful!");
            request.getRequestDispatcher("user.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Something went wrong!");
            request.getRequestDispatcher("user.jsp").forward(request, response);
        }
    }
}
