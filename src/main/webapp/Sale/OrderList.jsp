<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>List Order</title>

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
    <style>
        .styled-button {
            display: inline-block;
            padding: 5px 10px;
            font-size: 14px;
            color: #007bff;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-align: center;
            cursor: pointer;
            text-decoration: none;
            margin-right: 4px;
        }

        .styled-button:hover {
            background-color: #f0f0f0;
        }

        .styled-button.active {
            font-weight: bold;
            color: red;
        }

        .no-data-available {
            text-align: center;
            padding: 20px;
            font-size: 3em;
            color: #555;
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
            <form method="get" action="orderlist">
                <nav class="navbar navbar-light navbar-glass navbar-top navbar-expand">
                    <ul class="navbar-nav align-items-center d-none d-lg-block">
                        <li class="nav-item">
                            <div class="search-box" data-list='{"valueNames":["title"]}'>
                                <input name="search" class="form-control search-input fuzzy-search" type="search"
                                       placeholder="Search..." aria-label="Search" value="${search}"/>
                                <span class="fas fa-search search-box-icon"></span>
                            </div>
                        </li>
                    </ul>
                    <ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
                        <li class="nav-item dropdown"><a class="nav-link pe-0" id="navbarDropdownUser" href="#"
                                                         role="button" data-bs-toggle="dropdown" aria-haspopup="true"
                                                         aria-expanded="false">
                            <div class="avatar avatar-xl">
                                <img class="rounded-circle" src="${acc.avatar}" alt=""/>
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
                    <div class="card-header">
                        <div class="col-sm-auto d-flex align-items-center pe-0">
                            <h5 class="fs-0 mb-0 text-nowrap py-2 py-xl-0">List order</h5>
                        </div>

                        <div class="row flex-between-center">
                            <div class="col-sm-auto d-flex align-items-center pe-0">
                                <div class="col-auto"><small>Sort by: </small></div>
                                <div class="col-auto">
                                    <select class="form-select form-select-sm" name="sortBy"
                                            aria-label="Bulk actions"
                                            onchange="this.form.submit()">
                                        <option value="o.create_date" ${sortBy.equals("o.create_date") ? "selected":""} >
                                            Order date
                                        </option>
                                        <option value="o.full_name" ${sortBy.equals("o.full_name") ? "selected":""} >
                                            Customer name
                                        </option>
                                        <option value="o.total_price" ${sortBy.equals("o.total_price") ? "selected":""} >
                                            Total cost
                                        </option>
                                        <option value="o.status_id" ${sortBy.equals("o.status_id") ? "selected":""} >
                                            Status
                                        </option>
                                    </select>
                                </div>
                                <div style="padding-left: 5px " class="col-auto"><small>Order: </small></div>
                                <div class="col-auto">
                                    <select class="form-select form-select-sm" name="sortOrder"
                                            aria-label="Bulk actions"
                                            onchange="this.form.submit()">
                                        <option value="ASC" ${sortOrder.equals("ASC") ? "selected" : ""} >
                                            Ascending
                                        </option>
                                        <option value="DESC" ${sortOrder.equals("DESC") ? "selected":""} >
                                            Descending
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-8 col-sm-auto text-end ps-2">
                                <div id="table-customers-replace-element">
                                    <a class="btn btn-falcon-default btn-sm" id="confirmButton"
                                       style="display: none;" onclick="submitForm()">
                                        <span class="d-none d-sm-inline-block ms-1">${button}</span>
                                    </a>
                                    <button class="btn btn-falcon-default btn-sm mx-2" type="button"
                                            onclick="toggleFilter()">
                                        <span class="fas fa-filter" data-fa-transform="shrink-3 down-2"></span>
                                        <span class="d-none d-sm-inline-block ms-1">Filter</span>
                                    </button>
                                </div>

                                <!-- Filter window -->
                                <div id="filter-window"
                                     style="display:none; position: absolute; background-color: white; border: 1px solid #ccc; padding: 10px; z-index: 1000;">
                                    <h5>Filter Options</h5>
                                    <label for="filter-order-date-from">Order Date From:</label>
                                    <input type="date" id="filter-order-date-from" value="${orderDateFrom}"
                                           name="orderDateFrom">
                                    <label for="filter-order-date-to">Order Date To:</label>
                                    <input type="date" id="filter-order-date-to" name="orderDateTo"
                                           value="${orderDateTo}" style="margin-bottom: 12px;"><br>
                                    <c:if test="${isPacking != 'true'}">
                                        <label for="filter-status">Status:</label>
                                        <select id="filter-status" name="status">
                                            <option value="">Any</option>
                                            <c:forEach items="${statusOrder}" var="o">
                                                <option value="${o.id}" ${o.id == status ? 'selected' : ''}>
                                                        ${o.status}
                                                </option>
                                            </c:forEach>
                                        </select><br>
                                        <c:if test="${isSale != 'true'}">
                                            <label for="filter-sale">Sale:</label>
                                            <select id="filter-sale" name="sale_id">
                                                <option value="">All</option>
                                                <c:forEach items="${listStaff}" var="l">
                                                    <option value="${l.staffID}" ${l.staffID == sale_id ? 'selected' : ''}>
                                                            ${l.fullname}
                                                    </option>
                                                </c:forEach>
                                            </select><br>
                                        </c:if>
                                    </c:if>
                                    <div style="display: flex; gap: 10px; padding-top: 15px">
                                        <button class="btn btn-primary" type="submit">Apply</button>
                                        <button class="btn btn-secondary" type="button" onclick="toggleFilter()">Close
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="card">
                <div class="card-body p-0" style="margin-top: 10px">
                    <c:if test="${listOrder != null}">
                        <div class="table-responsive">
                            <form id="checkbox" action="processorder">
                                <table class="table table-sm table-striped fs--1 mb-0 overflow-hidden">
                                    <thead class="bg-200 text-900">
                                    <tr>
                                        <th class="pe-1 align-middle white-space-nowrap">ID</th>
                                        <th class="pe-1 align-middle white-space-nowrap">Order date</th>
                                        <th class="pe-1 align-middle white-space-nowrap">Customer name</th>
                                        <th class="pe-1 align-middle white-space-nowrap" style="width: 24%">Product</th>
                                        <th class="pe-1 align-middle white-space-nowrap">Total cost</th>
                                        <th class="pe-1 align-middle white-space-nowrap">Status</th>
                                        <th class="pe-1 align-middle white-space-nowrap">${acc.getRoleName() == 'Manager Sale' ? 'Sale' : ''}</th>
                                    </tr>
                                    </thead>
                                    <tbody class="list" id="table-customers-body">

                                    <c:forEach items="${listOrder}" var="l">
                                        <tr class="btn-reveal-trigger">
                                            <td class="align-middle py-2"><a
                                                    href="orderdetailsale?oid=${l.id}">${l.id}</a>
                                            </td>
                                            <td class="align-middle py-2">${l.createdDate}</td>
                                            <td class="align-middle py-2"><a href="">${l.getFullName()}</a></td>
                                            <td class="align-middle py-2">
                                                <div class="row">
                                                    <a>${l.getOrderDetails().get(0).getProduct().getName()}<a>
                                                        <c:if test="${l.getOrderDetails().size() > 1}">
                                                        <a href="orderdetailsale?oid=${l.id}"
                                                           style="text-decoration: underline">& ${l.getOrderDetails().size() - 1}
                                                            others</a>
                                                        </c:if>
                                                </div>
                                            </td>
                                            <c:set var="total" value="0"/>
                                            <c:forEach items="${l.getOrderDetails()}" var="o">
                                                <c:set var="total" value="${total + (o.quantity * o.price)}"/>
                                            </c:forEach>
                                            <td class="align-middle py-2"><fmt:formatNumber value="${total}"
                                                                                            type="number"
                                                                                            minFractionDigits="0"
                                                                                            maxFractionDigits="2"/></td>
                                            <td class="align-middle py-2">${l.status.getStatus()}</td>
                                            <c:if test="${acc.getRoleName() == 'Sale' || acc.getRoleName() == 'Warehouse Staff'}">
                                                <td class="align-middle py-2"><c:if
                                                        test="${(acc.roleName == 'Sale' && (l.status.id == 4 || l.status.id == 1) && acc.staffID == l.getStaff().getStaffID()) || (acc.roleName == 'Warehouse Staff' && l.status.id == 3)}">
                                                    <input type="checkbox"
                                                           name="checkbox"
                                                           value="${l.id}" onclick="toggleConfirmButton()"/></c:if>
                                                </td>
                                            </c:if>
                                            <c:if test="${acc.getRoleName() == 'Manager Sale'}">
                                                <td class="align-middle py-2">
                                                        ${l.getStaff().getFullname()}
                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </c:if>
                    <c:if test="${listOrder == null}">
                        <div class="no-data-available">
                            <label style="font-size: xx-large;">No data available</label>
                        </div>
                    </c:if>
                </div>
                <div class="row">
                    <div class="card-footer d-flex align-items-center justify-content-center">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="orderlist?currentPage=${i}&search=${search}&sortBy=${sortBy}&sortOrder=${sortOrder}&orderDateFrom=${orderDateFrom}&orderDateTo=${orderDateTo}&status=${status}"
                               class="styled-button <c:if test='${i == currentPage}'>active</c:if>">
                                    ${i}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

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
<script>
    function toggleFilter() {
        var filterWindow = document.getElementById('filter-window');
        if (filterWindow.style.display === 'none' || filterWindow.style.display === '') {
            filterWindow.style.display = 'block';
        } else {
            filterWindow.style.display = 'none';
        }
    }

    function toggleConfirmButton() {
        const checkboxes = document.querySelectorAll('input[name="checkbox"]');
        const confirmButton = document.getElementById('confirmButton');
        let isChecked = false;

        checkboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                isChecked = true;
            }
        });

        if (isChecked) {
            confirmButton.style.display = 'inline-block';
        } else {
            confirmButton.style.display = 'none';
        }
    }

    function submitForm() {
        var confirmation = confirm("Are you sure to save the changes?");
        if (confirmation) {
            document.getElementById('checkbox').submit();
        }
    }
</script>

</body>


</html>