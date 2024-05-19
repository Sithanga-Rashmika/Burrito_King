<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login | Burrito King Resturant</title>
<link rel="icon" href="./assets/images/logo2.png" />
<link href="./assets/styles/bootstrap.min.css" rel="stylesheet">
<link href="./assets/styles/style.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
</head>
<body>
<%
	String uid = (String) session.getAttribute("uid");
	boolean isLoggedIn = (uid != null);
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
					<a href="cart.jsp" class="nav-item nav-link"> <i
						class="fa-solid fa-cart-shopping"></i></a> <a href="user.jsp"
						class="nav-item nav-link"> <i class="fa-solid fa-user"></i></a>
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
				<a href="login.jsp" class="btn btn-primary py-2 px-4">Sign
					In/ Sign Up</a>
				<%
				}
				%>
			</div>
		</nav>
		<div class="py-5 bg-dark hero-header mb-5">
			
		</div>
	</div>
<!-- Reservation Start -->
        <div class="container-xxl py-5 px-0" style="margin-top:40px;">
            <div class="row g-0">
                <div class="col-md-6">
                	<img src="./assets/images/login.jpeg" alt="Logo" style="width:100%; height:100%;" >
                </div>
                <div class="col-md-6 bg-dark d-flex align-items-center">
                    <div class="p-5 wow fadeInUp" data-wow-delay="0.2s">
                        <h5 class="section-title ff-secondary text-start text-primary fw-normal">SignIn</h5>
                        <h1 class="text-white mb-4">SignIn to Continue</h1>
                        <form action="login" method="POST">
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <div class="form-floating">
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Your Email" required>
                                        <label for="email">Your Email</label>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-floating">
                                        <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password" required>
                                        <label for="pwd">Password</label>
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <button class="btn btn-primary w-100 py-3" type="submit">Sign In</button>
                                </div>
                                <div class="col-12 text-center">
                                	<p class="text-white mt-3">Do not have an account? <a href="register.jsp" class="text-primary">Register</a></p>
                            	</div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
</body>
</html>