<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Order Detail</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="Static_acess_shop/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/style.css" type="text/css">

</head>

<body>
<jsp:include page="../Header.jsp"/>

<section class="breadcrumb-section set-bg" data-setbg="Static_acess_shop/img/breadcrumbblog.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Orders</h2>
                    <div class="breadcrumb__option">
                        <a href="home">Home</a>
                        <a href="my-orders">My Orders</a>
                        <span>Order Detail</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<br>

<%
    Order order = (Order) request.getAttribute("order");
%>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="row">
            <div class="col" style="margin-right: 10px;">
                <h3><i class="fas fa-calendar-alt me-2"></i><%=order.getCreatedDate()%>
                </h3>
            </div>
            <div class="col" style="margin-left: 10px;">
                <%
                    String status = order.getStatus().getStatus();
                    String colorClass = "";
                    switch (status) {
                        case "Pending":
                            colorClass = "text-warning";
                            break;
                        case "On hold":
                            colorClass = "text-primary";
                            break;
                        case "Processing":
                            colorClass = "text-info";
                            break;
                        case "Completed":
                            colorClass = "text-success";
                            break;
                    }
                %>
                <h3 class="<%=colorClass%>"><i class="fas fa-info-circle me-2"></i><%=status%>
                </h3>
            </div>
            <div class="col" style="margin-left: 10px;">
                <%
                    String paymentMethod = order.getPaymentMethod().getMethod();
                    String colorClass1 = "";
                    switch (paymentMethod) {
                        case "COD":
                            colorClass1 = "text-warning";
                            break;
                        case "Online Payment":
                            colorClass1 = "text-success";
                            break;
                    }
                %>
                <h3 class="<%=colorClass1%>"><i class="fas fa-credit-card me-2"></i><%=paymentMethod%>
                </h3>
            </div>
        </div>


        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Products</th>
                    <th scope="col">Name</th>
                    <th scope="col">Price</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Total</th>
                </tr>
                </thead>
                <tbody>
                <%
                    double total = 0;
                    for (OrderDetail orderDetail : order.getOrderDetails()) {
                %>
                <tr>
                    <th scope="row">
                        <div class="d-flex align-items-center">
                            <a href="product-detail.jsp?productId=<%=orderDetail.getProduct().getId()%>">
                                <img src="<%=orderDetail.getProduct().getImg()%>" class="img-fluid me-5 rounded-circle"
                                     style="width: 80px; height: 80px;" alt="">
                            </a>
                        </div>
                    </th>
                    <td>
                        <a href="product-detail.jsp?productId=<%=orderDetail.getProduct().getId()%>">
                            <p class="mb-0 mt-4"><%=orderDetail.getProduct().getName()%>
                            </p>
                        </a>
                    </td>
                    <td>
                        <p class="mb-0 mt-4"><%=orderDetail.getPrice()%> $</p>
                    </td>
                    <td>
                        <p class="mb-0 mt-4"><%=orderDetail.getQuantity()%>
                        </p>

                    </td>
                    <td>
                        <p class="mb-0 mt-4"><%= orderDetail.getQuantity() * orderDetail.getPrice()%> $</p>
                    </td>
                    <%
                        total += orderDetail.getQuantity() * orderDetail.getPrice();
                    %>

                </tr>
                <% } %>
                <tr>
                    <td colspan="4" class="text-end"></td>
                    <td style="color: red; font-size: 30px"><%=total%> $</td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>
    <!-- Customer Information -->
    <div class="card mb-4">
        <div class="card-header">
            <h2>Customer Information</h2>
        </div>
        <div class="card-body">
            <form>
                <div class="row">
                    <div class="col-md-6">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" id="fullName" class="form-control" value="<%=order.getFullName()%>" readonly>
                    </div>
                    <div class="col-md-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" class="form-control" value="<%=order.getEmail()%>" readonly>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" id="address" class="form-control" value="<%=order.getAddress()%>" readonly>
                    </div>
                    <div class="col-md-6">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" id="phone" class="form-control" value="<%="0" + order.getPhone()%>" readonly>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <label for="note" class="form-label">Note</label>
                        <textarea id="note" class="form-control form-control-lg" rows="3"
                                  readonly><%=order.getNote()%></textarea>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="Static_acess_shop/js/jquery-3.3.1.min.js"></script>
<script src="Static_acess_shop/js/bootstrap.min.js"></script>
<script src="Static_acess_shop/js/jquery.nice-select.min.js"></script>
<script src="Static_acess_shop/js/jquery-ui.min.js"></script>
<script src="Static_acess_shop/js/jquery.slicknav.js"></script>
<script src="Static_acess_shop/js/mixitup.min.js"></script>
<script src="Static_acess_shop/js/owl.carousel.min.js"></script>
<script src="Static_acess_shop/js/main.js"></script>
</body>

</html>