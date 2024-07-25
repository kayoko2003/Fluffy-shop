<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Brand" %>
<%@ page import="model.Category" %>
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
                    <div class="row flex-between-center">

                        <%
                            String sortByParam = (String) request.getAttribute("sortBy");
                            String sortOrderParam = (String) request.getAttribute("sortOrder");
                            String brand1 = request.getAttribute("brand") != null ? request.getAttribute("brand").toString() : "-1";
                            String category1 = request.getAttribute("category") != null ? request.getAttribute("category").toString() : "-1";
                        %>
                        <form class="row gx-2" method="get" action="products">
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
                                    <option value="p.price" <%= sortByParam != null && sortByParam.equals("p.price") ? "selected" : "" %>>
                                        Price
                                    </option>
                                    <option value="p.number_sold" <%= sortByParam != null && sortByParam.equals("p.number_sold") ? "selected" : "" %>>
                                        Number Sold
                                    </option>
                                    <option value="p.stock_quantity" <%= sortByParam != null && sortByParam.equals("p.stock_quantity") ? "selected" : "" %>>
                                        Stock Quantity
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
                            <input type="hidden" name="brand" value="<%= brand1 %>">
                            <input type="hidden" name="category" value="<%= category1 %>">
                        </form>
                        <div class="col-sm-auto mb-2 mb-sm-0">
                            <h6 class="mb-0"><%= total %> results</h6>
                        </div>
                        <c:if test="${acc.getRoleName() == 'Marketer'}">
                            <div class="col-sm-auto">
                                <a class="btn btn-success" href="add-product">Add Product</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-sm table-striped fs--1 mb-0 overflow-hidden">
                    <thead class="bg-200 text-900">
                    <tr style="background: white">
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="id">ID</th>
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="name">Product</th>
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="gender">Brand</th>
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="gender">Category</th>
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Quantity</th>
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Sold</th>
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Price</th>
                        <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Status</th>
                        <th class="align-middle no-sort"></th>
                    </tr>
                    </thead>
                    <style>
                        .deleted-product {
                            opacity: 0.5;
                        }

                        .deleted-product .restore-button {
                            opacity: 1.0;
                        }
                    </style>
                    <tbody class="list" id="table-customers-body">
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("productList");
                        for (Product p : products) {
                    %>
                    <tr class="btn-reveal-trigger <%= p.isDeleted() ? "deleted-product" : "" %>">
                        <td class="id align-middle white-space-nowrap py-2"><a><%=p.getId()%>
                        </a></td>
                        <td class="name align-middle white-space-nowrap py-2"><a href="product?id=<%=p.getId()%>">
                            <div class="d-flex d-flex align-items-center">
                                <div class="avatar avatar-xl me-2">
                                    <img class="rounded-circle" src="<%=p.getImg()%>" alt="avatar"/>
                                </div>
                                <div class="flex-1">
                                    <h5 class="mb-0 fs--1"><%=p.getName()%>
                                    </h5>
                                </div>
                            </div>
                        </a></td>

                        <td class="create-date align-middle py-2"><a
                                href="products?brand=<%=p.getBrand().getId()%>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>"><%=p.getBrand().getName()%>
                        </a></td>
                        <td class="create-date align-middle py-2"><a
                                href="products?category=<%=p.getCategory().getId()%>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>"><%=p.getCategory().getName()%>
                        </a></td>
                        <td class="create-date align-middle py-2"><strong><%=p.getSockQuantity()%>
                        </strong></td>
                        <td class="create-date align-middle py-2"><strong><%=p.getNumberSold()%>
                        </strong></td>
                        <td class="create-date align-middle py-2" style="color: red"><%=formatter.format(p.getPrice())%>
                            VND
                        </td>
                        <td class="create-date align-middle py-2 <%=p.getStatus().equals("Available") ? "text-success" :
        p.getStatus().equals("Unavailable") ? "text-danger" :
                p.getStatus().equals("Coming soon") ? "text-warning" :
                        p.getStatus().equals("Delayed") ? "text-primary" : "" %>">
                            <%=p.getStatus()%>
                        </td>


                        <td class="align-middle white-space-nowrap py-2 text-end">
                            <div class="dropdown font-sans-serif position-static">
                                <button class="btn btn-link text-600 btn-sm dropdown-toggle btn-reveal" type="button"
                                        id="customer-dropdown-<%= p.getId() %>" data-bs-toggle="dropdown"
                                        data-boundary="window" aria-haspopup="true" aria-expanded="false">
                                    <span class="fas fa-ellipsis-h fs--1"></span>
                                </button>
                                <div class="dropdown-menu dropdown-menu-end border py-0"
                                     aria-labelledby="customer-dropdown-<%= p.getId() %>">
                                    <div class="bg-white py-2">
                                        <a class="dropdown-item" href="product?id=<%= p.getId() %>">View</a>
                                        <% if (!p.isDeleted()) { %>
                                        <c:if test="${acc.getRoleName() == 'Marketer'}">
                                            <form action="products" method="post">
                                                <input type="hidden" name="productId" value="<%= p.getId() %>">
                                                <input type="hidden" name="action" value="delete">
                                                <button type="submit" class="dropdown-item text-danger">Delete</button>
                                            </form>
                                        </c:if>
                                        <% } else { %>
                                        <form action="products" method="post">
                                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                                            <input type="hidden" name="action" value="restore">
                                            <button type="submit" class="dropdown-item text-success">Restore</button>
                                        </form>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>
                </table>
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
                   href="products?currentPage=<%= currentPage - 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><span
                        class="fas fa-chevron-left"></span></a>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                <% if (i == currentPage) { %>
                <a class="btn btn-sm btn-falcon-default text-primary me-2"
                   href="products?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><%= i %>
                </a>
                <% } else if (i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) { %>
                <a class="btn btn-sm btn-falcon-default me-2"
                   href="products?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><%= i %>
                </a>
                <% } else if (i == currentPage - 3 || i == currentPage + 3) { %>
                <a class="btn btn-sm btn-falcon-default me-2" href="#!"><span class="fas fa-ellipsis-h"></span></a>
                <% } %>
                <% } %>
                <% if (currentPage < totalPages) { %>
                <a class="btn btn-falcon-default btn-sm"
                   href="products?currentPage=<%= currentPage + 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><span
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