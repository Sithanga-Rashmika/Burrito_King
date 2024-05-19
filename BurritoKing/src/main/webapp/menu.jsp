<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.cart"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Menu | Burrito King Resturant</title>
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

<script>
	function navigateToMenu(category) {
		var url = 'menu?category=' + category;
		window.location.href = url;
	}
	function addToCart(pid) {
	    window.location.href = 'addToCart?pid=' + pid;
	}

</script>


<body>
	<%
	String uid = (String) session.getAttribute("uid");
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
	<c:if test="${not empty errorMessage}">
		<script>
			Swal.fire({
				icon : 'error',
				title : 'Error',
				text : '${errorMessage}'
			});
		</script>
	</c:if>

	<c:if test="${itemExists}">
		<script>
            $(document).ready(function() {
                Swal.fire({
                    icon: 'warning',
                    title: 'Oops...',
                    text: 'Item already exists in the cart! Please check the cart.',
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'cart';
                    }
                });
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
					<a href="home.jsp" class="nav-item nav-link">Home</a> <a
						href="about.html" class="nav-item nav-link">About</a> <a
						href="service.html" class="nav-item nav-link">Service</a> <a
						href="menu?category=Burrito" class="nav-item nav-link active">Menu</a>
					<a href="contact.html" class="nav-item nav-link">Contact</a>

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
					</span></a> <a href="user.jsp"
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
				<a href="login.jsp" class="btn btn-primary py-2 px-4">Sign In/
					Sign Up</a>
				<%
				}
				%>
			</div>
		</nav>
		<div class="py-5 bg-dark hero-header mb-5"></div>
	</div>

	<!-- Menu Start -->
	<div class="container-xxl py-5">
		<div class="container">
			<div class="text-center wow fadeInUp" data-wow-delay="0.1s">
				<h5
					class="section-title ff-secondary text-center text-primary fw-normal">Food
					Menu</h5>
				<h1 class="mb-5">Most Popular Items</h1>
			</div>
			<div class="tab-class text-center wow fadeInUp" data-wow-delay="0.1s">
				<ul
					class="nav nav-pills d-inline-flex justify-content-center border-bottom mb-5">
					<li class="nav-item"><a
						class="d-flex align-items-center text-start mx-3 ms-0 pb-3"
						data-bs-toggle="pill" href="#tab-1"
						onclick="navigateToMenu('Burrito')"> <i
							class="fa fa-utensils fa-2x text-primary"></i>
							<div class="ps-3">
								<small class="text-body">Popular</small>
								<h6 class="mt-n1 mb-0">Burrito</h6>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="d-flex align-items-center text-start mx-3 pb-3"
						data-bs-toggle="pill" href="#tab-2"
						onclick="navigateToMenu('Fries')"> <i
							class="fa fa-hamburger fa-2x text-primary"></i>
							<div class="ps-3">
								<small class="text-body">Special</small>
								<h6 class="mt-n1 mb-0">Fries</h6>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="d-flex align-items-center text-start mx-3 me-0 pb-3"
						data-bs-toggle="pill" href="#tab-3"
						onclick="navigateToMenu('Soda')"> <i
							class="fa fa-coffee fa-2x text-primary"></i>
							<div class="ps-3">
								<small class="text-body">Lovely</small>
								<h6 class="mt-n1 mb-0">Soda</h6>
							</div>
					</a></li>
				</ul>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<div class="row g-4 ">

							<c:forEach var="item" items="${itemList}">
								<div class="col-lg-6">
									<div class="d-flex align-items-center">
										<img class="flex-shrink-0 img-fluid rounded" src="${item.img}"
											alt="" style="width: 80px;">
										<div class="w-100 d-flex flex-column text-start ps-4">
											<h5 class="d-flex justify-content-between border-bottom pb-2">
												<span>${item.name}</span> <span class="text-primary">Rs.${item.price}</span>
											</h5>
											<small class="fst-italic">${item.description}</small>
											<div class="d-flex mt-3">
												<button class="btn btn-primary ms-2"
													onclick="addToCart(${item.pid})"> <i
													class="fas fa-shopping-cart"></i> Add To Cart
												</button>
											</div>


										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div id="tab-2" class="tab-pane fade show p-0">
						<div class="row g-4">
							<c:forEach var="item" items="${itemList}">
								<div class="col-lg-6">
									<div class="d-flex align-items-center">
										<img class="flex-shrink-0 img-fluid rounded" src="${item.img}"
											alt="" style="width: 80px;">
										<div class="w-100 d-flex flex-column text-start ps-4">
											<h5 class="d-flex justify-content-between border-bottom pb-2">
												<span>${item.name}</span> <span class="text-primary">Rs.${item.price}</span>
											</h5>
											<small class="fst-italic">${item.description}</small>
											<div class="d-flex mt-3">
												<button class="btn btn-primary ms-2" onclick="addToCart(${item.pid})">
													<i class="fas fa-shopping-cart"></i> Add To Cart
												</button>
											</div>

										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div id="tab-3" class="tab-pane fade show p-0">
						<div class="row g-4">
							<c:forEach var="item" items="${itemList}">
								<div class="col-lg-6">
									<div class="d-flex align-items-center">
										<img class="flex-shrink-0 img-fluid rounded" src="${item.img}"
											alt="" style="width: 80px;">
										<div class="w-100 d-flex flex-column text-start ps-4">
											<h5 class="d-flex justify-content-between border-bottom pb-2">
												<span>${item.name}</span> <span class="text-primary">Rs.${item.price}</span>
											</h5>
											<small class="fst-italic">${item.description}</small>
											<div class="d-flex mt-3">
												<button class="btn btn-primary ms-2" onclick="addToCart(${item.pid})">
													<i class="fas fa-shopping-cart"></i> Add To Cart
												</button>
											</div>

										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Menu End -->


</body>
</html>