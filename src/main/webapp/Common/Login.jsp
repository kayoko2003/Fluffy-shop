<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Login</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap"
          rel="stylesheet">
    <link href="Static_access_manager/vendors/overlayscrollbars/OverlayScrollbars.min.css" rel="stylesheet">
    <link href="Static_access_manager/assets/css/theme-rtl.min.css" rel="stylesheet" id="style-rtl">
    <link href="Static_access_manager/assets/css/theme.min.css" rel="stylesheet" id="style-default">
    <link href="Static_access_manager/assets/css/user-rtl.min.css" rel="stylesheet" id="user-style-rtl">
    <link href="Static_access_manager/assets/css/user.min.css" rel="stylesheet" id="user-style-default">
</head>

<body>

<main class="main" id="top">
    <div class="container-fluid">
        <div class="row min-vh-100 flex-center g-0">
            <div class="col-lg-8 col-xxl-5 py-3 position-relative">
                <div class="card overflow-hidden z-index-1">
                    <div class="card-body p-0">
                        <div class="row g-0 h-100">
                            <div class="col-md-5 text-center bg-card-gradient">
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
                                    <p class="text-white">
                                        Don't have an account?<br><a
                                            class="text-decoration-underline link-light" href="signup">Get
                                        started!</a></p>
                                </div>

                            </div>
                            <div class="col-md-7 d-flex flex-center">
                                <div class="p-4 p-md-5 flex-grow-1">
                                    <div class="row flex-between-center">
                                        <div class="col-auto">
                                            <h3>Account Login</h3>
                                            <p class="text-danger">${mess1}</p>
                                        </div>
                                    </div>
                                    <form action="login" method="post">
                                        <div class="mb-3">
                                            <label class="form-label" for="card-email">Email</label>
                                            <input name="email" value="${email}" class="form-control" id="card-email"
                                                   type="email" autocomplete="on" placeholder="Email" required=""
                                                   autofocus=""/>
                                        </div>
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between">
                                                <label class="form-label" for="card-password">Password</label>
                                            </div>
                                            <input name="pass" value="${password}" class="form-control"
                                                   id="card-password" type="password" placeholder="Password"
                                                   required=""/>
                                        </div>
                                        <p class="text-danger">${mess}</p>
                                        <div class="row flex-between-center">
                                            <div class="col-auto">
                                                <div class="form-check mb-0">
                                                    <input class="form-check-input" type="checkbox" id="card-checkbox"
                                                           checked="checked"/>
                                                    <label class="form-check-label mb-0" for="card-checkbox">Remember
                                                        me</label>
                                                </div>
                                            </div>
                                            <div class="col-auto"><a class="fs--1" href="forgotpassword">Forgot
                                                Password?</a></div>
                                        </div>
                                        <div class="mb-3">
                                            <button class="btn btn-primary d-block w-100 mt-3" type="submit"
                                                    name="submit">Log in
                                            </button>
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
</body>

</html>