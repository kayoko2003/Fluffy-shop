<%@ page import="model.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Brand" %>
<%@ page import="java.util.Set" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Add Product</title>

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
                            <a class="dropdown-item" href="pages/user/profile.html">Profile &amp; account</a>
                            <a class="dropdown-item" href="logout">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row flex-between-center">


                        <form method="post" action="add-product" enctype="multipart/form-data">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-6 mb-4 mb-lg-0">
                                            <div class="product-slider" id="galleryTop">
                                                <div class="swiper-container theme-slider position-lg-absolute all-0">
                                                    <div class="swiper-wrapper h-100">
                                                        <div class="swiper-slide h-100">
                                                            <img id="productImagePreview"
                                                                 class="rounded-1 fit-cover h-100 w-100"
                                                                 src="Static_access_manager/assets/img/products/1.jpg"
                                                                 alt=""/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <input id="productImage" type="file" name="productImage" accept="image/*"
                                                   required>

                                            <script>
                                                document.getElementById('productImage').addEventListener('change', function (e) {
                                                    var file = e.target.files[0];
                                                    var url = URL.createObjectURL(file);
                                                    document.getElementById('productImagePreview').src = url;
                                                });
                                            </script>
                                        </div>
                                        <div class="col-lg-6">
                                            <input id="productName" type="text" class="fs-3" name="productName"
                                                   placeholder="Product Name" required>
                                            <select id="productCategory" class="form-select" name="productCategory"
                                                    required onchange="updateCategoryName(this)">
                                                <% Set<Category> categories = (Set<Category>) request.getAttribute("categories");
                                                    for (Category category : categories) { %>
                                                <option value="<%= category.getId() %>"
                                                        data-name="<%= category.getName() %>"><%= category.getName() %>
                                                </option>
                                                <% } %>
                                            </select>
                                            <input id="productCategoryName" type="hidden" name="productCategoryName">

                                            <script>
                                                function updateCategoryName(selectElement) {
                                                    var selectedOption = selectElement.options[selectElement.selectedIndex];
                                                    var categoryName = selectedOption.getAttribute('data-name');
                                                    document.getElementById('productCategoryName').value = categoryName;
                                                }
                                            </script>
                                            <select id="productBrand" class="form-select" name="productBrand" required>
                                                <% Set<Brand> brands = (Set<Brand>) request.getAttribute("brands");
                                                    for (Brand brand : brands) { %>
                                                <option value="<%= brand.getId() %>"><%= brand.getName() %>
                                                </option>
                                                <% } %>
                                            </select>
                                            <input id="productPrice" type="number" class="fs-3" name="productPrice"
                                                   placeholder="Product Price" value="0" hidden="">
                                            <br>
                                            <select id="productStatus" class="form-select" name="productStatus"
                                                    required>
                                                <option value="Available">Available</option>
                                                <option value="Unavailable">Unavailable</option>
                                                <option value="Coming soon">Coming soon</option>
                                            </select>
                                            <input id="productQuantity" class="form-control text-center" type="number"
                                                   name="productQuantity" min="0" value="0"
                                                   aria-label="Product Quantity" style="width: 100px" hidden/>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="overflow-hidden mt-4">
                                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                                    <li class="nav-item"><a class="nav-link active ps-0"
                                                                            id="description-tab" data-bs-toggle="tab"
                                                                            href="#tab-description" role="tab"
                                                                            aria-controls="tab-description"
                                                                            aria-selected="true">Description</a></li>
                                                </ul>
                                                <div class="tab-content" id="myTabContent">
                                                    <div class="tab-pane fade show active" id="tab-description"
                                                         role="tabpanel" aria-labelledby="description-tab">
                                                        <div class="mt-3">
                                                            <textarea id="productDescription"
                                                                      style="width: 800px; height: 200px"
                                                                      name="productDescription"
                                                                      placeholder="Product Description"
                                                                      required></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button id="addProduct" class="btn btn-primary" type="submit" name="submit">Submit</button>
                        </form>

                    </div>
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

</body>

</html>