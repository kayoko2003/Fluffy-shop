<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Post List</title>

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
    <link href="Static_access_manager/assets/css/filterpost.css" rel="stylesheet">
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
            <%
                String sortByParam = (String) request.getAttribute("sortBy");
                String sortOrderParam = (String) request.getAttribute("sortOrder");
                String postCategory = request.getParameter("pcategory") != null ? request.getParameter("pcategory") : "-1";
                String staff = request.getParameter("staff") != null ? request.getParameter("staff") : "-1";
                String isShow = request.getParameter("isShow") != null ? request.getParameter("isShow") : "";
            %>
            <div class="card mb-3 mb-lg-0">
                <div class="card-header bg-light d-flex justify-content-between">
                    <h5 class="mb-0">Posts</h5>
                    <div>
                        <form class="d-flex" method="get" action="listpost">
                            <div class="col-auto"><small>Sort by: </small></div>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" name="sortBy" aria-label="Bulk actions"
                                        onchange="this.form.submit()">
                                    <option value="b.title" <%= sortByParam != null && sortByParam.equals("b.title") ? "selected" : "" %>>
                                        Title
                                    </option>
                                    <option value="bc.cname" <%= sortByParam != null && sortByParam.equals("bc.cname") ? "selected" : "" %>>
                                        Category
                                    </option>
                                    <option value="s.fullname" <%= sortByParam != null && sortByParam.equals("s.fullname") ? "selected" : "" %>>
                                        Author
                                    </option>
                                    <option value="b.isShow" <%= sortByParam != null && sortByParam.equals("b.isShow") ? "selected" : "" %>>
                                        Status
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
                            <input type="hidden" name="pcategory" value="<%= postCategory %>">
                            <input type="hidden" name="staff" value="<%= staff %>">
                            <input type="hidden" name="isShow" value="<%= isShow %>">
                        </form>
                    </div>
                    <div>
                        <a href="createanpost" class="btn btn-falcon-default btn-sm">
                            <span class="fas fa-plus" data-fa-transform="shrink-3 down-2"></span>
                            <span class="d-none d-sm-inline-block ms-1">New</span>
                        </a>
                        <form method="get" action="listpost" class="form-inline my-2 my-lg-0">
                            <!-- Button để mở cửa sổ lọc -->
                            <button type="button" class="btn btn-primary" onclick="toggleFilter()">Filter</button>

                            <!-- Cửa sổ lọc -->
                            <div id="filter-window"
                                 style="display: none; position: absolute; background-color: white; border: 1px solid #ccc; padding: 10px; z-index: 1000;">
                                <!-- Filter for Pcategory -->
                                <label for="filter-pcategory">Pcategory:</label>
                                <select id="filter-pcategory" name="pcategory" onchange="limitSelect(this)">
                                    <option value="">All</option>
                                    <c:forEach items="${listpost}" var="o">
                                        <option value="${o.pcategory.postCId}" ${pcategory == o.pcategory.postCId ? 'selected' : ''}>${o.pcategory.postCName}</option>
                                    </c:forEach>
                                </select><br><br>

                                <!-- Filter for Staff -->
                                <label for="filter-staff">Staff:</label>
                                <select id="filter-staff" name="staff" onchange="limitSelect(this)">
                                    <option value="">All</option>
                                    <c:forEach items="${listpost}" var="o">
                                        <option value="${o.staff.staffID}" ${staff == o.staff.staffID ? 'selected' : ''}>${o.staff.fullname}</option>
                                    </c:forEach>
                                </select><br><br>

                                <!-- Filter for isShow -->
                                <label for="filter-isShow">isShow:</label>
                                <select id="filter-isShow" name="isShow" onchange="limitSelect(this)">
                                    <option value="">All</option>
                                    <option value="true" ${isShow == 'true' ? 'selected' : ''}>Show</option>
                                    <option value="false" ${isShow == 'false' ? 'selected' : ''}>Hide</option>
                                </select><br><br>

                                <!-- Nút Apply để gửi form -->
                                <button class="btn btn-primary" type="submit">Apply</button>
                                <!-- Nút Close để đóng cửa sổ lọc -->
                                <button class="btn btn-secondary" type="button" onclick="toggleFilter()">Close</button>
                            </div>
                        </form>

                    </div>
                </div>
                <div class="card-body fs--1">
                    <div class="row">
                        <c:forEach items="${listpost}" var="o">
                            <div class="col-md-12 h-100">
                                <div class="d-flex btn-reveal-trigger">
                                    <div class="blog-id"
                                         style="border: 1px solid white; padding: 4px 8px; border-radius: 4px;">
                                        ID: ${o.postId}</div>
                                    <div class="calendar"><img src="${o.thumbnail}" alt="Thumbnail" class="img-fluid">
                                    </div>
                                    <div class="flex-1 position-relative ps-3">
                                        <h6 class="fs-0 mb-0">
                                            <a href="listpost?action=view&postId=${o.postId}">${o.title}</a>
                                            <a href="listpost?action=view&postId=${o.postId}"
                                               class="btn btn-secondary btn-sm">View</a>
                                            <a href="editpost?postId=${o.postId}"
                                               class="btn btn-secondary btn-sm">Edit</a>
                                            <a href="listpost?action=toggle&postId=${o.postId}"
                                               class="btn btn-secondary btn-sm">
                                                <c:choose>
                                                    <c:when test="${o.show}">Hide</c:when>
                                                    <c:otherwise>Show</c:otherwise>
                                                </c:choose>
                                            </a>
                                        </h6>
                                        <p class="mb-1" class="text-700">Author: ${o.staff.fullname}</p>
                                        <p class="text-1000 mb-0">Category: ${o.pcategory.postCName}</p>
                                        <p class="text-1000 mb-0">${o.shortDetail}</p>
                                        <div class="border-dashed-bottom my-3"></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <%
                int currentPage = (int) request.getAttribute("currentPage");
                int totalPages = (int) request.getAttribute("totalPages");
                String postCategory1 = request.getParameter("pcategory") != null ? request.getParameter("pcategory") : "-1";
                String staff1 = request.getParameter("staff") != null ? request.getParameter("staff") : "-1";
                String isShow1 = request.getParameter("isShow") != null ? request.getParameter("isShow") : "";
            %>
            <div class="card-footer border-top d-flex justify-content-center">
                <% if (currentPage > 1) { %>
                <a class="btn btn-falcon-default btn-sm me-2"
                   href="listpost?currentPage=<%= currentPage - 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&pcategory=<%= postCategory1 %>&staff=<%= staff1 %>&isShow=<%= isShow1 %>"><span
                        class="fas fa-chevron-left"></span></a>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                <% if (i == currentPage) { %>
                <a class="btn btn-sm btn-falcon-default text-primary me-2"
                   href="listpost?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&pcategory=<%= postCategory1 %>&staff=<%= staff1 %>&isShow=<%= isShow1 %>"><%= i %>
                </a>
                <% } else if (i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) { %>
                <a class="btn btn-sm btn-falcon-default me-2"
                   href="listpost?currentPage=<%= i %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&pcategory=<%= postCategory1 %>&staff=<%= staff1 %>&isShow=<%= isShow1 %>"><%= i %>
                </a>
                <% } else if (i == currentPage - 3 || i == currentPage + 3) { %>
                <a class="btn btn-sm btn-falcon-default me-2" href="#!"><span class="fas fa-ellipsis-h"></span></a>
                <% } %>
                <% } %>
                <% if (currentPage < totalPages) { %>
                <a class="btn btn-falcon-default btn-sm"
                   href="listpost?currentPage=<%= currentPage + 1 %>&sortBy=<%= sortByParam %>&sortOrder=<%= sortOrderParam %>&pcategory=<%= postCategory1 %>&staff=<%= staff1 %>&isShow=<%= isShow1 %>"><span
                        class="fas fa-chevron-right"></span></a>
                <% } %>
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
<script src="Static_access_manager/vendors/fontawesome/all.min.js"></script>
<script src="Static_access_manager/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="Static_access_manager/vendors/list.js/list.min.js"></script>
<script src="Static_access_manager/assets/js/theme.js"></script>
<script>
    // Function để hiển thị hoặc ẩn cửa sổ lọc
    function toggleFilter() {
        var filterWindow = document.getElementById("filter-window");
        if (filterWindow.style.display === "none" || filterWindow.style.display === "") {
            filterWindow.style.display = "block";
        } else {
            filterWindow.style.display = "none";
        }
    }

    // Function để chỉ cho phép chọn một trong ba select
    function limitSelect(element) {
        var selects = document.querySelectorAll("select[name='pcategory'], select[name='staff'], select[name='isShow']");
        selects.forEach(function (select) {
            if (select !== element) {
                select.value = ""; // Reset giá trị của select khác
            }
        });
    }
</script>
</body>

</html>
