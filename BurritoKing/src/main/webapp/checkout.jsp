<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cart.cart"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout | Burrito King Resturant</title>
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
	String status = (String) session.getAttribute("status");
	int rewards = (Integer) session.getAttribute("rewards");
	String time = request.getParameter("time");
	boolean isLoggedIn = (uid != null);

	double rewardValue = rewards / 100.0;
	request.setAttribute("rewardValue", rewardValue);

	request.getSession();
	ArrayList<cart> cart_list = (ArrayList<cart>) session.getAttribute("cart-list");

	double total = 0.0;
	double discount = 0.0;
	double totalAmount = 0.0;
	int reward = 0;

	if (request.getParameter("total") != null) {
		total = Double.parseDouble(request.getParameter("total"));
	}

	ArrayList<cart> fullcartlist = (ArrayList<cart>) session.getAttribute("cart_list_fullData");
	ArrayList<String> nameList = new ArrayList<>();
	ArrayList<String> categoryList = new ArrayList<>();
	for (cart item : fullcartlist) {
		nameList.add(item.getName());
		categoryList.add(item.getCategory());

	}

	if ("VIP".equals(status)) {
		int numBurrito = 0;
		int numFries = 0;
		int numSoda = 0;

		// Count the number of each item in the order
		for (cart item : fullcartlist) {
			String itemCat = item.getCategory();
			if (itemCat.equalsIgnoreCase("Burrito")) {
		numBurrito += item.getQuantity();
			} else if (itemCat.equalsIgnoreCase("Fries")) {
		numFries += item.getQuantity();
			} else if (itemCat.equalsIgnoreCase("Soda")) {
		numSoda += item.getQuantity();
			}
		}

		// Calculate the number of meals and round down
		int numMeals = Math.min(Math.min(numBurrito, numFries), numSoda);
		discount = numMeals * 3.0;

	} else if ("Basic".equals(status)) {
		discount = 0.0;
	}

	totalAmount = (total - discount) - reward;
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



	<section class="h-100 gradient-custom">
		<div class="container py-5">
			<div class="row d-flex justify-content-center my-4">
				<div class="col-md-8">
					<div class="card mb-4">
						<div class="card-header py-3">
							<h5 class="mb-0">Checkout</h5>
						</div>
						<div class="card-body">

							<form method="POST" action="placeOrder" class="mt-4">
								<input type="hidden" name="total" 
									value="<%=String.format("%.2f", totalAmount)%>" id="totalPrice"> <input
									type="hidden" name="nameList" value='<%=nameList%>'> <input
									type="hidden" name="categoryList" value='<%=categoryList%>'>

								<div class="form-floating">
									<input type="text" id="claimRewards" name="claimRewards"
										class="form-control form-control-lg" size="17"
										placeholder="Rewards Count" /> <label for="claimRewards">Claim
										Rewards</label>
								</div>

								<br /> <br />
								<div class="form-floating">
									<input type="time" name="specificTime"
										class="form-control form-control-lg" size="17"
										placeholder="Specific time to order" /> <label
										for="specificTime">Specific Time Order</label>
								</div>

								<br /> <br />

								<div data-mdb-input-init class="form-outline form-white mb-4">
									<input type="text" id="typeName"
										class="form-control form-control-lg" size="17"
										placeholder="Cardholder's Name" required />
								</div>
								<br />

								<div data-mdb-input-init class="form-outline form-white mb-4">
									<input type="text" id="cardno" name="cardno"
										class="form-control form-control-lg" size="17"
										placeholder="1234 5678 9012 3457" minlength="16"
										maxlength="19" required />
								</div>
								<br />

								<div class="row mb-4">
									<div class="col-md-6">
										<div data-mdb-input-init class="form-outline form-white">
											<input type="text" id="typeExp" name="exp"
												class="form-control form-control-lg" placeholder="MM/YYYY"
												size="7" id="exp" minlength="6" maxlength="7" required />
										</div>
									</div>
									<div class="col-md-6">
										<div data-mdb-input-init class="form-outline form-white">
											<input type="password" id="cvv"
												class="form-control form-control-lg" name="cvv"
												placeholder="&#9679;&#9679;&#9679;" size="1" minlength="3"
												maxlength="3" required />
										</div>
									</div>
								</div>
								<div class="col-12">
									<button class="btn btn-primary w-100 py-3" type="submit">Pay</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card mb-4">
						<div class="card-header py-3">
							<h5 class="mb-0">Summary</h5>

						</div>
						<div class="card-body">
							<h6 class="mb-0">Available Rewards ${rewards}</h6>
							<h6 class="mb-0">
								Rewards Value : $
								<%=String.format("%.2f", rewardValue)%>
							</h6>
							<ul class="list-group list-group-flush">
								<li
									class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
									Food Price <span>$<span id="totalPrice"><%=String.format("%.2f", total)%></span></span>
								</li>
								<li
									class="list-group-item d-flex justify-content-between align-items-center px-0">
									Discount <span>$<span id="discount"><%=String.format("%.2f", discount)%></span></span>
								</li>
								<li
									class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
									<div>
										<strong>Total amount</strong>
									</div> <span><strong>$<span id="totalAmount"><%=String.format("%.2f", totalAmount)%></span></strong></span>
								</li>
							</ul>

						</div>
					</div>


					<div class="card mb-4">
						<div class="card-body">
							<p>
								<strong>We accept</strong>
							</p>
							<img class="me-2" width="45px"
								src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/visa.svg"
								alt="Visa" /> <img class="me-2" width="45px"
								src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/amex.svg"
								alt="American Express" /> <img class="me-2" width="45px"
								src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/mastercard.svg"
								alt="Mastercard" />
						</div>
					</div>

					<div class="card mb-4">
						<div class="card-body">
							<p>
								<strong>Approxcimate time to ready order.</strong>
							</p>
							<p class="mb-0"><%=time%>
								minutes
							</p>
						</div>
					</div>


				</div>
			</div>
		</div>
	</section>


	<script>
$(document).ready(function() {
    $('#claimRewards').on('input', function() {
        var rewardCount = parseFloat($(this).val()) || 0;
        var rewardValue = rewardCount / 100.0; // Assuming 1 reward = $0.01
        var total = parseFloat('<%=total%>'); 
        var discount = parseFloat('<%=discount%>');
        var newTotalAmount = (total - discount) - rewardValue;

        // Update the total amount displayed on the page
        $('#totalAmount').text(newTotalAmount.toFixed(2));
    });
});
</script>
</body>
</html>
















