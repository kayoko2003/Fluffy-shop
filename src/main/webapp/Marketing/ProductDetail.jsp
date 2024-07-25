<%@ page import="model.Product" %>
<%@ page import="model.Category" %>
<%@ page import="model.Brand" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Product Detail</title>

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
          Product product = (Product) request.getAttribute("product");

        %>
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
                            <img class="rounded-circle"
                                 src="Static_access_manager/assets/img/icons/spot-illustrations/logo_fluffy.png"
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
                    <form id="productForm" enctype="multipart/form-data" action="product" method="post">
                        <div class="row">
                            <div class="col-lg-6 mb-4 mb-lg-0">
                                <div class="product-slider" id="galleryTop">
                                    <div class="theme-slider position-lg-absolute all-0">
                                        <div class="h-100">
                                            <img class="rounded-1 h-100 w-100" src="<%=product.getImg()%>" alt=""
                                                 style="object-fit: scale-down;"/>
                                            <input type="file" id="productImage" name="productImage"
                                                   style="display: none;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <h5><i class="fas fa-tag"></i> <input style="border-width: 0" type="text"
                                                                      name="productName"
                                                                      value="<%=product.getName()%>" disabled></h5>
                                <select class="form-select" name="productCategory" disabled
                                        onchange="updateCategoryName(this)">
                                    <%
                                        Set<Category> categories = (Set<Category>) request.getAttribute("categories");
                                        for (Category category : categories) {
                                            String selected = category.getId() == product.getCategory().getId() ? "selected" : "";
                                    %>
                                    <option value="<%= category.getId() %>"
                                            data-name="<%= category.getName() %>" <%= selected %>><%= category.getName() %>
                                    </option>
                                    <% } %>
                                </select>
                                <input type="hidden" id="productCategoryName" name="productCategoryName"
                                       value="<%= product.getCategory().getName() %>">

                                <script>
                                    function updateCategoryName(selectElement) {
                                        var selectedOption = selectElement.options[selectElement.selectedIndex];
                                        var categoryName = selectedOption.getAttribute('data-name');
                                        document.getElementById('productCategoryName').value = categoryName;
                                    }
                                </script>
                                <select class="form-select" name="productBrand" disabled>
                                    <%
                                        Set<Brand> brands = (Set<Brand>) request.getAttribute("brands");
                                        for (Brand brand : brands) {
                                            String selected = brand.getId() == product.getBrand().getId() ? "selected" : "";
                                    %>
                                    <option value="<%= brand.getId() %>" <%= selected %>><%= brand.getName() %>
                                    </option>
                                    <% } %>
                                </select>
                                <h4 class="d-flex align-items-center"><span style="font-size: large;" class="text-warning me-2">$ <span
                                        style="color: black; --falcon-text-opacity: 0; font-size: large;font-weight: 100;">Sale price</span> <input
                                        style="width: 50%; border-width: 0;"
                                        type="text" name="productPrice" value="<%=product.getPrice()%>" disabled></span><span
                                        class="me-1 fs--1 text-500">
                                 <del class="me-1"></del><strong></strong></span></h4>
                                <h4 class="d-flex align-items-center"><span style="font-size: large;" class="text-warning me-2">$ <span
                                        style="color: black; --falcon-text-opacity: 0; font-size: large;font-weight: 100;">Import price</span> <input
                                        style="width: 50%; border-width: 0;"
                                        type="text" name="productImportPrice" value="<%=product.getImportPrice()%>" disabled></span><span
                                        class="me-1 fs--1 text-500">
                                 <del class="me-1"></del><strong></strong></span></h4>
                                <p class="fs--1 mb-1"><i class="fas fa-sort-amount-up"></i>
                                    <span>Quantity: </span><strong><input type="text" name="productQuantitys"
                                                                          value="<%=product.getSockQuantity()%>"
                                                                          disabled></strong></p>
                                <input type="text" name="productQuantity"
                                       value="<%=product.getSockQuantity()%>"
                                       disabled hidden>
                                <p class="fs--1 mb-1"><i class="fas fa-shopping-cart"></i>
                                    <span>Sold: </span><strong><%=product.getNumberSold()%>
                                    </strong></p>
                                <p class="fs--1 mb-1"><i class="fas fa-calendar-alt"></i>
                                    <span>Created at: </span><strong><%=product.getCreatedDate()%>
                                    </strong></p>
                                <% if (product != null && product.getUpdatedDate() != null) { %>
                                <p class="fs--1 mb-1"><i class="fas fa-calendar-check"></i>
                                    <span>Updated at: </span><strong><%=product.getUpdatedDate()%>
                                    </strong></p>
                                <% } %>
                                <p class="fs--1">
                                    <i class="fas fa-info-circle"></i> Status:
                                    <strong class="text-success">
                                        <select name="productStatus" disabled>
                                            <option value="Available" <%= product.getStatus().equals("Available") ? "selected" : "" %>>
                                                Available
                                            </option>
                                            <option value="Unavailable" <%= product.getStatus().equals("Unavailable") ? "selected" : "" %>>
                                                Unavailable
                                            </option>
                                            <option value="Coming soon" <%= product.getStatus().equals("Coming soon") ? "selected" : "" %>>
                                                Coming soon
                                            </option>
                                        </select>
                                    </strong>
                                </p>
                            </div>
                            <input type="hidden" name="productId" value="<%=product.getId()%>">
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="overflow-hidden mt-4">
                                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                                        <li class="nav-item"><a class="nav-link active ps-0" id="description-tab"
                                                                data-bs-toggle="tab" href="#tab-description" role="tab"
                                                                aria-controls="tab-description" aria-selected="true">Description</a>
                                        </li>
                                        <li class="nav-item"><a class="nav-link px-2 px-md-3" id="specifications-tab"
                                                                data-bs-toggle="tab" href="#tab-specifications"
                                                                role="tab" aria-controls="tab-specifications"
                                                                aria-selected="false"></a></li>
                                        <li class="nav-item"><a class="nav-link px-2 px-md-3" id="reviews-tab"
                                                                data-bs-toggle="tab" href="#tab-reviews" role="tab"
                                                                aria-controls="tab-reviews" aria-selected="false"></a>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="myTabContent">
                                        <div class="tab-pane fade show active" id="tab-description" role="tabpanel"
                                             aria-labelledby="description-tab">
                                            <div class="mt-3">
                                                <textarea rows="4" cols="130" name="productDescription"
                                                          disabled><%=product.getDescription()%></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:if test="${acc.getRoleName() == 'Marketer'}">
                            <div class="col-auto px-2 px-md-3">
                                <button class="btn btn-sm btn-primary" id="editButton"
                                        onclick="editProduct(event)"><span
                                        class="fas fa-edit"></span><span class="d-none d-sm-inline-block">Edit</span>
                                </button>
                                <button class="btn btn-sm btn-success" id="saveButton" style="display: none;"><span
                                        class="fas fa-save"></span><span class="d-none d-sm-inline-block">Save</span>
                                </button>
                                <button class="btn btn-sm btn-danger" id="cancelButton" style="display: none;"
                                        onclick="cancelEdit(event)"><span class="fas fa-times"></span><span
                                        class="d-none d-sm-inline-block">Cancel</span></button>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>


            <script>
                function editProduct(event) {
                    event.preventDefault();

                    var form = document.getElementById('productForm');
                    var inputs = form.getElementsByTagName('input');
                    var selects = form.getElementsByTagName('select');
                    var textareas = form.getElementsByTagName('textarea');

                    for (var i = 0; i < inputs.length; i++) {
                        if (inputs[i].name !== 'productSold' && inputs[i].name !== 'productCreatedAt' && inputs[i].name !== 'productUpdatedAt' && inputs[i].name !== 'productQuantitys' && inputs[i].name !== 'productImportPrice') {
                            inputs[i].removeAttribute('disabled');
                        }
                    }

                    for (var i = 0; i < selects.length; i++) {
                        selects[i].removeAttribute('disabled');
                    }

                    for (var i = 0; i < textareas.length; i++) {
                        textareas[i].removeAttribute('disabled');
                    }

                    document.getElementById('productImage').style.display = 'block';
                    document.getElementById('editButton').style.display = 'none';
                    document.getElementById('saveButton').style.display = 'inline-block';
                    document.getElementById('cancelButton').style.display = 'inline-block';
                }

                function cancelEdit(event) {
                    event.preventDefault();

                    var form = document.getElementById('productForm');
                    var inputs = form.getElementsByTagName('input');
                    var selects = form.getElementsByTagName('select');
                    var textareas = form.getElementsByTagName('textarea');

                    for (var i = 0; i < inputs.length; i++) {
                        inputs[i].setAttribute('disabled', true);
                    }

                    for (var i = 0; i < selects.length; i++) {
                        selects[i].setAttribute('disabled', true);
                    }

                    for (var i = 0; i < textareas.length; i++) {
                        textareas[i].setAttribute('disabled', true);
                    }

                    document.getElementById('productImage').style.display = 'none';
                    document.getElementById('editButton').style.display = 'inline-block';
                    document.getElementById('saveButton').style.display = 'none';
                    document.getElementById('cancelButton').style.display = 'none';
                }

            </script>
        </div>
</main>
<!-- ===============================================-->
<!--    End of Main Content-->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    JavaScripts-->
<!-- ===============================================-->

<script src="Static_access_manager/vendors/bootstrap/bootstrap.min.js"></script>
<script src="Static_access_manager/vendors/anchorjs/anchor.min.js"></script>
<script src="Static_access_manager/vendors/is/is.min.js"></script>
<script src="Static_access_manager/vendors/swiper/swiper-bundle.min.js"></script>
<script src="Static_access_manager/vendors/rater-js/index.js"></script>
<script src="Static_access_manager/vendors/fontawesome/all.min.js"></script>
<script src="Static_access_manager/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="Static_access_manager/vendors/list.js/list.min.js"></script>
<script src="Static_access_manager/assets/js/theme.js"></script>

</body>

</html>