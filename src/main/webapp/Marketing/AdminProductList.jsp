<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Brand" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>Product list</title>


    <!-- ===============================================-->
    <!--    Favicons-->
    <!-- ===============================================-->
    <link rel="apple-touch-icon" sizes="180x180" href="Static_access_manager/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="Static_access_manager/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="Static_access_manager/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="Static_access_manager/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="Static_access_manager/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="Static_access_manager/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">
    <script src="Static_access_manager/assets/js/config.js"></script>
    <script src="Static_access_manager/assets/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>


    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
    <link href="Static_access_manager/assets/vendors/swiper/swiper-bundle.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
    <link href="Static_access_manager/assets/vendors/overlayscrollbars/OverlayScrollbars.min.css" rel="stylesheet">
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
        %>
        <div class="content">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row flex-between-center">

                        <%
                            String sortByParam = (String)request.getAttribute("sortBy");
                            String sortOrderParam = (String)request.getAttribute("sortOrder");
                            String brand1 = request.getAttribute("brand") != null ? request.getAttribute("brand").toString() : "-1";
                            String category1 = request.getAttribute("category") != null ? request.getAttribute("category").toString() : "-1";
                        %>
                        <form class="row gx-2" method="get" action="products">
                            <div class="col-auto"><small>Sort by: </small></div>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" name="sortBy" aria-label="Bulk actions" onchange="this.form.submit()">
                                    <option value="p.product_id" <%= sortByParam != null && sortByParam.equals("p.product_id") ? "selected" : "" %>>ID</option>
                                    <option value="p.product_name" <%= sortByParam != null && sortByParam.equals("p.product_name") ? "selected" : "" %>>Name</option>
                                    <option value="p.create_date" <%= sortByParam != null && sortByParam.equals("p.create_date") ? "selected" : "" %>>Date</option>
                                    <option value="p.price" <%= sortByParam != null && sortByParam.equals("p.price") ? "selected" : "" %>>Price</option>
                                    <option value="p.number_sold" <%= sortByParam != null && sortByParam.equals("p.number_sold") ? "selected" : "" %>>Number Sold</option>
                                    <option value="p.stock_quantity" <%= sortByParam != null && sortByParam.equals("p.stock_quantity") ? "selected" : "" %>>Stock Quantity</option>
                                </select>
                            </div>
                            <div class="col-auto"><small>Order: </small></div>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" name="sortOrder" aria-label="Bulk actions" onchange="this.form.submit()">
                                    <option value="ASC" <%= sortOrderParam != null && sortOrderParam.equals("ASC") ? "selected" : "" %>>Ascending</option>
                                    <option value="DESC" <%= sortOrderParam != null && sortOrderParam.equals("DESC") ? "selected" : "" %>>Descending</option>
                                </select>
                            </div>
                            <input type="hidden" name="brand" value="<%= brand1 %>">
                            <input type="hidden" name="category" value="<%= category1 %>">
                        </form>
                        <div class="col-sm-auto mb-2 mb-sm-0">
                            <h6 class="mb-0"><%= total %> results</h6>
                        </div>
                        <div class="col-sm-auto">
                            <a class="btn btn-success" href="add-product">Add Product</a>

                        </div>
                    </div>
                </div>
                </div>
            <div class="card">
                <div class="card-body p-0 overflow-hidden">
                    <div class="row g-0">
                        <%
                            List<Product> products = (List<Product>) request.getAttribute("productList");
                            for (Product product : products) {
                        %>

                        <div class="col-12 p-card bg-100">
                            <div class="row">
                                <div class="col-sm-5 col-md-4">
                                    <div class="position-relative h-sm-100"><a class="d-block h-100" href="product?id=<%=product.getId()%>"><img class="img-fluid fit-cover w-sm-100 h-sm-100 rounded-1 absolute-sm-centered" src="<%=(product.getImg() != null) ? product.getImg() : "Static_access_manager/assets/img/products/3.jpg"%>" alt=""/></a>
                                    </div>
                                </div>
                                <div class="col-sm-7 col-md-8">
                                    <div class="row">
                                        <div class="col-lg-8">
                                            <h5 class="mt-3 mt-sm-0"><a class="text-dark fs-0 fs-lg-1" href="product?id=<%=product.getId()%>"><%=product.getName()%></a></h5>
                                            <p class="fs--1 mb-2 mb-md-3">
                                                <% for (Brand brand : product.getBrands()) { %>
                                                <a class="text-500" href="products?brand=<%=brand.getId()%>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>"><%= brand.getName() %></a>
                                                <% } %>
                                            </p>
                                            <p class="fs--1 mb-2 mb-md-3">
                                                <% for (Category category : product.getCategories()) { %>
                                                <a class="text-500" href="products?category=<%=category.getId()%>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>"><%= category.getName() %></a>
                                                <% } %>
                                            </p>
<%--                                            <ul class="list-unstyled d-none d-lg-block">--%>
                                                <div class="fas fa-circle" data-fa-transform="shrink-12"></div><span><%=product.getDescription()%></span>
<%--                                            </ul>--%>
                                        </div>
                                        <div class="col-lg-4 d-flex justify-content-between flex-column">
                                            <div>
                                                <h4 class="fs-1 fs-md-2 text-warning mb-0">$<%=product.getPrice()%></h4>
                                                <div class="mb-2 mt-3"><span class="fa fa-star text-warning"></span><span class="fa fa-star text-warning"></span><span class="fa fa-star text-warning"></span><span class="fa fa-star text-warning"></span><span class="fa fa-star-half-alt text-warning star-icon"></span><span class="ms-1">(13)</span>
                                                </div>
                                                <div class="d-none d-lg-block">
                                                    <p class="fs--1 mb-1">Sock Quantity: <strong><%=product.getSockQuantity()%></strong></p>
                                                    <p class="fs--1 mb-1">Number Sold: <strong><%=product.getNumberSold()%></strong></p>
                                                    <p class="fs--1 mb-1">Status: <strong class="text-success"><%=product.getStatus()%></strong>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="mt-2">
                                                <a class="btn btn-sm btn-primary d-lg-block mt-lg-2" href="#!">
                                                    <span class="fas fa-edit"> </span>
                                                    <span class="ms-2 d-none d-md-inline-block">Edit</span>
                                                </a>

                                                <a class="btn btn-sm btn-outline-secondary border-300 d-lg-block me-2 me-lg-0" style="background: red; color: white" href="#!">
                                                    <span class="fas fa-trash"></span>
                                                    <span class="ms-2 d-none d-md-inline-block">Delete</span>
                                                </a>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>


                    </div>
                </div>
                <%
                    int currentPage = (int) request.getAttribute("currentPage");
                    int totalPages = (int) request.getAttribute("totalPages");
                    String brand = request.getAttribute("brand") != null ? request.getAttribute("brand").toString() : "-1";
                    String category = request.getAttribute("category") != null ? request.getAttribute("category").toString() : "-1";
                %>
                <div class="card-footer border-top d-flex justify-content-center">
                    <% if (currentPage > 1) { %>
                    <a class="btn btn-falcon-default btn-sm me-2" href="products?currentPage=<%= currentPage - 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><span class="fas fa-chevron-left"></span></a>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <a class="btn btn-sm btn-falcon-default text-primary me-2" href="products?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><%= i %></a>
                    <% } else if (i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) { %>
                    <a class="btn btn-sm btn-falcon-default me-2" href="products?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><%= i %></a>
                    <% } else if (i == currentPage - 3 || i == currentPage + 3) { %>
                    <a class="btn btn-sm btn-falcon-default me-2" href="#!"><span class="fas fa-ellipsis-h"></span></a>
                    <% } %>
                    <% } %>
                    <% if (currentPage < totalPages) { %>
                    <a class="btn btn-falcon-default btn-sm" href="products?currentPage=<%= currentPage + 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&brand=<%= brand %>&category=<%= category %>"><span class="fas fa-chevron-right"></span></a>
                    <% } %>
                </div>
            </div>
            <footer class="footer">
                <div class="row g-0 justify-content-between fs--1 mt-4 mb-3">
                    <div class="col-12 col-sm-auto text-center">
                        <p class="mb-0 text-600">Thank you for creating with Falcon <span class="d-none d-sm-inline-block">| </span><br class="d-sm-none" /> 2021 &copy; <a href="https://themewagon.com">Themewagon</a></p>
                    </div>
                    <div class="col-12 col-sm-auto text-center">
                        <p class="mb-0 text-600">v3.4.0</p>
                    </div>
                </div>
            </footer>
        </div>
        <div class="modal fade" id="authentication-modal" tabindex="-1" role="dialog" aria-labelledby="authentication-modal-label" aria-hidden="true">
            <div class="modal-dialog mt-6" role="document">
                <div class="modal-content border-0">
                    <div class="modal-header px-5 position-relative modal-shape-header bg-shape">
                        <div class="position-relative z-index-1 light">
                            <h4 class="mb-0 text-white" id="authentication-modal-label">Register</h4>
                            <p class="fs--1 mb-0 text-white">Please create your free Falcon account</p>
                        </div>
                        <button class="btn-close btn-close-white position-absolute top-0 end-0 mt-2 me-2" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body py-4 px-5">
                        <form>
                            <div class="mb-3">
                                <label class="form-label" for="modal-auth-name">Name</label>
                                <input class="form-control" type="text" autocomplete="on" id="modal-auth-name" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label" for="modal-auth-email">Email address</label>
                                <input class="form-control" type="email" autocomplete="on" id="modal-auth-email" />
                            </div>
                            <div class="row gx-2">
                                <div class="mb-3 col-sm-6">
                                    <label class="form-label" for="modal-auth-password">Password</label>
                                    <input class="form-control" type="password" autocomplete="on" id="modal-auth-password" />
                                </div>
                                <div class="mb-3 col-sm-6">
                                    <label class="form-label" for="modal-auth-confirm-password">Confirm Password</label>
                                    <input class="form-control" type="password" autocomplete="on" id="modal-auth-confirm-password" />
                                </div>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="modal-auth-register-checkbox" />
                                <label class="form-label" for="modal-auth-register-checkbox">I accept the <a href="#!">terms </a>and <a href="#!">privacy policy</a></label>
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-primary d-block w-100 mt-3" type="submit" name="submit">Register</button>
                            </div>
                        </form>
                        <div class="position-relative mt-5">
                            <hr class="bg-300" />
                            <div class="divider-content-center">or register with</div>
                        </div>
                        <div class="row g-2 mt-2">
                            <div class="col-sm-6"><a class="btn btn-outline-google-plus btn-sm d-block w-100" href="#"><span class="fab fa-google-plus-g me-2" data-fa-transform="grow-8"></span> google</a></div>
                            <div class="col-sm-6"><a class="btn btn-outline-facebook btn-sm d-block w-100" href="#"><span class="fab fa-facebook-square me-2" data-fa-transform="grow-8"></span> facebook</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- ===============================================-->
<!--    End of Main Content-->
<!-- ===============================================-->


<div class="offcanvas offcanvas-end settings-panel border-0" id="settings-offcanvas" tabindex="-1" aria-labelledby="settings-offcanvas">
    <div class="offcanvas-header settings-panel-header bg-shape">
        <div class="z-index-1 py-1 light">
            <h5 class="text-white"> <span class="fas fa-palette me-2 fs-0"></span>Settings</h5>
            <p class="mb-0 fs--1 text-white opacity-75"> Set your own customized style</p>
        </div>
        <button class="btn-close btn-close-white z-index-1 mt-0" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body scrollbar-overlay px-card" id="themeController">
        <h5 class="fs-0">Color Scheme</h5>
        <p class="fs--1">Choose the perfect color mode for your app.</p>
        <div class="btn-group d-block w-100 btn-group-navbar-style">
            <div class="row gx-2">
                <div class="col-6">
                    <input class="btn-check" id="themeSwitcherLight" name="theme-color" type="radio" value="light" data-theme-control="theme" />
                    <label class="btn d-inline-block btn-navbar-style fs--1" for="themeSwitcherLight"> <span class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0" src="Static_access_manager/assets/img/generic/falcon-mode-default.jpg" alt=""/></span><span class="label-text">Light</span></label>
                </div>
                <div class="col-6">
                    <input class="btn-check" id="themeSwitcherDark" name="theme-color" type="radio" value="dark" data-theme-control="theme" />
                    <label class="btn d-inline-block btn-navbar-style fs--1" for="themeSwitcherDark"> <span class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0" src="Static_access_manager/assets/img/generic/falcon-mode-dark.jpg" alt=""/></span><span class="label-text"> Dark</span></label>
                </div>
            </div>
        </div>
        <hr />
        <div class="d-flex justify-content-between">
            <div class="d-flex align-items-start"><img class="me-2" src="Static_access_manager/assets/img/icons/left-arrow-from-left.svg" width="20" alt="" />
                <div class="flex-1">
                    <h5 class="fs-0">RTL Mode</h5>
                    <p class="fs--1 mb-0">Switch your language direction </p><a class="fs--1" href="../../../documentation/customization/configuration.html">RTL Documentation</a>
                </div>
            </div>
            <div class="form-check form-switch">
                <input class="form-check-input ms-0" id="mode-rtl" type="checkbox" data-theme-control="isRTL" />
            </div>
        </div>
        <hr />
        <div class="d-flex justify-content-between">
            <div class="d-flex align-items-start"><img class="me-2" src="Static_access_manager/assets/img/icons/arrows-h.svg" width="20" alt="" />
                <div class="flex-1">
                    <h5 class="fs-0">Fluid Layout</h5>
                    <p class="fs--1 mb-0">Toggle container layout system </p><a class="fs--1" href="../../../documentation/customization/configuration.html">Fluid Documentation</a>
                </div>
            </div>
            <div class="form-check form-switch">
                <input class="form-check-input ms-0" id="mode-fluid" type="checkbox" data-theme-control="isFluid" />
            </div>
        </div>
        <hr />
        <div class="d-flex align-items-start"><img class="me-2" src="Static_access_manager/assets/img/icons/paragraph.svg" width="20" alt="" />
            <div class="flex-1">
                <h5 class="fs-0 d-flex align-items-center">Navigation Position </h5>
                <p class="fs--1 mb-2">Select a suitable navigation system for your web application </p>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" id="option-navbar-vertical" type="radio" name="navbar" value="vertical" data-page-url="../../../modules/components/navs-and-tabs/vertical-navbar.html" data-theme-control="navbarPosition" />
                        <label class="form-check-label" for="option-navbar-vertical">Vertical</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" id="option-navbar-top" type="radio" name="navbar" value="top" data-page-url="../../../modules/components/navs-and-tabs/top-navbar.html" data-theme-control="navbarPosition" />
                        <label class="form-check-label" for="option-navbar-top">Top</label>
                    </div>
                    <div class="form-check form-check-inline me-0">
                        <input class="form-check-input" id="option-navbar-combo" type="radio" name="navbar" value="combo" data-page-url="../../../modules/components/navs-and-tabs/combo-navbar.html" data-theme-control="navbarPosition" />
                        <label class="form-check-label" for="option-navbar-combo">Combo</label>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <h5 class="fs-0 d-flex align-items-center">Vertical Navbar Style</h5>
        <p class="fs--1 mb-0">Switch between styles for your vertical navbar </p>
        <p> <a class="fs--1" href="../../../modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See Documentation</a></p>
        <div class="btn-group d-block w-100 btn-group-navbar-style">
            <div class="row gx-2">
                <div class="col-6">
                    <input class="btn-check" id="navbar-style-transparent" type="radio" name="navbarStyle" value="transparent" data-theme-control="navbarStyle" />
                    <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-transparent"> <img class="img-fluid img-prototype" src="Static_access_manager/assets/img/generic/default.png" alt="" /><span class="label-text"> Transparent</span></label>
                </div>
                <div class="col-6">
                    <input class="btn-check" id="navbar-style-inverted" type="radio" name="navbarStyle" value="inverted" data-theme-control="navbarStyle" />
                    <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-inverted"> <img class="img-fluid img-prototype" src="Static_access_manager/assets/img/generic/inverted.png" alt="" /><span class="label-text"> Inverted</span></label>
                </div>
                <div class="col-6">
                    <input class="btn-check" id="navbar-style-card" type="radio" name="navbarStyle" value="card" data-theme-control="navbarStyle" />
                    <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-card"> <img class="img-fluid img-prototype" src="Static_access_manager/assets/img/generic/card.png" alt="" /><span class="label-text"> Card</span></label>
                </div>
                <div class="col-6">
                    <input class="btn-check" id="navbar-style-vibrant" type="radio" name="navbarStyle" value="vibrant" data-theme-control="navbarStyle" />
                    <label class="btn d-block w-100 btn-navbar-style fs--1" for="navbar-style-vibrant"> <img class="img-fluid img-prototype" src="Static_access_manager/assets/img/generic/vibrant.png" alt="" /><span class="label-text"> Vibrant</span></label>
                </div>
            </div>
        </div>
        <div class="text-center mt-5"><img class="mb-4" src=".Static_access_manager/assets/img/icons/spot-illustrations/47.png" alt="" width="120" />
            <h5>Like What You See?</h5>
            <p class="fs--1">Get Falcon now and create beautiful dashboards with hundreds of widgets.</p><a class="mb-3 btn btn-primary" href="https://themes.getbootstrap.com/product/falcon-admin-dashboard-webapp-template/" target="_blank">Purchase</a>
        </div>
    </div>
</div><a class="card setting-toggle" href="#settings-offcanvas" data-bs-toggle="offcanvas">
    <div class="card-body d-flex align-items-center py-md-2 px-2 py-1">
        <div class="bg-soft-primary position-relative rounded-start" style="height:34px;width:28px">
            <div class="settings-popover"><span class="ripple"><span class="fa-spin position-absolute all-0 d-flex flex-center"><span class="icon-spin position-absolute all-0 d-flex flex-center">
                  <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M19.7369 12.3941L19.1989 12.1065C18.4459 11.7041 18.0843 10.8487 18.0843 9.99495C18.0843 9.14118 18.4459 8.28582 19.1989 7.88336L19.7369 7.59581C19.9474 7.47484 20.0316 7.23291 19.9474 7.03131C19.4842 5.57973 18.6843 4.28943 17.6738 3.20075C17.5053 3.03946 17.2527 2.99914 17.0422 3.12011L16.393 3.46714C15.6883 3.84379 14.8377 3.74529 14.1476 3.3427C14.0988 3.31422 14.0496 3.28621 14.0002 3.25868C13.2568 2.84453 12.7055 2.10629 12.7055 1.25525V0.70081C12.7055 0.499202 12.5371 0.297594 12.2845 0.257272C10.7266 -0.105622 9.16879 -0.0653007 7.69516 0.257272C7.44254 0.297594 7.31623 0.499202 7.31623 0.70081V1.23474C7.31623 2.09575 6.74999 2.8362 5.99824 3.25599C5.95774 3.27861 5.91747 3.30159 5.87744 3.32493C5.15643 3.74527 4.26453 3.85902 3.53534 3.45302L2.93743 3.12011C2.72691 2.99914 2.47429 3.03946 2.30587 3.20075C1.29538 4.28943 0.495411 5.57973 0.0322686 7.03131C-0.051939 7.23291 0.0322686 7.47484 0.242788 7.59581L0.784376 7.8853C1.54166 8.29007 1.92694 9.13627 1.92694 9.99495C1.92694 10.8536 1.54166 11.6998 0.784375 12.1046L0.242788 12.3941C0.0322686 12.515 -0.051939 12.757 0.0322686 12.9586C0.495411 14.4102 1.29538 15.7005 2.30587 16.7891C2.47429 16.9504 2.72691 16.9907 2.93743 16.8698L3.58669 16.5227C4.29133 16.1461 5.14131 16.2457 5.8331 16.6455C5.88713 16.6767 5.94159 16.7074 5.99648 16.7375C6.75162 17.1511 7.31623 17.8941 7.31623 18.7552V19.2891C7.31623 19.4425 7.41373 19.5959 7.55309 19.696C7.64066 19.7589 7.74815 19.7843 7.85406 19.8046C9.35884 20.0925 10.8609 20.0456 12.2845 19.7729C12.5371 19.6923 12.7055 19.4907 12.7055 19.2891V18.7346C12.7055 17.8836 13.2568 17.1454 14.0002 16.7312C14.0496 16.7037 14.0988 16.6757 14.1476 16.6472C14.8377 16.2446 15.6883 16.1461 16.393 16.5227L17.0422 16.8698C17.2527 16.9907 17.5053 16.9504 17.6738 16.7891C18.7264 15.7005 19.4842 14.4102 19.9895 12.9586C20.0316 12.757 19.9474 12.515 19.7369 12.3941ZM10.0109 13.2005C8.1162 13.2005 6.64257 11.7893 6.64257 9.97478C6.64257 8.20063 8.1162 6.74905 10.0109 6.74905C11.8634 6.74905 13.3792 8.20063 13.3792 9.97478C13.3792 11.7893 11.8634 13.2005 10.0109 13.2005Z" fill="#2A7BE4"></path>
                  </svg></span></span></span></div>
        </div><small class="text-uppercase text-primary fw-bold bg-soft-primary py-2 pe-2 ps-1 rounded-end">customize</small>
    </div>
</a>


<!-- ===============================================-->
<!--    JavaScripts-->
<!-- ===============================================-->
<script src="Static_access_manager/assets/vendors/popper/popper.min.js"></script>
<script src="Static_access_manager/assets/vendors/bootstrap/bootstrap.min.js"></script>
<script src="Static_access_manager/assets/vendors/anchorjs/anchor.min.js"></script>
<script src="Static_access_manager/assets/vendors/is/is.min.js"></script>
<script src="Static_access_manager/assets/vendors/swiper/swiper-bundle.min.js"></script>
<script src="Static_access_manager/assets/vendors/fontawesome/all.min.js"></script>
<script src="Static_access_manager/assets/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="Static_access_manager/assets/vendors/list.js/list.min.js"></script>
<script src="Static_access_manager/assets/js/theme.js"></script>

</body>

</html>