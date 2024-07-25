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
    <title>Edit post</title>


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
    <script src="ckeditor/ckeditor.js"></script>
    <script src="ckfinder/ckfinder.js"></script>


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
                <ul class="navbar-nav align-items-center d-none d-lg-block">
                    <li class="nav-item">
                        <div class="search-box" data-list='{"valueNames":["title"]}'>
                            <form class="position-relative" action="FilterPostsServlet" method="GET">
                                <!-- Updated input for detailed title search -->
                                <input class="form-control search-input fuzzy-search" type="search" name="title"
                                       placeholder="Search by Title" aria-label="Search"/>
                                <button type="submit" class="fas fa-search search-box-icon"
                                        style="border:none; background:none;"></button>
                            </form>
                            <div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none"
                                 data-bs-dismiss="search">
                                <div class="btn-close-falcon" aria-label="Close"></div>
                            </div>
                            <div class="dropdown-menu border font-base start-0 mt-2 py-0 overflow-hidden w-100">
                                <div class="text-center mt-n3">
                                    <p class="fallback fw-bold fs-1 d-none">No Result Found.</p>
                                </div>
                            </div>
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
                            <a class="dropdown-item" href="pages/user/profile.html">Profile &amp; account</a>
                            <a class="dropdown-item" href="logout">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>

            <div class="card mb-3 mb-lg-0">
                <div class="card-header" style="padding-bottom: 0">
                    <h5 class="mb-0">Event Details</h5>
                </div>
                <div class="card-header bg-light d-flex justify-content-between" style="padding: 0">
                    <div class="card-body bg-light">
                        <form action="editpost" method="post">
                            <div class="form-group">
                                <input value="${p.postId}" name="id" type="hidden">
                            </div>
                            <div class="row gx-2">
                                <div class="col-12 mb-3">
                                    <label class="form-label" for="event-Thumbnail">Thumbnail:</label>
                                    <input name="thumbnail" value="${p.thumbnail}" class="form-control"
                                           id="event-Thumbnail" type="text" placeholder="Thumbnail"/>
                                </div>

                                <div class="col-12 mb-3">
                                    <label class="form-label" for="event-name">Post Title:</label>
                                    <input name="title" class="form-control" value="${p.title}" id="event-name"
                                           type="text" placeholder="Post Title"/>
                                </div>

                                <div class="col-12">
                                    <label class="form-label" for="event-shortdetail">Blog Detail Short:</label>
                                    <input name="short_detail" class="form-control" value="${p.shortDetail}"
                                           id="event-shortdetail" type="text" placeholder="Detail Short"/>
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Blog Detail:</label>
                                    <textarea name="detail" class="form-control" id="editor"
                                              rows="6">${p.blogDetail}</textarea>
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
                                        <c:forEach items="${listCB}" var="o">
                                            <option value="${o.postCId}">${o.postCName}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-12 mb-3">
                                    <label class="form-label">Show Post:</label>
                                    <input value="true" name="isShow" type="radio" class="form-check-input"
                                           required> Yes
                                    <input value="false" name="isShow" type="radio" class="form-check-input"
                                           required> No
                                </div>

                                <div class="col-12">
                                    <input name="create_date" type="hidden" value="${p.createDate}">
                                </div>

                                <div class="col-12 mb-3">
                                    <input name="update_date" id="update_date" type="hidden" value=""/>
                                </div>

                                <div class="mb-3">
                                    <button class="btn btn-primary d-block w-100 mt-3" type="submit" name="submit">
                                        Save
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>

<script>
    var ckeditor = CKEDITOR.replace('editor');
    CKFinder.setupCKEditor(ckeditor, '/ckfinder/');
</script>

<script>
    document.addEventListener('DOMContentLoaded', (event) => {
        let currentDate = new Date();
        let formattedDate = currentDate.toISOString().slice(0, 10); // Format as YYYY-MM-DD
        document.getElementById('update_date').value = formattedDate;
    });
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
<script src="assets/js/theme.js"></script>

</body>

</html>