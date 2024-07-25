<%@ page import="model.Feedback" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Feedback List</title>

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
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
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
        <%
            String sortByParam = (String) request.getAttribute("sortBy");
            String sortOrderParam = (String) request.getAttribute("sortOrder");
            String product = request.getAttribute("product") != null ? request.getAttribute("product").toString() : "-1";
            String customer = request.getAttribute("customer") != null ? request.getAttribute("customer").toString() : "-1";
            String rating = request.getAttribute("rating") != null ? request.getAttribute("rating").toString() : "-1";
            String search = request.getAttribute("search") != null ? request.getAttribute("search").toString() : "";
            int total = (int) request.getAttribute("total");
        %>
        <jsp:include page="../SidebarManager.jsp"/>
        <div class="content">
            <nav class="navbar navbar-light navbar-glass navbar-top navbar-expand">
                <button class="btn navbar-toggler-humburger-icon navbar-toggler me-1 me-sm-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarVerticalCollapse" aria-controls="navbarVerticalCollapse" aria-expanded="false" aria-label="Toggle Navigation"><span class="navbar-toggle-icon"><span class="toggle-line"></span></span></button>
                <a class="navbar-brand me-1 me-sm-3" href="index.html">
                    <div class="d-flex align-items-center"><img class="me-2" src="Static_access_manager/assets/img/icons/spot-illustrations/logo_fluffy.png" alt="" width="40" /><span class="font-sans-serif">Fluffy</span>
                    </div>
                </a>
                <ul class="navbar-nav align-items-center d-none d-lg-block">
                    <li class="nav-item">
                        <div class="search-box" data-list='{"valueNames":["title"]}'>
                            <form action="feedback-list" method="get" class="position-relative" data-bs-toggle="search" data-bs-display="static">
                                <input name="search" class="form-control search-input fuzzy-search" type="search" placeholder="Search by product name, customer name, etc" aria-label="Search" />
                                <span class="fas fa-search search-box-icon"></span>
                            </form>
                            <div class="dropdown-menu border font-base start-0 mt-2 py-0 overflow-hidden w-100">
                                <div class="scrollbar list py-3" style="max-height: 24rem;">
                                    <div class="d-flex align-items-center">
                                        <span class="fas fa-circle me-2 text-300 fs--2"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
                    <li class="nav-item dropdown"><a class="nav-link pe-0" id="navbarDropdownUser" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="avatar avatar-xl">
                            <img class="rounded-circle" src="Static_access_manager/assets/img/icons/spot-illustrations/logo_fluffy.png" alt="" />
                        </div>
                    </a>
                        <div class="dropdown-menu dropdown-menu-end py-0" aria-labelledby="navbarDropdownUser">
                            <a class="dropdown-item" href="#!">Set status</a>
                            <a class="dropdown-item" href="pages/user/profile.html">Profile &amp; account</a>
                            <a class="dropdown-item" href="pages/authentication/card/logout.html">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>

            <%
                List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
            %>

            <style>
                .form-inline.row {
                    display: flex;
                    justify-content: center;
                }
            </style>

            <div class="card mb-3" id="customersTable" data-list='{"valueNames":["id","name","gender","email","phone","role","status"],"page":10,"pagination":true}'>
                <div class="card-header">
                    <div class="card-body">
                        <div class="row flex-between-center">


                            <form class="row gx-2" method="get" action="feedback-list">
                                <div class="col-auto"><small>Sort by: </small></div>
                                <div class="col-auto">
                                    <select class="form-select form-select-sm" name="sortBy" aria-label="Bulk actions"
                                            onchange="this.form.submit()">
                                        <option value="f.feedback_id" <%= sortByParam != null && sortByParam.equals("f.feedback_id") ? "selected" : "" %>>
                                            ID
                                        </option>
                                        <option value="f.rating" <%= sortByParam != null && sortByParam.equals("f.rating") ? "selected" : "" %>>
                                            Rating
                                        </option>
                                        <option value="f.create_date" <%= sortByParam != null && sortByParam.equals("f.create_date") ? "selected" : "" %>>
                                            Created Date
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
                                <input type="hidden" name="customer" value="<%= customer %>">
                                <input type="hidden" name="product" value="<%= product %>">
                            </form>
                            <br>
                            <div class="col-auto">
                                <h6 class="mb-0"><%= total %> results</h6>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-sm table-striped fs--1 mb-0 overflow-hidden">
                            <thead class="bg-200 text-900">
                            <tr>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="id">ID</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="name">Product</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="gender">Customer</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Rating</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Created Date</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Sale</th>
                                <th class="align-middle no-sort"></th>
                            </tr>
                            </thead class="bg-200 text-900">
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
                                for(Feedback f : feedbackList) {
                            %>
                            <tr class="btn-reveal-trigger <%= f.isDeleted() ? "deleted-product" : "" %>">
                                <td class="id align-middle white-space-nowrap py-2"><a><%=f.getFeedbackId()%></a></td>
                                <td class="name align-middle white-space-nowrap py-2"><a href="product?id=<%=f.getProduct().getId()%>" >
                                    <div class="d-flex d-flex align-items-center">
                                        <div class="avatar avatar-xl me-2">
                                            <img class="rounded-circle" src="<%=f.getProduct().getImg()%>" alt="avatar" />
                                        </div>
                                        <div class="flex-1">
                                            <h5 class="mb-0 fs--1"><%=f.getProduct().getName()%></h5>
                                        </div>
                                    </div>
                                </a></td>
                                <td class="name align-middle white-space-nowrap py-2"><a href="customerdetail?cid=<%=f.getCustomer().getCustomerID()%>" >
                                    <div class="d-flex d-flex align-items-center">
                                        <div class="avatar avatar-xl me-2">
                                            <img class="rounded-circle" src="<%=f.getCustomer().getImg()%>" alt="avatar" />
                                        </div>
                                        <div class="flex-1">
                                            <h5 class="mb-0 fs--1"><%=f.getCustomer().getFullname()%></h5>
                                        </div>
                                    </div>
                                </a></td>
                                <td class="phone align-middle py-2">
                                    <a href="feedback-list?rating=<%=f.getRating()%>">
                                        <% for (int i = 0; i < f.getRating(); i++) { %>
                                        <span class="fas fa-star text-warning"></span>
                                        <% }
                                            for (int i = f.getRating(); i < 5; i++) { %>
                                        <span class="fas fa-star text-200"></span>
                                        <% } %>
                                    </a>
                                </td>
                                <td class="create-date align-middle py-2"><%=f.getCreatedDate()%></td>
                                <td class="create-date align-middle py-2"><a href="staffdetail?sid=<%=f.getSale().getStaffID()%>"><%=f.getSale().getFullname()%> </a> </td>

                                <td class="align-middle white-space-nowrap py-2 text-end">
                                    <div class="dropdown font-sans-serif position-static">
                                        <button class="btn btn-link text-600 btn-sm dropdown-toggle btn-reveal" type="button" id="customer-dropdown-19" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false"><span class="fas fa-ellipsis-h fs--1"></span></button>
                                        <div class="dropdown-menu dropdown-menu-end border py-0" aria-labelledby="customer-dropdown-19">
                                            <div class="bg-white py-2">
                                                <a class="dropdown-item" href="feedback?id=<%=f.getFeedbackId()%>">View</a>
                                                <%
                                                    if (!f.isDeleted()) {
                                                %>
                                                <a class="dropdown-item text-danger" href="feedback-list?id=<%=f.getFeedbackId()%>&action=delete">Delete</a></div>
                                            <%
                                            } else {
                                            %>
                                            <a class="dropdown-item text-success" href="feedback-list?id=<%=f.getFeedbackId()%>&action=restore">Restore</a></div>
                                        <%
                                            }
                                        %>
                                    </div>
                                </td>
                            </tr>

                            <%
                                }
                            %>

                            </tbody>
                        </table>
                    </div>
                </div>
                <%
                    int currentPage = (int) request.getAttribute("currentPage");
                    int totalPages = (int) request.getAttribute("totalPages");
                %>
                <div class="card-footer border-top d-flex justify-content-center">
                    <% if (currentPage > 1) { %>
                    <a class="btn btn-falcon-default btn-sm me-2"
                       href="feedback-list?currentPage=<%= currentPage - 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&product=<%= product %>&customer=<%= customer %>&search=<%=search%>"><span
                            class="fas fa-chevron-left"></span></a>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <a class="btn btn-sm btn-falcon-default text-primary me-2"
                       href="feedback-list?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&product=<%= product %>&customer=<%= customer %>&search=<%=search%>"><%= i %>
                    </a>
                    <% } else if (i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) { %>
                    <a class="btn btn-sm btn-falcon-default me-2"
                       href="feedback-list?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&product=<%= product %>&customer=<%= customer %>&search=<%=search%>"><%= i %>
                    </a>
                    <% } else if (i == currentPage - 3 || i == currentPage + 3) { %>
                    <a class="btn btn-sm btn-falcon-default me-2" href="#!"><span class="fas fa-ellipsis-h"></span></a>
                    <% } %>
                    <% } %>
                    <% if (currentPage < totalPages) { %>
                    <a class="btn btn-falcon-default btn-sm"
                       href="feedback-list?currentPage=<%= currentPage + 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&product=<%= product %>&customer=<%=customer%>&search=<%=search%>"><span
                            class="fas fa-chevron-right"></span></a>
                    <% } %>
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
</script>
</body>


</html>
