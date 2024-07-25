<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>Create post</title>

    <link rel="apple-touch-icon" sizes="180x180" href="Static_access_manager/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="Static_access_manager/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="Static_access_manager/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="Static_access_manager/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="Static_access_manager/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="Static_access_manager/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">
    <script src="Static_access_manager/assets/js/config.js"></script>
    <script src="Static_access_manager/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>
    <script src="ckeditor/ckeditor.js"></script>
    <script src="ckfinder/ckfinder.js"></script>



    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
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

            <div class="card mb-3">
                <div class="card-body">
                    <div class="row flex-between-center">
                        <div class="col-md">
                            <h5 class="mb-2 mb-md-0">Create Post</h5>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card cover-image mb-3"><img class="card-img-top" src="/assets/img/generic/13.jpg" alt="" />
                <input class="d-none" id="upload-cover-image" type="file" />
                <label class="cover-image-file-input" for="upload-cover-image"><span class="fas fa-camera me-2"></span><span>Change cover photo</span></label>
            </div>
            <div class="row g-0">
                <div class="col-lg-12 pe-lg-2">
                    <div class="card mb-3">
                        <div class="card-header">
                            <h5 class="mb-0">Post Details</h5>
                        </div>
                        <div class="card-body bg-light">

                            <form action="createanpost" method="post">
                                <div class="row gx-2">
                                    <div class="col-12 mb-3">
                                        <label class="form-label" for="event-Thumbnail">Thumbnail:</label>
                                        <input name="thumbnail" class="form-control" id="event-Thumbnail" type="text" placeholder="Thumbnail" />
                                    </div>

                                    <div class="col-12 mb-3">
                                        <label class="form-label" for="event-name">Post Title:</label>
                                        <input name="title" class="form-control" id="event-name" type="text" placeholder="Post Title" />
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label" for="event-shortdetail">Blog Detail Short:</label>
                                        <input name="short_detail" class="form-control" id="event-shortdetail" type="text" placeholder="Detail Short" />
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label">Blog Detail:</label>
                                        <textarea name="detail" class="form-control" id="editor" rows="6"></textarea>
                                    </div>

                                    <div class="col-sm-6 mb-3">
                                        <label class="form-label">Creator ID:</label>
                                        <select name="adminID" class="form-select">
                                            <c:forEach items="${listA}" var="o">
                                                <option value="${o.staffID}">${o.fullname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-sm-6 mb-3">
                                        <label class="form-label" for="time-zone">Blog Category ID:</label>
                                        <select name="categoryB" class="form-select" id="time-zone">
                                            <c:forEach items="${listCateB}" var="o">
                                                <option value="${o.postCId}">${o.postCName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-12 mb-3">
                                        <label class="form-label">Show Post:</label>
                                        <input value="true" name="isShow" type="radio" class="form-check-input" required> Yes
                                        <input value="false" name="isShow" type="radio" class="form-check-input" required> No
                                    </div>

                                    <!-- Hidden input for create_date -->
                                    <div class="col-12">
                                        <input name="create_date" id="create_date" type="hidden" value="" />
                                    </div>

                                    <!-- Hidden input for update_date -->
                                    <div class="col-12">
                                        <input name="update_date" id="update_date" type="hidden" value="" />
                                    </div>

                                    <div class="mb-3">
                                        <button class="btn btn-primary d-block w-100 mt-3" type="submit" name="submit">Save</button>
                                    </div>
                                </div>
                            </form>


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


<script>
    CKEDITOR.replace('editor');
</script>

<%--<script>--%>
<%--    CKEDITOR.replace('editor', {--%>
<%--        filebrowserBrowseUrl: '/ckfinder/ckfinder.html',--%>
<%--        filebrowserUploadUrl: '/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files'--%>
<%--    });--%>
<%--</script>--%>

<%--<script>--%>
<%--    var ckeditor = CKEDITOR.replace('editor');--%>
<%--    CKFinder.setupCKEditor(ckeditor, '/ckfinder/');--%>
<%--</script>--%>
<script>
    document.addEventListener('DOMContentLoaded', (event) => {
        let currentDate = new Date();
        let formattedDate = currentDate.toISOString().slice(0, 10); // Format as YYYY-MM-DD
        document.getElementById('create_date').value = formattedDate;
        document.getElementById('update_date').value = formattedDate;
    });
</script>

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