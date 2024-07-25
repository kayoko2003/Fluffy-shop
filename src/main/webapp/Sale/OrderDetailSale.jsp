<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Order Detail</title>

    <link rel="apple-touch-icon" sizes="180x180" href="Static_access_manager/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="Static_access_manager/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="Static_access_manager/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="Static_access_manager/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="Static_access_manager/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="Static_access_manager/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">
    <script src="Static_access_manager/assets/js/config.js"></script>
    <script src="Static_access_manager/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet"/>
    <style>
        .product-info {
            display: flex;
            align-items: center;
        }

        .product-info img {
            margin-right: 10px;
        }

        .select2-selection__clear {
            display: none;
        }
    </style>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap"
          rel="stylesheet">
    <link href="Static_access_manager/vendors/overlayscrollbars/OverlayScrollbars.min.css" rel="stylesheet">
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
                            <form action="searchstaff" method="get" class="position-relative" data-bs-toggle="search"
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
                <div class="card-body position-relative">
                    <form action="updateorderdetailbysalemanager">
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Order Details: #${od.id}</h5>
                                <p class="fs--1">${od.createdDate}</p>

                                <label class="form-label" for="statusSelect">Status:</label>
                                <select name="status" class="form-select" style="display: inline; width: 40%;"
                                        id="statusSelect" ${acc.getRoleName() == 'Manager Sale' || acc.getRoleName() == 'Admin' ? 'disabled' : ''}>
                                    <c:choose>
                                        <c:when test="${acc.getRoleName() == 'Sale' || acc.getRoleName() == 'Manager Sale' || acc.getRoleName() == 'Admin'}">
                                            <c:choose>
                                                <c:when test="${od.status.id == '1'}">
                                                    <option value="1" ${"Paid" == od.status.status ? 'selected' : ''}>
                                                        Paid
                                                    </option>
                                                </c:when>
                                                <c:when test="${od.status.id == '2'}">
                                                    <option value="2" ${"Pending" == od.status.status ? 'selected' : ''}>
                                                        Pending
                                                    </option>
                                                </c:when>
                                            </c:choose>
                                            <c:if test="${od.status.id == '3' || od.status.id == '1' || od.status.id == '2'}">
                                                <option value="3" ${"Confirmed" == od.status.status ? 'selected' : ''}>
                                                    Confirmed
                                                </option>
                                            </c:if>
                                            <c:if test="${od.status.id == '4'}">
                                                <option value="4" ${"Shipping" == od.status.status ? 'selected' : ''}>
                                                    Shipping
                                                </option>
                                            </c:if>
                                            <c:if test="${od.status.id == '4' || od.status.id == '5'}">
                                                <option value="5" ${"Delivered" == od.status.status ? 'selected' : ''} >
                                                    Delivered
                                                </option>
                                            </c:if>
                                            <c:if test="${od.status.id == '2' || od.status.id == '4' || od.status.id == '5' || od.status.id == '7'}">
                                                <option value="7" ${"Cancel" == od.status.status ? 'selected' : ''}>
                                                    Cancel
                                                </option>
                                            </c:if>
                                            <c:if test="${od.status.id == '6'}">
                                                <option value="6" ${"Completed" == od.status.status ? 'selected' : ''} >
                                                    Completed
                                                </option>
                                            </c:if>
                                        </c:when>
                                        <c:when test="${acc.getRoleName() == 'Warehouse Staff'}">
                                            <option value="3" ${"Confirmed" == od.status.status ? 'selected' : ''} ${"Completed" == od.status.status ? 'disabled' : ''}>
                                                Confirmed
                                            </option>
                                            <option value="4" ${"Shipping" == od.status.status ? 'selected' : ''} ${"Completed" == od.status.status ? 'disabled' : ''}>
                                                Shipping
                                            </option>
                                            <option value="5" ${"Delivered" == od.status.status ? 'selected' : ''}
                                                    disabled>
                                                Delivered
                                            </option>
                                            <option value="6" ${"Completed" == od.status.status ? 'selected' : ''}
                                                    disabled>
                                                Completed
                                            </option>
                                            <option value="7" ${"Cancel" == od.status.status ? 'selected' : ''}
                                                    disabled>
                                                Cancel
                                            </option>
                                        </c:when>

                                    </c:choose>
                                </select>

                                <input type="hidden" name="orderId" value="${od.id}">

                                <div style="margin-top: 10px">
                                    <c:choose>
                                        <c:when test="${staff.roleName == 'Manager Sale'}">
                                            <label class="form-label" for="sale-manager">Process by sale:</label>
                                            <select name="salemanager" id="sale-manager"
                                                    style="display: inline; width: 40%">
                                                <c:forEach var="sale" items="${listSale}">
                                                    <option value="${sale.staffID}" ${sale.staffID == od.staff.staffID ? 'selected' : ''}>${sale.fullname}
                                                        (has ${saleWithTotalOrder.get(sale.staffID)} order)
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <input type="hidden" name="orderId" value="${od.id}">
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="notes">Notes: </label>
                                    <textarea class="form-control" id="notes" name="salenote"
                                              rows="3" ${acc.getRoleName() == 'Warehouse Staff' ? 'disabled':''}  >${od.saleNote}</textarea>
                                </div>
                                <input type="submit" id="submitButton" onclick="confirmSubmit(event)" value="Update"
                                       style="display: none;">
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card mb-3">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <h5 class="mb-3 fs-0">Billing Address</h5>
                            <h6 class="mb-2">${od.fullName}</h6>

                            <p class="mb-0 fs--1"><strong>Adress:</strong>${od.address}</p>
                            <p class="mb-0 fs--1"><strong>Email:</strong>${od.email}</p>
                            <p class="mb-0 fs--1"><strong>Phone:</strong> ${od.phone}</p>
                        </div>
                        <div class="col-md-4">
                            <h5 class="mb-3 fs-0">Shipping Address</h5>
                            <h6 class="mb-2">${od.fullName}</h6>
                            <p class="mb-0 fs--1">Adress:${od.address}</p>
                            <div class="text-500 fs--1">Phone:${od.phone}</div>
                        </div>

                        <div class="col-md-4 col-lg-4">
                            <h5 class="mb-3 fs-0">Payment Method</h5>
                            <div class="d-flex"><img class="me-3"
                                                     src="Static_access_manager/assets/img/Payment/${od.getPaymentMethod().getId()}.jpg"
                                                     width="40"
                                                     height="30" alt=""/>
                                <div class="flex-1">
                                    <h6 class="mb-0">${od.fullName}</h6>
                                    <p class="mb-0 fs--1">${od.paymentMethod.method}</p>
                                </div>
                            </div>
                            <div class="flex-1">
                                <h5 class="mb-3 fs-0">Note: </h5>
                                <h6 class="mb-2"> ${od.note}</h6>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-body">
                    <div class="table-responsive fs--1">
                        <table class="table table-striped border-bottom">
                            <thead class="bg-200 text-900">
                            <tr>
                                <th class="border-0">Products</th>
                                <th class="border-0 text-center">Quantity</th>
                                <th class="border-0 text-end">Rate</th>
                                <th class="border-0 text-end">Amount</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach items="${listodd}" var="odd">
                            <tr class="border-200">
                                <td class="align-middle">
                                    <div style="display: flex; align-items: center;">
                                        <img src="${odd.product.img}" alt="${odd.product.name}"
                                             style="width: 50px; height: 50px; margin-right: 10px;"/>
                                        <div>
                                            <h6 class="mb-0 text-nowrap">${odd.product.name}</h6>
                                            <p class="mb-0">${odd.product.category.name}</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="align-middle text-center">${odd.quantity}</td>
                                <td class="align-middle text-end">${odd.price}</td>
                                <td class="align-middle text-end">${odd.quantity * odd.price}</td>
                            </tr>
                            </c:forEach>

                        </table>
                        <nav>
                            <ul class="pagination">
                                <c:forEach var="i" begin="1" end="${noOfPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="orderdetailsale?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>
                    </div>
                    <div class="row g-0 justify-content-end">
                        <div class="col-auto">
                            <table class="table table-sm table-borderless fs--1 text-end">
                                <tr class="border-top">
                                    <th class="text-900">Total:</th>
                                    <td class="fw-semi-bold">$${total}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</main>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var statusSelect = document.getElementById("statusSelect");
        var saleSelect = document.getElementById("sale-manager");
        var submitButton = document.getElementById("submitButton");

        statusSelect.addEventListener("change", function () {
            submitButton.style.display = "inline-block";
        });

        saleSelect.addEventListener("change", function () {
            submitButton.style.display = "inline-block";
        });
    });

    function confirmSubmit(event) {
        if (!confirm("Are you sure to save the changes?")) {
            event.preventDefault();
        }
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<script src="Static_access_manager/vendors/popper/popper.min.js"></script>
<script src="Static_access_manager/vendors/bootstrap/bootstrap.min.js"></script>
<script src="Static_access_manager/vendors/anchorjs/anchor.min.js"></script>
<script src="Static_access_manager/vendors/is/is.min.js"></script>
<script src="Static_access_manager/vendors/fontawesome/all.min.js"></script>
<script src="Static_access_manager/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="Static_access_manager/vendors/list.js/list.min.js"></script>
<script src="Static_access_manager/assets/js/theme.js"></script>

</body>

</html>