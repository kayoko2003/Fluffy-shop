<%@ page import="model.Feedback" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Feedback Detail</title>

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
                Feedback feedback = (Feedback) request.getAttribute("feedback");
            %>
            <div class="row">
                <div class="col-12">
                    <div class="card mb-3 btn-reveal-trigger">
                        <div class="card-header position-relative min-vh-25 mb-8">
                            <div class="cover-image">
                                <div class="bg-holder rounded-3 rounded-bottom-0" style="background-image:url(/Static_access_manager/assets/img/logos/logo_fluffy.png);">
                                </div>
                                <input class="d-none" id="upload-cover-image" type="file" disabled/>
                                <%--                                <label class="cover-image-file-input" for="upload-cover-image"><span class="fas fa-camera me-2"></span><span>Change cover photo</span></label>--%>
                            </div>
                            <div class="avatar avatar-5xl avatar-profile shadow-sm img-thumbnail rounded-circle">
                                <div class="h-100 w-100 rounded-circle overflow-hidden position-relative"> <img src="<%=feedback.getCustomer().getImg()%>" width="200" alt="" data-dz-thumbnail="data-dz-thumbnail " />
                                    <input class="d-none" id="profile-image" type="file" />
                                    <%--                                    <label class="mb-0 overlay-icon d-flex flex-center" for="profile-image"><span class="bg-holder overlay overlay-0"></span><span class="z-index-1 text-white dark__text-white text-center fs--1"><span class="fas fa-camera"></span><span class="d-block">Update</span></span></label>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-3">
                <div class="card-header">
                    <h5 class="mb-0">Customer ID: <%=feedback.getCustomer().getCustomerID()%></h5>
                </div>
                <div class="card-body bg-light">
                    <form class="row g-3">
                        <div class="col-lg-6">
                            <label class="form-label" for="first-name">Full Name</label>
                            <input class="form-control" id="first-name" name="fullname" type="text" disabled value="<%=feedback.getCustomer().getFullname()%>"/>
                        </div>
                        <div class="col-lg-2">
                            <label class="form-label" for="gender">Gender</label>

                            <input class="form-control" id="gender" name="gender" type="text" disabled value="<%=feedback.getCustomer().getGender()%>" readonly/>
                        </div>
                        <div class="col-lg-4">
                            <label class="form-label" for="dob">DOB</label>
                            <input class="form-control" id="dob" name="dob" type="date" disabled value="<%=feedback.getCustomer().getDob()%>"/>
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label" for="email1">Email</label>
                            <input class="form-control" id="email1" type="text" disabled value="<%=feedback.getCustomer().getEmail()%>" readonly />
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label" for="email2">Phone</label>
                            <input class="form-control" id="email2" name="phoneNumber" disabled type="text" value="0<%=feedback.getCustomer().getPhoneNumber()%>"/>
                        </div>
                        <div class="col-lg-12">
                            <label class="form-label" for="email2">Address</label>
                            <input class="form-control" id="address" name="address" disabled type="text" value="<%=feedback.getCustomer().getAddress()%>"/>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-header">
                    <h5 class="mb-0">Feedback</h5>
                </div>
                <div class="card-body border-top p-0">
                    <div class="row g-0 align-items-center border-bottom py-2 px-3">
                        <style>
                            .wide-table {
                                width: 100%; /* or any other percentage or fixed value you want */
                            }
                        </style>
                        <table class="table table-sm table-striped fs--1 mb-0 overflow-hidden wide-table">
                            <thead class="bg-200 text-900">
                            <tr>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="id">ID</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="name">Product</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Rating</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Created Date</th>
                                <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Sale</th>
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
                            <tr class="btn-reveal-trigger <%= feedback.isDeleted() ? "deleted-product" : "" %>">
                                <td class="id align-middle white-space-nowrap py-2"><a><%=feedback.getFeedbackId()%></a></td>
                                <td class="name align-middle white-space-nowrap py-2"><a href="product?id=<%=feedback.getProduct().getId()%>" >
                                    <div class="d-flex d-flex align-items-center">
                                        <div class="avatar avatar-xl me-2">
                                            <img class="rounded-circle" src="<%=feedback.getProduct().getImg()%>" alt="avatar" />
                                        </div>
                                        <div class="flex-1">
                                            <h5 class="mb-0 fs--1"><%=feedback.getProduct().getName()%></h5>
                                        </div>
                                    </div>
                                </a></td>

                                <td class="phone align-middle py-2">
                                    <a href="feedback-list?rating=<%=feedback.getRating()%>">
                                        <% for (int i = 0; i < feedback.getRating(); i++) { %>
                                        <span class="fas fa-star text-warning"></span>
                                        <% }
                                            for (int i = feedback.getRating(); i < 5; i++) { %>
                                        <span class="fas fa-star text-200"></span>
                                        <% } %>
                                    </a>
                                </td>
                                <td class="create-date align-middle py-2"><%=feedback.getCreatedDate()%></td>
                                <td class="create-date align-middle py-2"><a href="staffdetail?sid=<%=feedback.getSale().getStaffID()%>"><%=feedback.getSale().getFullname()%> </a> </td>

                                <td class="align-middle white-space-nowrap py-2 text-end">
                                    <div class="dropdown font-sans-serif position-static">
                                        <button class="btn btn-link text-600 btn-sm dropdown-toggle btn-reveal" type="button" id="customer-dropdown-19" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false"><span class="fas fa-ellipsis-h fs--1"></span></button>
                                        <div class="dropdown-menu dropdown-menu-end border py-0" aria-labelledby="customer-dropdown-19">
                                            <div class="bg-white py-2">
                                                <a class="dropdown-item" href="feedback?id=<%=feedback.getFeedbackId()%>">View</a>
                                                <%
                                                    if (!feedback.isDeleted()) {
                                                %>
                                                <a class="dropdown-item text-danger" href="feedback-list?id=<%=feedback.getFeedbackId()%>&action=delete">Delete</a></div>
                                            <%
                                            } else {
                                            %>
                                            <a class="dropdown-item text-success" href="feedback-list?id=<%=feedback.getFeedbackId()%>&action=restore">Restore</a></div>
                                        <%
                                            }
                                        %>
                                    </div>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                        <div class="col-md-auto pe-3" style="height: fit-content">
                            <span class="badge badge-soft-success rounded-pill">Content: </span>
                        </div>
                        <div class="col-md mt-1 mt-md-0">
                            <p class="fs--1 mb-0"><%=feedback.getContent()%></p>
                        </div>


                    </div>
                </div>
            </div>
            <style>
                .feedback-image {
                    width: 50%;
                    height: auto;
                    display: block;
                    margin-left: auto;
                    margin-right: auto;
                }
            </style>

            <div class="card mb-3">
                <div class="card-header">
                    <h5 class="mb-0">Image</h5>
                </div>
                <div class="card-body border-top p-0">
                    <img class="feedback-image" src="<%=feedback.getImagePath()%>">
                </div>
                <br>
                <form action="feedback-list" method="get">
                    <%
                        if(feedback.isDeleted()){
                    %>
                    <input type="hidden" name="action" value="restore"/>
                    <input type="hidden" name="id" value="<%=feedback.getFeedbackId()%>"/>
                    <div class="col-12 d-flex justify-content-end">
                        <button class="btn btn-primary" type="submit">Restore </button>
                    </div>
                    <%
                    } else if (!feedback.isDeleted()) {
                    %>
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="<%=feedback.getFeedbackId()%>"/>
                    <div class="col-12 d-flex justify-content-end">
                        <button class="btn btn-danger" type="submit">Delete </button>
                    </div>
                    <%
                        }
                    %>
                </form>
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

</body>

</html>