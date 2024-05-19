<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.cart"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home | Burrito King Resturant</title>
<link rel="icon" href="./assets/images/logo1.png" />
<link href="./assets/styles/bootstrap.min.css" rel="stylesheet">
<link href="./assets/styles/style.css" rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

</head>
<body>
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
	<%
	String uid = (String) session.getAttribute("uid");
	boolean isLoggedIn = (uid != null);

	request.getSession();
	ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");
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
					 %>
						<%=cart_list.size()%> <%
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

		<div class="py-5 bg-dark hero-header mb-5"
			style="background-image: url('./assets/images/hero-bg.jpg');">
			<div class="container my-5 py-5">
				<div class="row align-items-center g-5">
					<div class="col-lg-6 text-center text-lg-start">
						<h1 class="display-3 text-white animated slideInLeft">
							Enjoy Our<br>Delicious Meal
						</h1>
						<p class="text-white animated slideInLeft mb-4 pb-2">Savor the
							rich flavors of our expertly crafted dishes, made with the
							freshest ingredients. Join us at Burrito King Restaurant for an
							unforgettable dining experience that combines great taste with
							exceptional service.</p>
						<a href="menu?category=Burrito"
							class="btn btn-primary py-sm-3 px-sm-5 me-3 animated slideInLeft">Find
							Menu</a>
					</div>
					<div class="col-lg-6 text-center text-lg-end overflow-hidden">
						<img class="img-fluid" src="img/hero.png" alt="">
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Navbar & Hero End -->
	
	<!-- About Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="row g-5 align-items-center">
                    <div class="col-lg-6">
                        <div class="row g-3">
                            <div class="col-6 text-start">
                                <img class="img-fluid rounded w-100 wow zoomIn" data-wow-delay="0.1s" src="./assets/images/home1.jpeg">
                            </div>
                            <div class="col-6 text-start">
                                <img class="img-fluid rounded w-75 wow zoomIn" data-wow-delay="0.3s" src="./assets/images/home2.jpeg" style="margin-top: 25%;">
                            </div>
                            <div class="col-6 text-end">
                                <img class="img-fluid rounded w-75 wow zoomIn" data-wow-delay="0.5s" src="./assets/images/home3.jpeg">
                            </div>
                            <div class="col-6 text-end">
                                <img class="img-fluid rounded w-100 wow zoomIn" data-wow-delay="0.7s" src="./assets/images/home4.jpeg">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h5 class="section-title ff-secondary text-start text-primary fw-normal">About Us</h5>
                        <h1 class="mb-4">Welcome to <i class="fa fa-utensils text-primary me-2"></i>Burrito King Resturant</h1>
                        <p class="mb-4">Passionate and creative individual with a diverse background in technology and the arts. Thrives in dynamic environments, enjoys exploring new ideas, and constantly pushes boundaries. Outside of work, finds joy in outdoor adventures, culinary experiments, and immersive storytelling.</p>
                        <div class="row g-4 mb-4">
                            <div class="col-sm-6">
                                <div class="d-flex align-items-center border-start border-5 border-primary px-3">
                                    <h1 class="flex-shrink-0 display-5 text-primary mb-0" data-toggle="counter-up">15</h1>
                                    <div class="ps-4">
                                        <p class="mb-0">Years of</p>
                                        <h6 class="text-uppercase mb-0">Experience</h6>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="d-flex align-items-center border-start border-5 border-primary px-3">
                                    <h1 class="flex-shrink-0 display-5 text-primary mb-0" data-toggle="counter-up">50</h1>
                                    <div class="ps-4">
                                        <p class="mb-0">Popular</p>
                                        <h6 class="text-uppercase mb-0">Master Chefs</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- About End -->
	
</body>
</html>