<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>List Slider</title>

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
    <style>
        .pagination .page-item.previous, .pagination .page-item.next {
            min-width: 80px;
            text-align: center;
        }
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

        .no-data-available {
            text-align: center;
            padding: 20px;
            font-size: 3em;
            color: #555;
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
        <jsp:include page="../SidebarManager.jsp"/>
        <div class="content">
            <nav class="navbar navbar-light navbar-glass navbar-top navbar-expand">
                <ul class="navbar-nav align-items-center d-none d-lg-block">
                    <li class="nav-item">
                        <div class="search-box" data-list='{"valueNames":["title"]}'>
                            <form method="get" action="listslider" class="form-inline my-2 my-lg-0">
                                <input class="form-control mr-sm-2" type="search" placeholder="Search sliders" aria-label="Search" name="txt" value="${param.txt}">
                            </form>
                        </div>
                    </li>
                </ul>
                <ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
                    <li class="nav-item dropdown"><a class="nav-link pe-0" id="navbarDropdownUser" href="#"
                                                     role="button" data-bs-toggle="dropdown" aria-haspopup="true"
                                                     aria-expanded="false">
                        <div class="avatar avatar-xl">
                            <img class="rounded-circle" src="${acc.avatar}" alt=""/>
                        </div>
                    </a>
                        <div class="dropdown-menu dropdown-menu-end py-0" aria-labelledby="navbarDropdownUser">
                            <a class="dropdown-item" href="pages/user/profile.html">Profile</a>
                            <a class="dropdown-item" href="pages/authentication/card/logout.html">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>

            <div class="card mb-3" id="customersTable"
                 data-list='{"valueNames":["id","name","gender","email","phone","role","status"],"page":10,"pagination":true}'>
                <div class="card-header">
                    <div class="row flex-between-center">
                        <div class="col-4 col-sm-auto d-flex align-items-center pe-0">
                            <h5 class="fs-0 mb-0 text-nowrap py-2 py-xl-0">Slider</h5>
                        </div>
                        <div class="col-8 col-sm-auto text-end ps-8">
                            <form method="get" action="listslider" class="form-inline my-2 my-lg-0">
                                <div style="display: flex; align-items: center;">
                                    <select class="form-control mr-2" name="status">
                                        <option value="" ${param.status == null ? 'selected' : ''}>All</option>
                                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                    <button class="btn btn-outline-success" type="submit">Filter</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <c:if test="${listsliders != null}">
                        <div class="table-responsive">
                            <table class="table table-sm table-striped fs--1 mb-0 overflow-hidden">
                                <thead class="bg-200 text-900">
                                <tr>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="id">ID</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="name">Title</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="image">Image</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="backlink">Backlink</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="status">Status</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="note">Note</th>
                                    <th class="align-middle no-sort"></th>
                                </tr>
                                </thead>
                                <tbody class="list" id="table-customers-body">
                                <c:forEach var="slider" items="${listsliders}">
                                    <tr>
                                        <td>${slider.id}</td>
                                        <td>${slider.title}</td>
                                        <td><img src="${slider.image}" alt="${slider.title}" style="width: 300px; height: auto;"></td>
                                        <td><a href="${slider.backlink}" target="_blank">${slider.backlink}</a></td>
                                        <td>${slider.status ? 'Active' : 'Inactive'}</td>
                                        <td>${slider.note}</td>
                                        <td>
                                            <a href="listslider?action=view&id=${slider.id}" class="btn btn-info btn-sm">View</a>
                                            <a href="listslider?action=edit&id=${slider.id}" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="listslider?action=toggle&id=${slider.id}" class="btn btn-secondary btn-sm">
                                                <c:choose>
                                                    <c:when test="${slider.status}">Hide</c:when>
                                                    <c:otherwise>Show</c:otherwise>
                                                </c:choose>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${listsliders == null}">
                        <div class="no-data-available">
                            <label style="font-size: xx-large;">No data available</label>
                        </div>
                    </c:if>
                </div>
                <div class="d-flex justify-content-center">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li class="page-item previous ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="listslider?currentPage=${currentPage - 1}&itemsPerPage=${itemsPerPage}&txt=${param.txt}&status=${param.status}">Previous</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="listslider?currentPage=${i}&itemsPerPage=${itemsPerPage}&txt=${param.txt}&status=${param.status}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item next ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="listslider?currentPage=${currentPage + 1}&itemsPerPage=${itemsPerPage}&txt=${param.txt}&status=${param.status}">Next</a>
                            </li>
                        </ul>
                    </nav>
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