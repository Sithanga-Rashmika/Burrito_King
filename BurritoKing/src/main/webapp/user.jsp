<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.cart"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Account | Burrito King Resturant</title>
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
<script src="./assets/dist/table2excel.js"></script>

<script>
	function navigateToMenu(type) {
		if (type == 'user') {
			var url = 'user';
			window.location.href = url;
		} else if (type == 'active') {
			var url = 'activeOrders';
			window.location.href = url;
		} else if (type == 'history') {
			var url = 'orderHistory';
			window.location.href = url;
		}

	}

	// Function to activate the specified tab
	function activateTab(tabId) {
		$('.nav-pills a[href="#' + tabId + '"]').tab('show');
	}

	// Read the activeTab attribute and activate the corresponding tab
	$(document).ready(function() {
		var activeTab = '${activeTab}';
		activateTab('tab-' + activeTab);
	});
	
	
	function confirmCancel(oid) {
	    Swal.fire({
	        title: 'Are you sure?',
	        text: "Are you sure you want to cancel this order?",
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: 'Yes, cancel it!'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            window.location.href = "order_cancel_servlet?oid=" +oid;
	        }
	    });
	}

	
	function becomeVip() {
	    Swal.fire({
	        title: 'Are you sure?',
	        text: "Would you like to receive promotion information via email?",
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: 'Yes!'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            window.location.href = "updateUser.jsp";
	        }
	    });
	}
	

</script>

</head>
<body>
	<%
	String uid = (String) session.getAttribute("uid");
	boolean isLoggedIn = (uid != null);

	request.getSession();
	ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");

	String activeTab = request.getAttribute("activeTab") != null ? (String) request.getAttribute("activeTab") : "1";
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

	<!-- Menu Start -->
	<div class="container-xxl py-5">
		<div class="container">
			<div class="text-center wow fadeInUp" data-wow-delay="0.1s">
				<h5
					class="section-title ff-secondary text-center text-primary fw-normal">My
					Account</h5>
				<h1 class="mb-5">User Account Dashboard</h1>
			</div>
			<div class="tab-class text-center wow fadeInUp" data-wow-delay="0.1s">
				<ul
					class="nav nav-pills d-inline-flex justify-content-center border-bottom mb-5">
					<li class="nav-item"><a
						class="d-flex align-items-center text-start mx-3 ms-0 pb-3"
						data-bs-toggle="pill" href="#tab-1"
						onclick="navigateToMenu('user')"> <i class="fa-solid fa-user"></i>
							<div class="ps-3">
								<small class="text-body">My Profile</small>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="d-flex align-items-center text-start mx-3 pb-3"
						data-bs-toggle="pill" href="#tab-2"
						onclick="navigateToMenu('active')"> <i
							class="fa-solid fa-burger"></i>
							<div class="ps-3">
								<small class="text-body">Active Orders</small>
							</div>
					</a></li>
					<li class="nav-item"><a
						class="d-flex align-items-center text-start mx-3 me-0 pb-3"
						data-bs-toggle="pill" href="#tab-3"
						onclick="navigateToMenu('history')"> <i
							class="fa-regular fa-address-book"></i>
							<div class="ps-3">
								<small class="text-body">Order History</small>
							</div>
					</a></li>
				</ul>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<div
							class="row g-4 d-flex justify-content-center align-items-center">
							<div class="col-lg-6">

								<c:forEach var="user" items="${userDetails}">
									<c:set var="uid" value="${user.UID}" />
									<c:set var="firstName" value="${user.firstName}" />
									<c:set var="lastName" value="${user.lastName}" />
									<c:set var="status" value="${user.status}" />
									<c:set var="email" value="${user.email}" />
									<c:set var="pwd" value="${user.password}" />
									<c:set var="rewards" value="${user.rewards}" />
								</c:forEach>
								<form action="updateUser" method="POST">
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
											<div class="form-floating">
												<input type="text" class="form-control" id="fname"
													name="fname" placeholder="First Name" value="${firstName}"
													required> <label for="fname">First Name</label>
											</div>
										</div>
										<div class="col-md-8">
											<div class="form-floating">
												<input type="text" class="form-control" id="lastName"
													name="lastName" placeholder="Last Name" value="${lastName}"
													required> <label for="lastName">Last Name</label>
											</div>
										</div>
										<div class="col-md-8">
											<div class="form-floating">
												<input type="text" class="form-control" id="status"
													name="status" value="${status}" readonly> <label
													for="status">Status</label>
											</div>
										</div>
										<div class="col-md-8">
											<div class="form-floating">
												<input type="text" class="form-control" id="rewards"
													name="rewards" placeholder="Rewards" value="${rewards}"
													readonly> <label for="email">Rewards</label>
											</div>
										</div>
										<div class="col-md-8">
											<div class="form-floating">
												<input type="email" class="form-control" id="email"
													name="email" placeholder="Your Email" value="${email}"
													readonly> <label for="email">Your Email</label>
											</div>
										</div>
										<div class="col-md-8">
											<div class="form-floating">
												<input type="password" class="form-control" id="pwd"
													name="pwd" placeholder="Password" value="${pwd}"> <label
													for="pwd">Password</label>
											</div>
										</div>
										
										<div
											class="col-6 d-flex justify-content-between align-items-center">
											<button class="btn btn-primary w-15 py-2" type="submit">
												<i class="fas fa-sync-alt"></i> Update
											</button>
											<button class="btn w-15 py-2"
												style="background-color: green; color: white;" type="button"
												onclick="becomeVip()">
												<i class="fa-solid fa-crown"></i> VIP
											</button>

										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div id="tab-2" class="tab-pane fade show p-0">
						<div
							class="row g-4 d-flex justify-content-center align-items-center">
							<div class="col-lg-12">
								<table class="table table-hover">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">Order ID</th>
											<th scope="col">Item List</th>
											<th scope="col">Date</th>
											<th scope="col">Requested Time</th>
											<th scope="col">Status</th>
											<th scope="col">Amount</th>
											<th scope="col">Actions</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order" items="${orderList}" varStatus="loop">
											<tr>
												<th scope="row">${loop.index + 1}</th>
												<td>${order.OID}</td>
												<td>${order.nameList}</td>
												<td>${order.date}</td>
												<td>${order.specific_time}</td>
												<td>${order.status}</td>
												<td>${order.total_amount}</td>
												<td style="display: flex; flex-direction: row;"><c:url
														value="update-order.jsp" var="orUpdate">
														<c:param name="oid" value="${order.OID}" />
														<c:param name="date" value="${order.date}" />
														<c:param name="status" value="${order.status}" />
													</c:url> <a class="btn btn-primary w-15 py-2" href="${orUpdate }">
														<i class="fas fa-sync-alt"></i> Update
												</a>
													<button class="btn btn-danger w-4 py-0"
														style="margin-left: 15px;"
														onclick="confirmCancel('${order.OID}')">
														<i class="fas fa-trash-alt"></i> Cancel
													</button></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div id="tab-3" class="tab-pane fade show p-0">
						<div
							class="row g-4 d-flex justify-content-center align-items-center">
							<div class="col-lg-10">
								<table class="table table-hover" id="table">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">Order ID</th>
											<th scope="col">Item List</th>
											<th scope="col">Date</th>
											<th scope="col">Requested Time</th>
											<th scope="col">Status</th>
											<th scope="col">Amount</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order2" items="${orderList2}" varStatus="loop">
											<tr
												<c:if test="${order2.status eq 'Cancelled'}">style="background-color: #FFBCBC ;"</c:if>>
												<th scope="row">${loop.index + 1}</th>
												<td>${order2.OID}</td>
												<td>${order2.nameList}</td>
												<td>${order2.date}</td>
												<td>${order2.specific_time}</td>
												<td>${order2.status}</td>
												<td>${order2.total_amount}</td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
								<button class="btn btn-primary" id="export">Download
									CSV</button>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Menu End -->
		<script>
      var table2excel = new Table2Excel();

      document.getElementById('export').addEventListener('click', function() {
        table2excel.export(document.querySelectorAll('#table'));
      });
    </script>
</body>
</html>