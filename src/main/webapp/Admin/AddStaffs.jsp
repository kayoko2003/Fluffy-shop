<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Add staff</title>

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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 20px;
        }

        .mt-4 {
            margin-top: 20px;
        }

        h2 {
            color: #007bff;
        }

        .form-control {
            width: 100%;
        }

        #orderTrendChart {
            margin-top: 20px;
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

            <div class="card mb-3">
                <div class="card-body" style="display: grid; place-items: center;">
                    <div class="col-md-7 flex-center">
                        <div class="flex-grow-1">
                            <div class="text-center mb-3">
                                <h3 style="color: red">${mess}</h3>
                            </div>
                            <h3>Add Staff</h3>
                            <form method="post" id="addStaffForm">
                                <div class="mb-3">
                                    <label class="form-label" for="card-email">Email</label>
                                    <input name="email" class="form-control" type="email" autocomplete="on"
                                           id="card-email" required=""/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="full-name">Full Name</label>
                                    <input name="fullname" class="form-control" type="text" autocomplete="on"
                                           id="full-name" required=""/>
                                </div>
                                <div class="mb-3 col-sm-6">
                                    <label>Gender</label>
                                    <div class="gender">
                                        <div class="mb-3">
                                            <label for="male">
                                                <input type="radio" id="male" name="gender" value="male" checked
                                                       required> Male
                                            </label>
                                            <label for="female">
                                                <input type="radio" id="female" name="gender" value="female" required>
                                                Female
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3 col-sm-6">
                                    <label>Role:</label>
                                    <select name="role">
                                        <c:forEach items="${listRole}" var="l">
                                            <option value="${l.rName}">
                                                    ${l.rName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="phone-number">Phone Number</label>
                                    <input name="phone" class="form-control" type="tel" autocomplete="on"
                                           id="phone-number" required=""/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="address">Address</label>
                                    <input name="address" class="form-control" type="text" autocomplete="on"
                                           id="address" required/>
                                </div>
                                <%--                                <div class="row gx-2">--%>
                                <%--                                    <div class="mb-3 col-sm-6">--%>
                                <%--                                        <label class="form-label">New Password</label>--%>
                                <%--                                        <div class="input-group">--%>
                                <%--                                            <input class="form-control" type="password" name="newpassword"--%>
                                <%--                                                   id="newpassword" required/>--%>
                                <%--                                            <button type="button" class="btn btn-outline-secondary"--%>
                                <%--                                                    onclick="togglePasswordVisibility('newpassword')">--%>
                                <%--                                                <i class="fa fa-eye"></i>--%>
                                <%--                                            </button>--%>
                                <%--                                        </div>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="mb-3 col-sm-6">--%>
                                <%--                                        <label class="form-label">Confirm Password</label>--%>
                                <%--                                        <div class="input-group">--%>
                                <%--                                            <input class="form-control" type="password" name="confirmpassword"--%>
                                <%--                                                   id="confirmpassword" required/>--%>
                                <%--                                            <button type="button" class="btn btn-outline-secondary"--%>
                                <%--                                                    onclick="togglePasswordVisibility('confirmpassword')">--%>
                                <%--                                                <i class="fa fa-eye"></i>--%>
                                <%--                                            </button>--%>
                                <%--                                        </div>--%>
                                <%--                                        <div class="error-message" style="display: none" id="error-message">Passwords do--%>
                                <%--                                            not match.--%>
                                <%--                                        </div>--%>
                                <%--                                    </div>--%>
                                <%--                                </div>--%>
                                <div class="mb-3">
                                    <button class="btn btn-primary d-block w-100 mt-3" type="submit" id="submitBtn">
                                        Register
                                    </button>
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
    // function togglePasswordVisibility(inputId) {
    //     var input = document.getElementById(inputId);
    //     var icon = input.nextElementSibling.firstChild;
    //     if (input.type === "password") {
    //         input.type = "text";
    //         icon.classList.remove("fa-eye");
    //         icon.classList.add("fa-eye-slash");
    //     } else {
    //         input.type = "password";
    //         icon.classList.remove("fa-eye-slash");
    //         icon.classList.add("fa-eye");
    //     }
    // }

    // document.getElementById('addStaffForm').addEventListener('input', function () {
    //     const password = document.getElementById('newpassword').value;
    //     const confirmPassword = document.getElementById('confirmpassword').value;
    //     const errorMessage = document.getElementById('error-message');
    //     const submitBtn = document.getElementById('submitBtn');
    //
    //     if (confirmPassword === "") {
    //         errorMessage.style.display = 'none';
    //         submitBtn.disabled = true;
    //     } else if (password === confirmPassword) {
    //         errorMessage.style.display = 'none';
    //         submitBtn.disabled = false;
    //     } else {
    //         errorMessage.style.display = 'block';
    //         submitBtn.disabled = true;
    //     }
    // });
</script>
</body>


</html>