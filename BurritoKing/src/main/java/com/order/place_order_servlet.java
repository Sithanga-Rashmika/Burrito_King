package com.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cart.cart;
import com.user.user_db_util;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/place_order_servlet")
public class place_order_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final SecureRandom random = new SecureRandom();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	
        HttpSession session = request.getSession();
        String OID = generateUniqueOID(); 
        String userstatus = (String) session.getAttribute("status");
        System.out.println(userstatus);
        
        String uid = (String) session.getAttribute("uid");
        String specificTime = (request.getParameter("specificTime") != null) ? request.getParameter("specificTime") : "N/A";
        float total = Float.parseFloat(request.getParameter("total"));
        String cardNumber = request.getParameter("cardno");
        String cvv = request.getParameter("cvv");
        String expire = request.getParameter("exp");
        String status = "Placed";
        String nameList =  request.getParameter("nameList");
        int rewardCount = Integer.parseInt(request.getParameter("claimRewards"));

        // Get current date and time and format
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String date = currentDateTime.format(formatter);

        boolean isValid = true;

        if (cardNumber == null || !cardNumber.matches("^\\d{4} ?\\d{4} ?\\d{4} ?\\d{4}$")) {
            isValid = false;
            request.setAttribute("errorMessage", "Card number must have 16 digits.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        if (expire == null || !expire.matches("^\\d{2}/\\d{4}$")) {
            isValid = false;
            request.setAttribute("errorMessage", "Expiry date must be in the format MM/YYYY.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        } else {
            String[] parts = expire.split("/");
            int month = Integer.parseInt(parts[0]);
            int year = Integer.parseInt(parts[1]);
            LocalDateTime expiryDate = LocalDateTime.of(year, month, 1, 0, 0).plusMonths(1).minusDays(1); // Last day of the expiry month

            if (expiryDate.isBefore(LocalDateTime.now())) {
                isValid = false;
                request.setAttribute("errorMessage", "Expiry date must be a future date. ");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }
        }

        if (cvv == null || !cvv.matches("^\\d{3}$")) {
            isValid = false;
            request.setAttribute("errorMessage", "CVV must have 3 digits. ");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        if(isValid) {
            boolean isTrue;
            boolean isTrue2;
            boolean isTrue3;
            
            try {
                isTrue = order_db_util.placeOrder(OID, uid, date, specificTime, status, total, nameList);
                int rewards= (int) total;
                
                if ("VIP".equals(status)) {
                    isTrue2 = user_db_util.updateRewards(uid, rewards);
                    isTrue3 = user_db_util.claimRewards(uid, rewardCount);
                    if(isTrue && isTrue2 && isTrue3 ) {
                    	request.getSession().removeAttribute("cart_list");
                        request.setAttribute("successMessage", "Order Placed!");
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Something went wrong!");
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    }
                }else {
                	if(isTrue) {
                    	request.getSession().removeAttribute("cart_list");
                        request.setAttribute("successMessage", "Order Placed!");
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Something went wrong!");
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    }
                }


                

            } catch(Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Something went wrong!");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }

        }
    }

    private String generateUniqueOID() {
        int randomNumber = random.nextInt(90000000) + 10000000;
        return "OID_" + randomNumber;
    }
}
