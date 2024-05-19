package com.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;


@WebServlet("/update_order_servlet")
public class update_order_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String time = request.getParameter("date");
        String status = request.getParameter("status");
        String oid = request.getParameter("oid");
        String enteredTime = request.getParameter("recievedTime");

        LocalDateTime parsedTime = LocalDateTime.parse(time, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String formattedTime = parsedTime.format(DateTimeFormatter.ofPattern("HH.mm"));
        LocalTime parsedEnteredTime = LocalTime.parse(enteredTime, DateTimeFormatter.ofPattern("HH:mm"));

        if (LocalTime.parse(formattedTime, DateTimeFormatter.ofPattern("HH.mm")).isBefore(parsedEnteredTime)) {

            boolean isTrue;

            isTrue = order_db_util.updateOrder(oid, status);
            if(isTrue == true) {
                request.setAttribute("successMessage", "Order Status Updated.!");
                request.getRequestDispatcher("update-order.jsp").forward(request, response);
            }else {
                request.setAttribute("errorMessage", "Something went wrong!");
                request.getRequestDispatcher("update-order.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Time is not matching.!");
            request.getRequestDispatcher("update-order.jsp").forward(request, response);
        }
    }

}
