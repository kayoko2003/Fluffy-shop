<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>DashBoard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 20px;
        }

        .mt-4 {
            margin-top: 20px;
        }

        h2 {
            color: #007bff;
        }

        .form-control {
            width: 100%;
        }

        #orderTrendChart {
            margin-top: 20px;
        }
    </style>

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
</head>


<body>


<!-- ===============================================-->
<!--    Main Content-->
<!-- ===============================================-->
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
            <nav class="navbar navbar-light navbar-glass navbar-top navbar-expand">
                <ul class="navbar-nav align-items-center d-none d-lg-block">
                    <li class="nav-item">
                        <div class="search-box" data-list='{"valueNames":["title"]}'>
                            <form action="products" method="get" class="position-relative" data-bs-toggle="search"
                                  data-bs-display="static">
                                <input name="txt" class="form-control search-input fuzzy-search" type="search"
                                       placeholder="Search..." aria-label="Search"/>
                                <span class="fas fa-search search-box-icon"></span>
                            </form>
                        </div>
                    </li>
                </ul>
                <ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
                    <li class="nav-item dropdown"><a class="nav-link pe-0" id="navbarDropdownUser" href="#"
                                                     role="button" data-bs-toggle="dropdown" aria-haspopup="true"
                                                     aria-expanded="false">
                        <div class="avatar avatar-xl">
                            <img class="rounded-circle"
                                 src="${acc.avatar}"
                                 alt=""/>
                        </div>
                    </a>
                        <div class="dropdown-menu dropdown-menu-end py-0" aria-labelledby="navbarDropdownUser">
                            <a class="dropdown-item" href="pages/user/profile.html">Profile</a>
                            <a class="dropdown-item" href="logout">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>
            <div class="card mb-3">
                <div class="card-body">
                    <div class="container">
                        <h2 class="text-center mb-4">Dashboard</h2>
                        <form method="GET" action="dashboard" onsubmit="return validateDates()">
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="startDate">Start Date:</label>
                                    <input value="${startDate}" type="date" class="form-control" id="startDate" name="startDate" required onchange="updateEndDateMin()">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="endDate">End Date:</label>
                                    <input value="${endDate}" type="date" class="form-control" id="endDate" name="endDate" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label>&nbsp;</label>
                                    <button type="submit" class="btn btn-primary btn-block">Filter</button>
                                </div>
                            </div>
                        </form>

                        <script>
                            function validateDates() {
                                var startDate = document.getElementById('startDate').value;
                                var endDate = document.getElementById('endDate').value;

                                if (new Date(startDate) >= new Date(endDate)) {
                                    alert('End Date must be greater than Start Date');
                                    return false;
                                }
                                return true;
                            }

                            function updateEndDateMin() {
                                var startDate = document.getElementById('startDate').value;
                                var endDate = document.getElementById('endDate');
                                endDate.min = startDate;
                            }
                        </script>

                        <div class="mt-4">
                            <div class="card">
                                <div class="card-body">
                                    <p><strong>Total Revenue:</strong>
                                        <span class="badge badge-warning">${totalRevenue} VNĐ</span>
                                </div>
                            </div>
                            </p>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <p><strong>Pending Orders:</strong> ${pendingOrders.size()}</p>
                                                </div>
                                                <div class="col-md-3">
                                                    <p><strong>Hold Orders:</strong> ${holdOrders.size()}</p>
                                                </div>
                                                <div class="col-md-3">
                                                    <p><strong>Completed Orders:</strong> ${completedOrders.size()}</p>
                                                </div>
                                                <div class="col-md-3">
                                                    <p><strong>Processing Orders:</strong> ${processingOrders.size()}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="mt-4">Revenue by Category:</h4>
                                                <canvas id="revenueByCategoryChart" width="800" height="400"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <p><strong>Newly Registered Customers:</strong>
                                                        <span class="badge badge-info">${newlyRegisteredCustomers.size()}</span>
                                                    </p>
                                                </div>
                                                <div class="col-md-6">
                                                    <p><strong>Newly Bought Customers:</strong>
                                                        <span class="badge badge-success">${newlyBoughtCustomers.size()}</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <p class="mt-4"><strong>Average Rating:</strong>
                                                    <span class="badge badge-primary">${averageRating}</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <h4 class="mt-4">Average Rating by Category:</h4>
                                                <canvas id="averageRatingByCategoryChart" width="800" height="400"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="orderTrendChart" style="width: 100%; height: 400px; margin-top: 40px;"></div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/moment@^2.29.1/moment.min.js"></script>
                    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
                    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

                    <script type="text/javascript">
                        google.charts.load('current', {'packages': ['corechart']});
                        google.charts.setOnLoadCallback(drawChart);

                        function drawChart() {
                            var orderTrendData = ${orderTrendJson};
                            var data = new google.visualization.DataTable();
                            data.addColumn('date', 'Date');
                            data.addColumn('number', 'Order Count');
                            for (var key in orderTrendData) {
                                if (orderTrendData.hasOwnProperty(key)) {
                                    var dateParts = key.split('-');
                                    var year = parseInt(dateParts[0]);
                                    var month = parseInt(dateParts[1]) - 1;
                                    var day = parseInt(dateParts[2]);
                                    var count = orderTrendData[key];

                                    data.addRow([new Date(year, month, day), count]);
                                }
                            }

                            var options = {
                                title: 'Order Trend',
                                curveType: 'function',
                                legend: {position: 'bottom'}
                            };
                            var chart = new google.visualization.LineChart(document.getElementById('orderTrendChart'));
                            chart.draw(data, options);
                        }
                    </script>

                    <script>
                        var ctx = document.getElementById('revenueByCategoryChart').getContext('2d');

                        var labels = [];
                        var data = [];

                        <c:forEach var="entry" items="${revenueByCategory}">
                        labels.push("${entry.key}");
                        data.push(${entry.value});
                        </c:forEach>

                        var revenueByCategoryChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Revenue (VNĐ)',
                                    data: data,
                                    backgroundColor: 'rgba(75, 192, 192, 0.6)',
                                    borderColor: 'rgba(75, 192, 192, 1)',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            callback: function (value, index, values) {
                                                return value.toLocaleString('vi-VN') + ' VNĐ';
                                            }
                                        }
                                    }
                                },
                                plugins: {
                                    legend: {
                                        display: false
                                    }
                                }
                            }
                        });
                    </script>

                    <script>
                        var labels = [];
                        var data = [];

                        <c:forEach var="entry" items="${averageRatingByCategory}">
                        labels.push("${entry.key}");
                        data.push(${entry.value});
                        </c:forEach>
                        var ctx = document.getElementById('averageRatingByCategoryChart').getContext('2d');
                        var chart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Average Rating',
                                    data: data,
                                    backgroundColor: 'rgba(75, 14, 192, 0.6)',
                                    borderColor: 'rgba(75, 192, 192, 1)',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            stepSize: 1
                                        }
                                    }
                                }
                            }
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- ===============================================-->
<!--    End of Main Content-->
<!-- ===============================================-->

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
<script src="https://cdn.jsdelivr.net/npm/moment@^2.29.1/moment.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

</body>

</html>