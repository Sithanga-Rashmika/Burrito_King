<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.cart"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update User | Burrito King Resturant</title>
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
	String email = (String) session.getAttribute("email");
	boolean isLoggedIn = (uid != null);

	request.getSession();
	ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");


	%>
	<c:if test="${not empty successMessage}">
		<script>
			Swal.fire({
				icon : 'success',
				title : 'Success',
				text : '${successMessage}'
			});
		</script>
	</c:if>

	<!-- Check for errorMessage -->
	<c:if test="${not empty errorMessage}">
		<script>
			Swal.fire({
				icon : 'error',
				title : 'Error',
				text : '${errorMessage}'
			});
		</script>
	</c:if>
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
					<a href="home.jsp" class="nav-item nav-link active">Home</a> <a
						href="about.html" class="nav-item nav-link">About</a> <a
						href="service.html" class="nav-item nav-link">Service</a> <a
						href="menu?category=Burrito" class="nav-item nav-link">Menu</a> <a
						href="contact.html" class="nav-item nav-link">Contact</a>

					<%
					if (isLoggedIn) {
					%>
					<a href="cart" class="nav-item nav-link"> <i
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


	<div class="row g-4 d-flex justify-content-center align-items-center">
		<center>
			<h4>Become A VIP Member</h4>
		</center>
		<div class="col-lg-6">
			<form action="become_VIP_servlet" method="POST">
				<div
					class="row g-3 d-flex justify-content-center align-items-center">
					<div class="col-md-8">
						<div class="form-floating">
							<input type="text" class="form-control" id="uid" name="uid"
								value="${uid}" readonly> <label for="uid">User
								ID</label>
						</div>
					</div>
					
					<div class="col-md-8">
					<p style="text-align:center;">Is it okay system will automatically get your exist email as this VIP account.</p>
						<div class="form-floating">
							<input type="text" class="form-control" id="email" name="email" value="${email}"
								 required> <label for="email">User
								Email</label>
						</div>
					</div>

					<div
						class="col-8 d-flex justify-content-between align-items-center">
						<div class="col-12">
							<button class="btn btn-primary w-100 py-3" type="submit">Update</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>