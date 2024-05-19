package com.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/retirve_product_servlet")
public class retirve_product_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		String category = request.getParameter("category");
		List<product> itemList = menu_db_util.getAllProduct(category);
		
		request.setAttribute("itemList", itemList);

		request.getRequestDispatcher("menu.jsp").forward(request, response);
	}

}
