<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Staff detail</title>

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
                            <img class="rounded-circle" src="${staff.avatar}" alt=""/>
                        </div>
                    </a>
                        <div class="dropdown-menu dropdown-menu-end py-0" aria-labelledby="navbarDropdownUser">
                            <a class="dropdown-item" href="pages/user/profile.html">Profile</a>
                            <a class="dropdown-item" href="logout">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>
            <div class="row">
                <div class="col-12">
                    <div class="card mb-3 btn-reveal-trigger">
                        <div class="card-header position-relative mb-8" style="min-height: 15vh">
                            <div class="d-flex justify-content-center align-items-center">
                                <div class="avatar avatar-5xl avatar-profile shadow-sm img-thumbnail rounded-circle">
                                    <div class="h-100 w-100 rounded-circle overflow-hidden position-relative"><img
                                            src="${staff.avatar}" width="200" alt=""
                                            data-dz-thumbnail="data-dz-thumbnail"/>
                                        <input class="d-none" id="profile-image" type="file"/>
                                        <label class="mb-0 overlay-icon d-flex flex-center" for="profile-image"><span
                                                class="bg-holder overlay overlay-0"></span><span
                                                class="z-index-1 text-white dark__text-white text-center fs--1"><span
                                                class="fas fa-camera"></span><span class="d-block">Update</span></span></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-header">
                    <h5 class="mb-0">Profile ID: ${staff.staffID}</h5>
                </div>
                <div class="card-body bg-light">
                    <form action="staffprofile" method="post" class="row g-3">
                        <div class="col-lg-10">
                            <label class="form-label" for="first-name">Full Name</label>
                            <input name="fullname" class="form-control" id="first-name" type="text" value="${staff.fullname}" readonly/>
                        </div>
                        <div class="col-lg-2">
                            <label class="form-label" for="first-name">Gender</label>
                            <input class="form-control" id="gender" type="text"
                                   value="${staff.gender == "true" ? "Male" : "Female"}" readonly/>
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label" for="email1">Email</label>
                            <input class="form-control" id="email1" type="text" value="${staff.email}" readonly/>
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label" for="email2">Phone</label>
                            <input name="phone" class="form-control" id="email2" type="text" value="${staff.phone_number}" readonly/>
                        </div>
                        <div class="col-lg-12">
                            <label class="form-label" for="email2">Address</label>
                            <input name="address" class="form-control" id="address" type="text" value="${staff.address}" readonly/>
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label" for="email2">Role: ${staff.roleName}</label>
                        </div>
                        <div class="col-lg-6">
                            <label class="form-label" for="email2">Status</label>
                            <label for="male">
                                <input disabled type="radio" id="male" name="status" value="activate"
                                       <c:if test="${staff.status == true}">checked</c:if>> Activate
                            </label>
                            <label for="female">
                                <input disabled type="radio" id="female" name="status" value="deactivate"
                                       <c:if test="${staff.status == false}">checked</c:if>> Deactivate
                            </label>
                        </div>
                        <div class="col-12 d-flex justify-content-end">
                            <button class="btn btn-primary" type="button" id="edit-button">Edit</button>
                            <button class="btn btn-primary d-none" type="submit" id="update-button">Update</button>
                        </div>
                    </form>
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
    document.addEventListener("DOMContentLoaded", function () {
        const editButton = document.getElementById("edit-button");
        const updateButton = document.getElementById("update-button");
        const phoneInput = document.getElementById("email2");
        const addressInput = document.getElementById("address");

        editButton.addEventListener("click", function () {
            phoneInput.removeAttribute("readonly");
            addressInput.removeAttribute("readonly");
            updateButton.classList.remove("d-none");
            editButton.classList.add("d-none");
        });
    });
</script>
</body>

</html>
