<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sale Dashboard</title>
    <link rel="apple-touch-icon" sizes="180x180" href="Static_access_manager/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="Static_access_manager/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="Static_access_manager/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="Static_access_manager/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="Static_access_manager/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="Static_access_manager/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">
    <script src="Static_access_manager/assets/js/config.js"></script>
    <script src="Static_access_manager/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap"
          rel="stylesheet">
    <link href="vendors/overlayscrollbars/OverlayScrollbars.min.css" rel="stylesheet">
    <link href="Static_access_manager/assets/css/theme-rtl.min.css" rel="stylesheet" id="style-rtl">
    <link href="Static_access_manager/assets/css/theme.min.css" rel="stylesheet" id="style-default">
    <link href="Static_access_manager/assets/css/user-rtl.min.css" rel="stylesheet" id="user-style-rtl">
    <link href="Static_access_manager/assets/css/user.min.css" rel="stylesheet" id="user-style-default">
    <script>
        var isRTL = JSON.parse(localStorage.getItem('isRTL'));
        if (isRTL) {
            var linkDefault = document.getElementById('style-default');
            var userLinkDefault = document.getElementById('user-style-default');
            linkDefault.setAttribute('disabled', true);
            userLinkDefault.setAttribute('disabled', true);
            document.querySelector('html').setAttribute('dir', 'rtl');
        } else {
            var linkRTL = document.getElementById('style-rtl');
            var userLinkRTL = document.getElementById('user-style-rtl');
            linkRTL.setAttribute('disabled', true);
            userLinkRTL.setAttribute('disabled', true);
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        h1, h2 {
            text-align: center;
        }

        form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        form label, form input, form select, form button {
            margin: 0 10px;
        }

        .chart-container {
            width: 80%;
            margin: 0 auto;
        }

        canvas {
            width: 100% !important;
            height: 300px !important;
        }

        .btn-list-order {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn-list-order:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<main class="main" id="top">
    <div class="container" data-layout="container">
        <script>
            var isFluid = JSON.parse(localStorage.getItem('isFluid'));
            if (isFluid) {
                var container = document.querySelector('[data-layout]');
                container.classList.remove('container');
                container.classList.add('container-fluid');
            }
        </script>
        <jsp:include page="../SidebarManager.jsp"/>
        <div class="content">
            <h1>Sale Dashboard</h1>
            <form action="saledashboard" method="GET">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" value="${startDate}" required
                       onchange="updateOrderListLink()">
                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" value="${endDate}" required
                       onchange="updateOrderListLink()">
                <label for="salesPerson">Sales Person:</label>
                <select id="salesPerson" name="salesPerson" onchange="updateOrderListLink()">
                    <option value="" ${salesPerson == '' ? 'selected' : ''}>All</option>
                    <c:forEach items="${salesPersons}" var="person">
                        <option value="${person.staffID}" ${salesPerson == person.staffID  ? 'selected' : ''}>${person.fullname}</option>
                    </c:forEach>

                </select>
                <label for="orderStatus">Order Status:</label>
                <select id="orderStatus" name="orderStatus" onchange="updateOrderListLink()">
                    <option value="" ${orderStatus == '' ? 'selected' : ''}>All</option>
                    <option value="success" ${orderStatus == 'success' ? 'selected' : ''}>Success</option>
                    <option value="processing" ${orderStatus == 'processing' ? 'selected' : ''}>Processing</option>
                    <option value="cancel" ${orderStatus == 'cancel' ? 'selected' : ''}>Cancelled</option>
                </select>
                <button type="submit">Filter</button>


            </form>
            <h2>Order Trends (Last 7 Days)</h2>
            <div class="chart-container">
                <canvas id="orderTrendChart"></canvas>
            </div>
            <h2>Revenue Trends (Last 7 Days)</h2>
            <div class="chart-container">
                <canvas id="revenueTrendChart"></canvas>
            </div>
            <a class="btn-list-order" id="orderListLink" href="orderlist">View List Orders</a>
        </div>
    </div>
</main>
<script>

    var orderTrendData = JSON.parse('${orderTrendData}');
    var revenueTrendData = JSON.parse('${revenueTrendData}');

    var ctxOrder = document.getElementById('orderTrendChart').getContext('2d');
    var orderTrendChart = new Chart(ctxOrder, {
        type: 'line',
        data: {
            labels: orderTrendData.labels,
            datasets: [{
                label: 'Success Orders',
                data: orderTrendData.successOrders,
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }, {
                label: 'Processing Orders',
                data: orderTrendData.processingOrders,
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }, {
                label: 'Cancelled Orders',
                data: orderTrendData.cancelledOrders,
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    var ctxRevenue = document.getElementById('revenueTrendChart').getContext('2d');
    var revenueTrendChart = new Chart(ctxRevenue, {
        type: 'line',
        data: {
            labels: revenueTrendData.labels,
            datasets: [{
                label: 'Revenue',
                data: revenueTrendData.revenue,
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    function updateOrderListLink() {
        var saleId = document.getElementById('salesPerson');
        var startDate = document.getElementById('startDate');
        var endDate = document.getElementById('endDate');
        var orderId = document.getElementById('orderStatus');

        var sale = saleId.value;
        var start = startDate.value;
        var end = endDate.value;
        var order = orderId.value;

        var orderListLink = document.getElementById('orderListLink');
        orderListLink.href = 'orderlist?orderDateFrom=' + start + '&orderDateTo=' + end + '&status=' + '&order=' + order + '&sale_id=' + sale;
    }

</script>

<!-- ===============================================-->
<!--    JavaScripts-->
<!-- ===============================================-->
<script src="Static_access_manager/vendors/popper/popper.min.js"></script>
<script src="Static_access_manager/vendors/bootstrap/bootstrap.min.js"></script>
<script src="Static_access_manager/vendors/anchorjs/anchor.min.js"></script>
<script src="Static_access_manager/vendors/is/is.min.js"></script>
<script src="Static_access_manager/vendors/echarts/echarts.min.js"></script>
<script src="Static_access_manager/vendors/fontawesome/all.min.js"></script>
<script src="Static_access_manager/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="Static_access_manager/vendors/list.js/list.min.js"></script>
<script src="Static_access_manager/assets/js/theme.js"></script>
</body>
</html>
