<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.cart"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart | Burrito King Resturant</title>
<link rel="icon" href="./assets/images/logo2.png" />
<link href="./assets/styles/bootstrap.min.css" rel="stylesheet">
<link href="./assets/styles/style.css" rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%
	String uid = (String) session.getAttribute("uid");
	boolean isLoggedIn = (uid != null);

	request.getSession();
	ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");

	int totalWaitingTime = 0;
	if (cart_list != null && !cart_list.isEmpty()) {
		for (cart item : cart_list) {
			totalWaitingTime += 10 * 60;
		}
	}

	int minutes = totalWaitingTime / 60;
	
	request.setAttribute("minutes", minutes);
	request.setAttribute("total", request.getAttribute("total"));

	
	%>

	<!-- Navbar & Hero Start -->
	<div class="position-relative p-0">
		<nav
			class="navbar navbar-expand-lg navbar-dark header-bg-color px-4 px-lg-5 py-3 py-lg-0">
			<a href="" class="navbar-brand p-0"> <img
				src="./assets/images/logo.png" alt="Logo">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
				<span class="fa fa-bars"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<div class="navbar-nav ms-auto py-0 pe-4">
					<a href="home.jsp" class="nav-item nav-link">Home</a> <a
						href="about.html" class="nav-item nav-link">About</a> <a
						href="service.html" class="nav-item nav-link">Service</a> <a
						href="menu?category=Burrito" class="nav-item nav-link">Menu</a> <a
						href="contact.html" class="nav-item nav-link">Contact</a>

					<%
					if (isLoggedIn) {
					%>
					<a href="cart" class="nav-item nav-link active"> <i
						class="fa-solid fa-cart-shopping"></i><span
						class="badge badge-danger"> <%
						 if (cart_list != null && !cart_list.isEmpty()) {
						 %> <%=cart_list.size()%> <%
						 } else {
						 %> 0 <%
						 }
						 %>
					</span></a> <a href="user.jsp" class="nav-item nav-link"> <i
						class="fa-solid fa-user"></i></a>
					<%
					} else {
					%>

					<%
					}
					%>
				</div>
				<%
				if (isLoggedIn) {
				%>
				<a href="logout_servlet" class="btn btn-primary py-2 px-4">Logout</a>
				<%
				} else {
				%>
				<a href="login.jsp" class="btn btn-primary py-2 px-4">Sign In/
					Sign Up</a>
				<%
				}
				%>
			</div>
		</nav>
		<div class="py-5 bg-dark hero-header mb-5"></div>
	</div>



	<div class="container my-3">
		<div class="d-flex py-3 align-items-center">
			<h3>
				Total Price: Rs.
				<%=String.format("%.2f", request.getAttribute("total"))%></h3>
			<h6 class="mx-3">
				| Total Waiting Time: <span id="waitingTime"><%= minutes %>
					minutes</span>
			</h6>

			<c:url value="checkout.jsp" var="checkout">
				<c:param name="time" value="${minutes}" />
				<c:param name="total" value="${total}" />
			</c:url>


			<a class="mx-3 btn btn-primary" href="${checkout }">Check Out</a>
		</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">PID</th>
					<th scope="col">Image</th>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Quntity</th>
					<th scope="col" style="text-align: center;">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty cart_list}">
						<tr>
							<td colspan="7" style="text-align: center;">Cart is empty.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="c" items="${cart_list}">
							<tr>
								<td><c:out value="${c.pid}" /></td>
								<td><img src="<c:out value="${c.img}" />"
									alt="Product Image" width="60" height="60"></td>
								<td><c:out value="${c.name}" /></td>
								<td><c:out value="${c.category}" /></td>
								<td><c:out value="${c.price}" /></td>
								<td>
									<form action="orderNow" method="post" class="form-inline">
										<input type="hidden" name="id"
											value="<c:out value="${c.pid}" />" class="form-input">
										<div class="form-group d-flex justify-content-between">
											<a class="btn btn-sm btn-decre"
												href="qtyIncDec_servlet?action=dec&pid=${c.pid}"> <i
												class="fas fa-minus-square"></i></a> <input id="quantityInput"
												type="text" name="quantity" class="form-control"
												value="<c:out value="${c.quantity}" />" readonly
												style="max-width: 60px; text-align: center;"> <a
												class="btn btn-sm btn-incre"
												href="qtyIncDec_servlet?action=inc&pid=${c.pid}"> <i
												class="fas fa-plus-square"></i></a>
										</div>
									</form>
								</td>
								<td style="text-align: center;"><a
									href="remove_cart_servlet?pid=<c:out value="${c.pid}" />"
									class="btn btn-sm btn-danger">Remove</a></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</body>
</html>