<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Change password</title>

        <link rel="shortcut icon" type="image/x-icon" href="Static_access_manager/assets/img/icons/spot-illustrations/logo_fluffy.png">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
        <link href="Static_access_manager/assets/css/theme-rtl.min.css" rel="stylesheet" id="style-rtl">
        <link href="Static_access_manager/assets/css/theme.min.css" rel="stylesheet" id="style-default">
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
                                            <img src="Static_access_manager/assets/img/logos/logo_fluffy.png" width="60%">
                                        </div>
                                        <div class="d-flex justify-content-start mt-3">
                                            <a href="login" class="btn btn-secondary " style="margin-left: 20px;  background-color: blue;color: white; border: none;">Back</a>
                                        </div>
                                    </div>
                                    <div class="col-md-7 d-flex flex-center">
                                        <div class="p-4 p-md-5 flex-grow-1">
                                            <div class="text-center mb-3">
                                                <a style="color: red">${message}</a>
                                            </div>
                                            ${password}
                                            <h3>Change Password</h3>
                                            <form method="post" class="mt-3" id="passwordForm">
                                                <div class="mb-3">
                                                    <label class="form-label">Old Password</label>
                                                    <div class="input-group">
                                                        <input class="form-control" type="password" name="oldpassword" id="oldpassword" required/>
                                                        <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordVisibility('oldpassword')">
                                                            <i class="fa fa-eye"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">New Password</label>
                                                    <div class="input-group">
                                                        <input class="form-control" type="password" name="newpassword" id="newpassword" required/>
                                                        <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordVisibility('newpassword')">
                                                            <i class="fa fa-eye"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Confirm Password</label>
                                                    <div class="input-group">
                                                        <input class="form-control" type="password" name="confirmpassword" id="confirmpassword" required/>
                                                        <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordVisibility('confirmpassword')">
                                                            <i class="fa fa-eye"></i>
                                                        </button>
                                                    </div>
                                                    <div class="error-message" style="display: none" id="error-message">Passwords do not match.</div>
                                                </div>
                                                <button class="btn btn-primary d-block w-100 mt-3" type="submit" id="submitBtn" disabled>Set password</button>
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

    <script>
        function togglePasswordVisibility(inputId) {
            var input = document.getElementById(inputId);
            var icon = input.nextElementSibling.firstChild;
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }

        document.getElementById('passwordForm').addEventListener('input', function () {
            const oldPassword = document.getElementById('oldpassword').value;
            const newPassword = document.getElementById('newpassword').value;
            const confirmPassword = document.getElementById('confirmpassword').value;
            const errorMessage = document.getElementById('error-message');
            const submitBtn = document.getElementById('submitBtn');

            if (confirmPassword === "" || oldPassword === "") {
                errorMessage.style.display = 'none';
                submitBtn.disabled = true;
            } else if (newPassword === confirmPassword) {
                errorMessage.style.display = 'none';
                submitBtn.disabled = false;
            } else {
                errorMessage.style.display = 'block';
                submitBtn.disabled = true;
            }
        });
    </script>
</html>