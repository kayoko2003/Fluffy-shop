<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>Post Detail</title>


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
    <script src="Static_access_manager/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>


    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
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
                <button class="btn navbar-toggler-humburger-icon navbar-toggler me-1 me-sm-3" type="button"
                        data-bs-toggle="collapse" data-bs-target="#navbarVerticalCollapse"
                        aria-controls="navbarVerticalCollapse" aria-expanded="false" aria-label="Toggle Navigation">
                    <span class="navbar-toggle-icon"><span class="toggle-line"></span></span></button>
                <a class="navbar-brand me-1 me-sm-3" href="Static_access_manager/index.html">
                    <div class="d-flex align-items-center"><img class="me-2"
                                                                src="Static_access_manager/assets/img/icons/spot-illustrations/falcon.png"
                                                                alt="" width="40"/><span
                            class="font-sans-serif">falcon</span>
                    </div>
                </a>

                <ul class="navbar-nav align-items-center d-none d-lg-block">
                    <li class="nav-item">
                        <div class="search-box" data-list='{"valueNames":["title"]}'>
                            <form action="listpost" method="get" class="position-relative" data-bs-toggle="search"
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
            <div class="card mb-3"><img class="card-img-top" src="../../assets/img/generic/13.jpg" alt=""/>
                <div class="card-body">
                    <div class="row justify-content-between align-items-center">
                        <div class="col">
                            <div class="d-flex">
                                <div>
                                    <img src="${p.thumbnail}" alt="Thumbnail"
                                         style="width: 70px; height: 70px; padding-right:10px"/>
                                </div>


                                <div class="flex-1 fs--1">
                                    <h5 class="fs-0">${p.title}</h5>
                                    <p class="mb-0">${p.shortDetail}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-auto mt-4 mt-md-0">
                            <a class="btn btn-falcon-primary btn-sm px-4 px-sm-5" href="editpost?postId=${p.postId}"
                               role="button">Edit</a>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row g-0">
                <div class="col-lg-8 pe-lg-2">
                    <div class="card mb-3 mb-lg-0">
                        <div class="card-body">
                            <h5 class="fs-0 mb-3"></h5>
                            <p><strong>${p.title}</strong></p>

                            <p><em>${p.shortDetail}</em></p>

                            <p>${p.blogDetail }</p>


                        </div>
                    </div>
                </div>
                <div class="col-lg-4 ps-lg-2">
                    <div class="sticky-sidebar">

                        <div class="card mb-3 mb-lg-0">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">Post recent</h5>
                            </div>
                            <div class="card-body fs--1" style="padding: 10px">
                                <div class="d-flex flex-column">
                                    <c:forEach items="${listpc}" var="pc">
                                        <div class="d-flex mb-3">
                                            <div style="margin-right: 1rem;">
                                                <img src="${pc.thumbnail}" alt="Post Image"
                                                     style="width: 50px; height: auto;">
                                            </div>
                                            <div>
                                                <h6 class="fs-0 mb-0"><a
                                                        href="postdetail?postId=${pc.postId}">${pc.title}</a></h6>
                                                <p class="text-1000 mb-0">Date: ${pc.updateDate}</p>
                                                <p style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 200px;">${pc.shortDetail}</p>
                                                <div style="border-bottom: 1px dashed; margin: 1rem 0;"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="card-footer bg-light p-0 border-top">
                                <a class="btn btn-link d-block w-100" href="listpost">All Post
                                    <span class="fas fa-chevron-right ms-1 fs--2"></span>
                                </a>
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

<!-- ===============================================-->
<!--    JavaScripts-->
<!-- ===============================================-->
<script src="Static_access_manager/vendors/popper/popper.min.js"></script>
<script src="Static_access_manager/vendors/bootstrap/bootstrap.min.js"></script>
<script src="Static_access_manager/vendors/anchorjs/anchor.min.js"></script>
<script src="Static_access_manager/vendors/is/is.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyARdVcREeBK44lIWnv5-iPijKqvlSAVwbw&callback=initMap"
        async></script>
<script src="Static_access_manager/vendors/fontawesome/all.min.js"></script>
<script src="Static_access_manager/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="Static_access_manager/vendors/list.js/list.min.js"></script>
<script src="Static_access_manager/assets/js/theme.js"></script>

</body>

</html>