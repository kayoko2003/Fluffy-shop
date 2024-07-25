<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Product List</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        .no-data-available {
            text-align: center;
            padding: 20px;
            font-size: 3em;
            color: #555;
        }
    </style>
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

            <%
            int total = (int) request.getAttribute("total");
            DecimalFormat formatter = new DecimalFormat("#,###");

        %>
        <jsp:include page="../SidebarManager.jsp"/>
        <div class="content">
            <nav class="navbar navbar-light navbar-glass navbar-top navbar-expand">
                <ul class="navbar-nav align-items-center d-none d-lg-block">
                    <li class="nav-item">
                        <div class="search-box" data-list='{"valueNames":["title"]}'>
                            <form action="inventorymanagement" method="get" class="position-relative"
                                  data-bs-toggle="search"
                                  data-bs-display="static">
                                <input name="txt" class="form-control search-input fuzzy-search" type="search"
                                       placeholder="Search by product name..." aria-label="Search" value="${search}"/>
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
                    <div class="row flex-between-center" style="flex-wrap: nowrap; width: 80%;">
                        <%
                            String sortByParam = (String) request.getAttribute("sortBy");
                            String sortOrderParam = (String) request.getAttribute("sortOrder");
                        %>
                        <form class="row gx-2" method="get" action="inventorymanagement">
                            <div class="col-auto"><small>Sort by: </small></div>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" name="sortBy" aria-label="Bulk actions"
                                        onchange="this.form.submit()">
                                    <option value="p.product_id" <%= sortByParam != null && sortByParam.equals("p.product_id") ? "selected" : "" %>>
                                        ID
                                    </option>
                                    <option value="p.product_name" <%= sortByParam != null && sortByParam.equals("p.product_name") ? "selected" : "" %>>
                                        Name
                                    </option>
                                    <option value="p.create_date" <%= sortByParam != null && sortByParam.equals("p.create_date") ? "selected" : "" %>>
                                        Date
                                    </option>
                                    <option value="p.import_price" <%= sortByParam != null && sortByParam.equals("p.import_price") ? "selected" : "" %>>
                                        Import Price
                                    </option>
                                    <option value="p.price" <%= sortByParam != null && sortByParam.equals("p.price") ? "selected" : "" %>>
                                        Sale Price
                                    </option>
                                </select>
                            </div>
                            <div class="col-auto"><small>Order: </small></div>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" name="sortOrder" aria-label="Bulk actions"
                                        onchange="this.form.submit()">
                                    <option value="ASC" <%= sortOrderParam != null && sortOrderParam.equals("ASC") ? "selected" : "" %>>
                                        Ascending
                                    </option>
                                    <option value="DESC" <%= sortOrderParam != null && sortOrderParam.equals("DESC") ? "selected" : "" %>>
                                        Descending
                                    </option>
                                </select>
                            </div>
                            <input name="txt" value="${search}" hidden/>
                            <div class="col-auto" style="align-content: center;">
                                <h6 class="mb-0"><%= total %> results</h6>
                            </div>
                        </form>
                        <div class="col-8 col-sm-auto text-end ps-2" style="margin-left: auto;">
                            <div id="table-customers-replace-element">
                                <a class="btn btn-falcon-default btn-sm" id="confirmButton" onclick="submitForm()"
                                   style="display: none;">
                                    <span class="d-none d-sm-inline-block ms-1">Save</span>
                                </a>
                                <a class="btn btn-falcon-default btn-sm" id="cancel" onclick="cancelEdit()"
                                   style="display: none;">
                                    <span class="d-none d-sm-inline-block ms-1">Cancel</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <c:if test="${!listProduct.isEmpty()}">
                        <form id="inventoryForm" method="get" action="inventorymanagement">
                            <table class="table table-sm table-striped fs--1 mb-0 overflow-hidden">
                                <thead class="bg-200 text-900">
                                <tr style="background: white">
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="id">ID</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="name">Product</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Quantity
                                    </th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" style="width: 100px"
                                        data-sort="email">Import price
                                    </th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" style="width: 100px"
                                        data-sort="email">Sale price
                                    </th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Hold</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap"></th>
                                </tr>
                                </thead>
                                <tbody class="list" id="table-customers-body">
                                <c:forEach items="${listProduct}" var="l">
                                    <tr class="btn-reveal-trigger">
                                        <td class="id align-middle white-space-nowrap py-2"><a>${l.getKey().getId()}</a>
                                        </td>
                                        <td class="name align-middle white-space-nowrap py-2">
                                            <a href="product?id=${l.getKey().getId()}">
                                                <div class="d-flex d-flex align-items-center">
                                                    <div class="avatar avatar-xl me-2">
                                                        <img class="rounded-circle" src="${l.getKey().getImg()}"
                                                             alt="avatar"/>
                                                    </div>
                                                    <div class="flex-1">
                                                        <h5 class="mb-0 fs--1">${l.getKey().getName()}</h5>
                                                    </div>
                                                </div>
                                            </a>
                                        </td>
                                        <td class="create-date align-middle py-2">
                                            <span class="quantity-view"
                                                  data-id="${l.getKey().getId()}"><strong>${l.getKey().getSockQuantity()}</strong></span>
                                            <input class="quantity-edit form-control form-control-sm" type="number"
                                                   min="${l.getValue()}"
                                                   name="quantity_${l.getKey().getId()}"
                                                   value="${l.getKey().getSockQuantity()}" style="display: none;"
                                                   required>
                                        </td>
                                        <td class="create-date align-middle py-2" style="color: red">
                                <span class="import-price-view" data-id="${l.getKey().getId()}"><fmt:formatNumber
                                        value="${l.getKey().getImportPrice()}" type="number" minFractionDigits="0"
                                        maxFractionDigits="2"/> VND</span>
                                            <input class="import-price-edit form-control form-control-sm" type="number"
                                                   name="importPrice_${l.getKey().getId()}"
                                                   value="${l.getKey().getImportPrice()}" style="display: none;"
                                                   required>
                                        </td>
                                        <td class="create-date align-middle py-2" style="color: red">
                                            <fmt:formatNumber value="${l.getKey().getPrice()}" type="number"
                                                              minFractionDigits="0" maxFractionDigits="2"/> VND
                                        </td>
                                        <td class="create-date align-middle py-2"><strong>${l.getValue()}</strong></td>
                                        <td class="create-date align-middle py-2">
                                            <c:if test="${acc.getRoleName() == 'Warehouse Staff'}">
                                                <a id="edit_${l.getKey().getId()}"
                                                   onclick="editForm(${l.getKey().getId()})">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                            </c:if>
                                        </td>
                                        <input type="number" min="${l.getValue()}" name="hold_${l.getKey().getId()}"
                                               value="${l.getValue()}" hidden/>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                            <input name="currentPage" value="${currentPage}" hidden/>
                            <input name="sortBy" value="${sortBy}" hidden/>
                            <input name="sortOrder" value="${sortOrder}" hidden/>
                            <input name="currentPage" value="${currentPage}" hidden/>
                            <input name="txt" value="${search}" hidden/>
                            <input name="edit" value="true" hidden/>
                        </form>
                    </c:if>
                    <c:if test="${listProduct.isEmpty()}">
                        <div class="no-data-available">
                            <label style="font-size: xx-large;">No data available</label>
                        </div>
                    </c:if>
                </div>
                <%
                    int currentPage = (int) request.getAttribute("currentPage");
                    int totalPages = (int) request.getAttribute("totalPages");
                    String brand = request.getAttribute("brand") != null ? request.getAttribute("brand").toString() : "-1";
                    String category = request.getAttribute("category") != null ? request.getAttribute("category").toString() : "-1";
                %>
                <div class="card-footer border-top d-flex justify-content-center">
                    <% if (currentPage > 1) { %>
                    <a class="btn btn-falcon-default btn-sm me-2"
                       href="inventorymanagement?txt=${search}&currentPage=<%= currentPage - 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><span
                            class="fas fa-chevron-left"></span></a>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <a class="btn btn-sm btn-falcon-default text-primary me-2"
                       href="inventorymanagement?txt=${search}&currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><%= i %>
                    </a>
                    <% } else if (i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) { %>
                    <a class="btn btn-sm btn-falcon-default me-2"
                       href="inventorymanagement?txt=${search}&currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><%= i %>
                    </a>
                    <% } else if (i == currentPage - 3 || i == currentPage + 3) { %>
                    <a class="btn btn-sm btn-falcon-default me-2" href="#!"><span class="fas fa-ellipsis-h"></span></a>
                    <% } %>
                    <% } %>
                    <% if (currentPage < totalPages) { %>
                    <a class="btn btn-falcon-default btn-sm"
                       href="inventorymanagement?txt=${search}&urrentPage=<%= currentPage + 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><span
                            class="fas fa-chevron-right"></span></a>
                    <% } %>
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
<script>
    function editForm(productId) {
        document.getElementById('confirmButton').style.display = 'inline-block';
        document.getElementById('cancel').style.display = 'inline-block';

        // Ẩn icon edit của sản phẩm được chọn
        document.querySelector(`#edit_` + productId ).style.display = 'none';

        // Hiển thị các input fields cho phép chỉnh sửa cho sản phẩm được chọn
        document.querySelector(`.quantity-view[data-id='`+ productId + `']`).style.display = 'none';
        document.querySelector(`input[name='quantity_`+ productId + `']`).style.display = 'inline-block';

        document.querySelector(`.import-price-view[data-id='`+ productId + `']`).style.display = 'none';
        document.querySelector(`input[name='importPrice_`+ productId + `']`).style.display = 'inline-block';
    }

    function cancelEdit() {
        document.getElementById('confirmButton').style.display = 'none';
        document.getElementById('cancel').style.display = 'none';

        // Hiển thị lại các icon edit
        document.querySelectorAll('a[id^="edit_"]').forEach(function (element) {
            element.style.display = 'inline-block';
        });

        // Ẩn các input fields và hiển thị lại các giá trị cũ
        document.querySelectorAll('.quantity-view').forEach(function (element) {
            element.style.display = 'inline-block';
        });
        document.querySelectorAll('.quantity-edit').forEach(function (element) {
            element.style.display = 'none';
        });

        document.querySelectorAll('.import-price-view').forEach(function (element) {
            element.style.display = 'inline-block';
        });
        document.querySelectorAll('.import-price-edit').forEach(function (element) {
            element.style.display = 'none';
        });
    }

    function submitForm() {
        document.getElementById('inventoryForm').submit();
    }
</script>
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