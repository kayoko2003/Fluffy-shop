<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>List Staff</title>

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
                            <img class="rounded-circle" src="${acc.avatar}" alt=""/>
                        </div>
                    </a>
                        <div class="dropdown-menu dropdown-menu-end py-0" aria-labelledby="navbarDropdownUser">
                            <a class="dropdown-item" href="pages/user/profile.html">Profile</a>
                            <a class="dropdown-item" href="logout">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>

            <div class="card mb-3" id="customersTable"
                 data-list='{"valueNames":["id","name","gender","email","phone","role","status"],"page":10,"pagination":true}'>
                <div class="card-header">
                    <div class="row flex-between-center">
                        <div class="col-4 col-sm-auto d-flex align-items-center pe-0">
                            <h5 class="fs-0 mb-0 text-nowrap py-2 py-xl-0">Staff</h5>
                        </div>
                        <div class="col-8 col-sm-auto text-end ps-2">
                            <div id="table-customers-replace-element">
                                <a href="addstaff" class="btn btn-falcon-default btn-sm">
                                    <span class="fas fa-plus" data-fa-transform="shrink-3 down-2"></span>
                                    <span class="d-none d-sm-inline-block ms-1">New</span>
                                </a>
                                <button class="btn btn-falcon-default btn-sm mx-2" type="button"
                                        onclick="toggleFilter()">
                                    <span class="fas fa-filter" data-fa-transform="shrink-3 down-2"></span>
                                    <span class="d-none d-sm-inline-block ms-1">Filter</span>
                                </button>
                            </div>

                            <!-- Filter window -->
                            <form action="filterstaff">
                                <div id="filter-window"
                                     style="display:none; position: absolute; background-color: white; border: 1px solid #ccc; padding: 10px; z-index: 1000;">
                                    <h5>Filter Options</h5>
                                    <label for="filter-gender">Gender:</label>
                                    <select id="filter-gender" name="gender">
                                        <option value="">Any</option>
                                        <option value="male" ${gender == 'male' ? 'selected' : ''}>Male</option>
                                        <option value="female" ${gender == 'female' ? 'selected' : ''}>Female</option>
                                    </select><br><br>
                                    <label for="filter-role">Role:</label>
                                    <select id="filter-role" name="role">
                                        <option value="">Any</option>
                                        <c:forEach items="${listRole}" var="l">
                                            <option value="${l.rID}" ${role == l.rID ? 'selected' : ''}>${l.rName}</option>
                                        </c:forEach>
                                    </select><br><br>
                                    <label for="filter-status">Status:</label>
                                    <select id="filter-status" name="status">
                                        <option value="">Any</option>
                                        <option value="activate" ${status == 'activate' ? 'selected' : ''}>Activate
                                        </option>
                                        <option value="deactivate" ${status == 'deactivate' ? 'selected' : ''}>
                                            Deactivate
                                        </option>
                                    </select><br><br>
                                    <button class="btn btn-primary" type="submit">Apply</button>
                                    <button class="btn btn-secondary" onclick="toggleFilter()">Close</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <c:if test="${listStaff != null}">
                        <div class="table-responsive">
                            <table class="table table-sm table-striped fs--1 mb-0 overflow-hidden">
                                <thead class="bg-200 text-900">
                                <tr>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="id">ID</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="name">Name</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="gender">Gender</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="email">Email</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="phone">Phone</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="role">Role</th>
                                    <th class="sort pe-1 align-middle white-space-nowrap" data-sort="status">Status</th>
                                    <th class="align-middle no-sort"></th>
                                </tr>
                                </thead>
                                <tbody class="list" id="table-customers-body">
                                <c:forEach items="${listStaff}" var="l">
                                    <tr class="btn-reveal-trigger">
                                        <td class="id align-middle white-space-nowrap py-2"><a>${l.staffID}</a></td>
                                        <td class="name align-middle white-space-nowrap py-2"><a
                                                href="staffdetail?sid=${l.staffID}">
                                            <div class="d-flex d-flex align-items-center">
                                                <div class="avatar avatar-xl me-2">
                                                    <img class="rounded-circle" src="" alt=""/>
                                                </div>
                                                <div class="flex-1">
                                                    <h5 class="mb-0 fs--1">${l.fullname}</h5>
                                                </div>
                                            </div>
                                        </a></td>
                                        <td class="gender align-middle py-2">${l.getGender()}</td>
                                        <td class="email align-middle py-2"><a href="">${l.email}</a></td>
                                        <td class="phone align-middle white-space-nowrap py-2"><a
                                                href="tel:${l.phone_number}"></a>${l.phone_number}</td>
                                        <td class="role align-middle py-2">${l.roleName}</td>
                                        <td class="status align-middle py-2">${l.getStatus()}</td>
                                        <td class="align-middle white-space-nowrap py-2 text-end">
                                            <div class="dropdown font-sans-serif position-static">
                                                <button class="btn btn-link text-600 btn-sm dropdown-toggle btn-reveal"
                                                        type="button" id="customer-dropdown-19"
                                                        data-bs-toggle="dropdown" data-boundary="window"
                                                        aria-haspopup="true" aria-expanded="false"><span
                                                        class="fas fa-ellipsis-h fs--1"></span></button>
                                                <div class="dropdown-menu dropdown-menu-end border py-0"
                                                     aria-labelledby="customer-dropdown-19">
                                                    <div class="bg-white py-2"><a class="dropdown-item"
                                                                                  href="staffdetail?sid=${l.staffID}">View</a><a
                                                            class="dropdown-item text-danger"
                                                            href="staffdetail?sid=${l.staffID}">Edit</a></div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${listStaff == null}">
                        <div class="no-data-available">
                            <label style="font-size: xx-large;">No data available</label>
                        </div>
                    </c:if>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-center">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="${baseUrl}?currentPage=${i}&txt=${txt}&gender=${gender}&status=${status}&role=${role}"
                           class="styled-button <c:if test='${i == currentPage}'>active</c:if>">
                                ${i}
                        </a>
                    </c:forEach>
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