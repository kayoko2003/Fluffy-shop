<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Order</title>

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

<!-- Header Section End -->
<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="Static_acess_shop/img/breadcrumbblog.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Orders</h2>
                    <div class="breadcrumb__option">
                        <a href="home">Home</a>
                        <span>My Orders</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<br>

<section class="product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <jsp:include page="../SiderShop.jsp"/>
            </div>
            <!-- Cart Page Start -->
            <%
                int totalPages = (Integer) request.getAttribute("totalPages");
                int currentPage = (Integer) request.getAttribute("currentPage");
                String sortBy = (String) request.getAttribute("sortBy");
                String sortOrder = (String) request.getAttribute("sortOrder");
                int customerId = (Integer) request.getAttribute("customerId");
            %>
            <!-- sorting form -->
            <!-- Sorting form -->
            <div class="col-lg-9">
                <div class="d-flex justify-content-center mb-3">
                    <form action="my-orders" method="get" class="form-inline row">
                        <input type="hidden" name="customerId" value="<%= customerId %>">
                        <div class="col-4">
                            <label for="sortBy" class="me-2"></label>
                            <select name="sortBy" id="sortBy" class="form-control me-2">
                                <option value="o.order_id" <%= sortBy.equals("o.order_id") ? "selected" : "" %>>ID
                                </option>
                                <option value="o.create_date" <%= sortBy.equals("o.create_date") ? "selected" : "" %>>
                                    Date
                                </option>
                                <option value="so.status" <%= sortBy.equals("so.status") ? "selected" : "" %>>Status
                                </option>
                                <option value="pm.payment" <%= sortBy.equals("pm.payment") ? "selected" : "" %>>
                                    Payment
                                </option>
                                <option value="o.total_price" <%= sortBy.equals("o.total_price") ? "selected" : "" %>>
                                    Total
                                </option>
                            </select>
                        </div>
                        <div class="col-4">
                            <label for="sortOrder" class="me-2"></label>
                            <select name="sortOrder" id="sortOrder" class="form-control me-2">
                                <option value="ASC" <%= sortOrder.equals("ASC") ? "selected" : "" %>>ASC</option>
                                <option value="DESC" <%= sortOrder.equals("DESC") ? "selected" : "" %>>DESC</option>
                            </select>
                        </div>
                        <div class="col-4 d-flex align-items-end">
                            <input type="submit" value="Submit" class="btn btn-primary">
                        </div>
                    </form>
                </div>

                <%
                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                    DecimalFormat formatter = new DecimalFormat("#,###");
                %>
                <%
                    for (Order order : orders) {
                %>
                <div class="d-flex mb-3">
                    <div class="col-lg-3" style="margin-right: 10px;">
                        <h4><i class="fas fa-calendar"></i><%=order.getCreatedDate()%>
                        </h4>
                    </div>
                    <div class="col-lg-3" style="margin-left: 10px;">
                        <%
                            String status = order.getStatus().getStatus();
                            String colorClass = "";
                            String iconClass = "";
                            switch (status) {
                                case "Pending":
                                    colorClass = "text-warning";
                                    iconClass = "fas fa-hourglass-half";
                                    break;
                                case "On hold":
                                    colorClass = "text-primary";
                                    iconClass = "fas fa-pause-circle";
                                    break;
                                case "Processing":
                                    colorClass = "text-info";
                                    iconClass = "fas fa-sync-alt";
                                    break;
                                case "Completed":
                                    colorClass = "text-success";
                                    iconClass = "fas fa-check-circle";
                                    break;
                            }
                        %>
                        <h4 class="<%=colorClass%>"><i class="<%=iconClass%> me-2"></i><%=status%>
                        </h4>
                    </div>
                    <div class="col-lg-3" style="margin-left: 10px;">
                        <%
                            String paymentMethod = order.getPaymentMethod().getMethod();
                            String colorClass1 = "";
                            String iconClass1 = "";
                            switch (paymentMethod) {
                                case "COD":
                                    colorClass1 = "text-warning";
                                    iconClass1 = "fas fa-money-bill-wave";
                                    break;
                                case "Online Payment":
                                    colorClass1 = "text-success";
                                    iconClass1 = "fas fa-credit-card";
                                    break;
                            }
                        %>
                        <h4 class="<%=colorClass1%>"><i class="<%=iconClass1%> me-2"></i><%=paymentMethod%>
                        </h4>
                    </div>
                    <div class="text-end col-lg-3">
                        <a href="order?orderId=<%=order.getId()%>"
                           class="btn btn-primary border-3 text-uppercase mb-4 ms-4"
                           type="button"><i class="fas fa-info me-2"></i>Detail</a>
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
                                    <a href="productdetail?pid=<%=orderDetail.getProduct().getId()%>">
                                        <img src="<%=orderDetail.getProduct().getImg()%>"
                                             class="img-fluid me-5 rounded-circle"
                                             style="width: 80px; height: 80px;" alt="">
                                    </a>
                                </div>
                            </th>
                            <td>
                                <a href="productdetail?pid=<%=orderDetail.getProduct().getId()%>">
                                    <p class="mb-0 mt-4"><%=orderDetail.getProduct().getName()%>
                                    </p>
                                </a>
                            </td>

                            <td>

                                <p class="mb-0 mt-4"><%=formatter.format(orderDetail.getPrice())%>
                                </p>
                            </td>
                            <td>
                                <p class="mb-0 mt-4"><%=orderDetail.getQuantity()%>
                                </p>

                            </td>
                            <td>
                                <p class="mb-0 mt-4"><%= formatter.format(orderDetail.getQuantity() * orderDetail.getPrice())%>
                                </p>
                            </td>

                        </tr>
                        <%
                            total += orderDetail.getQuantity() * orderDetail.getPrice();
                        %>
                        <% } %>

                        <tr>
                            <td colspan="4" class="text-end"></td>
                            <td style="color: red; font-size: 30px"><%=formatter.format(total)%>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                    <% } %>
                </div>

            </div>
            <!-- Pagination form -->

        </div>
        <style>
            .form-inline.row {
                display: flex;
                justify-content: center;
            }
        </style>

        <div class="d-flex justify-content-center mt-3">
            <!-- Previous Button Form -->
            <form action="my-orders" method="get" class="form-inline row me-2">
                <input type="hidden" name="customerId" value="<%= customerId %>">
                <div class="d-flex align-items-end">
                    <input type="hidden" name="currentPage" value="<%= Math.max(currentPage - 1, 1) %>">
                    <input type="hidden" name="sortBy" value="<%= sortBy %>">
                    <input type="hidden" name="sortOrder" value="<%= sortOrder %>">
                    <input type="submit" value="Previous"
                           class="btn btn-primary me-2" <%= currentPage == 1 ? "disabled" : "" %>>
                </div>
            </form>
            <!-- Current Page Display -->
            <form action="my-orders" method="get" class="form-inline row me-2 mx-3">
                <input type="hidden" name="customerId" value="<%= customerId %>">
                <input type="hidden" name="sortBy" value="<%= sortBy %>">
                <input type="hidden" name="sortOrder" value="<%= sortOrder %>">
                <div class="d-flex align-items-end">
                    <label for="currentPage" class="me-2"></label>
                    <select name="currentPage" id="currentPage" class="form-control me-2"
                            style="width: fit-content;"
                            onchange="this.form.submit()">
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <option value="<%= i %>" <%= i == currentPage ? "selected" : "" %>><%= i %>
                        </option>
                        <% } %>
                    </select>
                </div>
            </form>
            <!-- Next Button Form -->
            <form action="my-orders" method="get" class="form-inline row ms-3">
                <input type="hidden" name="customerId" value="<%= customerId %>">
                <div class="d-flex align-items-end">
                    <input type="hidden" name="currentPage"
                           value="<%= Math.min(currentPage + 1, totalPages) %>">
                    <input type="hidden" name="sortBy" value="<%= sortBy %>">
                    <input type="hidden" name="sortOrder" value="<%= sortOrder %>">
                    <input type="submit" value="Next"
                           class="btn btn-primary ms-2" <%= currentPage == totalPages ? "disabled" : "" %>>
                </div>
            </form>
        </div>
    </div>
</section>
</body>

<jsp:include page="../Footer.jsp"/>


<script src="Static_acess_shop/js/jquery-3.3.1.min.js"></script>
<script src="Static_acess_shop/js/bootstrap.min.js"></script>
<script src="Static_acess_shop/js/jquery.nice-select.min.js"></script>
<script src="Static_acess_shop/js/jquery-ui.min.js"></script>
<script src="Static_acess_shop/js/jquery.slicknav.js"></script>
<script src="Static_acess_shop/js/mixitup.min.js"></script>
<script src="Static_acess_shop/js/owl.carousel.min.js"></script>
<script src="Static_acess_shop/js/main.js"></script>
</html>

