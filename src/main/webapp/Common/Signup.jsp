<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Signup</title>

    <!-- Favicons -->
    <link rel="apple-touch-icon" sizes="180x180" href="Static_access_manager/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="Static_access_manager/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="Static_access_manager/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="Static_access_manager/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="Static_access_manager/assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="Static_access_manager/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <script src="Static_access_manager/assets/js/config.js"></script>
    <script src="Static_access_manager/vendors/overlayscrollbars/OverlayScrollbars.min.js"></script>

    <!-- Stylesheets -->
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

<!-- Main Content -->
<main class="main" id="top">
    <div class="container-fluid">
        <div class="row min-vh-100 flex-center g-0">
            <div class="col-lg-8 col-xxl-5 py-3 position-relative">
                <div class="card overflow-hidden z-index-1">
                    <div class="card-body p-0">
                        <div class="row g-0 h-100">
                            <div class="col-md-5 text-center bg-card-gradient" style="align-content: center">
                                <div class="position-relative p-4 light">
                                    <div class="z-index-1 position-relative">
                                        <a class="link-light mt-2 font-sans-serif fs-6 d-inline-block fw-bolder">fluffy</a>
                                    </div>
                                </div>
                                <div>
                                    <img src="${pageContext.request.contextPath}/Static_acess_shop/img/logo_fluffy.png"
                                         width="60%"
                                    >
                                </div>
                                <div class="mt-3 mb-4 mt-md-4 mb-md-5 light">
                                    <p class="pt-3 text-white">Have an account?<br>
                                        <a class="btn btn-outline-light mt-2 px-4" href="login">Log In</a>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-7 d-flex flex-center">
                                <div class="p-4 p-md-5 flex-grow-1">
                                    <h3>Register</h3>
                                    <p class="text-danger">${mess}</p>
                                    <p class="text-danger">${mess1}</p>
                                    <form method="post">
                                        <div class="mb-3">
                                            <label class="form-label" for="card-email">Email</label>
                                            <input name="email" class="form-control" type="email" autocomplete="on" id="card-email" required=""/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="full-name">Full Name</label>
                                            <input name="fullname" class="form-control" type="text" autocomplete="on" id="full-name" required="" />
                                        </div>
                                        <div class="mb-3 col-sm-6">
                                            <label>Gender</label>
                                            <div class="gender">
                                                <div class="mb-3">
                                                    <label for="male">
                                                        <input type="radio" id="male" name="gender" value="male" required> Male
                                                    </label>
                                                    <label for="female">
                                                        <input type="radio" id="female" name="gender" value="female" required> Female
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-3 col-sm-6">
                                            <label for="dob">Date of Birth:</label>
                                            <input type="date" id="dob" name="dob" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="phone-number">Phone Number</label>
                                            <input name="phone" class="form-control" type="tel" autocomplete="on" id="phone-number" required=""/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="address">Address</label>
                                            <input name="address" class="form-control" type="text" autocomplete="on" id="address" required=""/>
                                        </div>
                                        <div class="row gx-2">
                                            <div class="mb-3 col-sm-6">
                                                <label class="form-label" for="card-password">Password</label>
                                                <input name="password" class="form-control" type="password" autocomplete="on" id="card-password" required=""/>
                                            </div>
                                            <div class="mb-3 col-sm-6">
                                                <label class="form-label" for="card-confirm-password">Confirm Password</label>
                                                <input name="repass" class="form-control" type="password" autocomplete="on" id="card-confirm-password" required=""/>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <button class="btn btn-primary d-block w-100 mt-3" type="submit" name="submit">Register</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- JavaScripts -->
<script src="Static_access_manager/vendors/popper/popper.min.js"></script>
<script src="Static_access_manager/vendors/bootstrap/bootstrap.min.js"></script>
<script src="Static_access_manager/vendors/anchorjs/anchor.min.js"></script>
<script src="Static_access_manager/vendors/is/is.min.js"></script>
<script src="Static_access_manager/vendors/fontawesome/all.min.js"></script>
<script src="Static_access_manager/vendors/lodash/lodash.min.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="Static_access_manager/vendors/list.js/list.min.js"></script>
<script src="Static_access_manager/assets/js/theme.js"></script>

</body>
</html>
