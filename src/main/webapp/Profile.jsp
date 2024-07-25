<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ogani | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="Static_acess_shop/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/style.css" type="text/css">

</head>

<body>
<jsp:include page="Header.jsp" />
<%--<div class="container-fluid page-header py-5" style="background: #81C408">--%>
<%--    <h1 class="text-center text-white display-6">My Prile</h1>--%>
<%--    <ol class="breadcrumb justify-content-center mb-0">--%>
<%--        <li class="breadcrumb-item"><a href="#" style="color: white">Home</a></li>--%>
<%--        <li class="breadcrumb-item"><a href="#" style="color: white">My Profile</a></li>--%>
<%--    </ol>--%>
<%--</div>--%>

<% Customer customer = (Customer) request.getAttribute("customer"); %>

<!-- Checkout Page Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <%
            String editModeStr = (String) request.getAttribute("editMode");
            boolean editMode = false;
            if(editModeStr != null) {
                 editMode = Boolean.parseBoolean(editModeStr);
            } else {
                 editMode = false;
            }
            if (!editMode) {
        %>
        <form action="profile" method="get">
            <div class="row g-5">
                <div class="col-md-12 col-lg-6 col-xl-7">
                    <div class="row">
                        <div class="col-md-12 col-lg-6">
                            <div class="form-item w-100">
                                <label class="form-label my-3">Full Name</label>
                                <input type="text" class="form-control" value="<%= customer.getFullname() %>" readonly>

                                <label class="form-label my-3"></label>
                                <input type="radio" name="gender"
                                       value="Male" <%= customer.isGender() ? "checked" : "" %> disabled> Male
                                <input type="radio" name="gender"
                                       value="Female" <%= !customer.isGender() ? "checked" : "" %> disabled> Female
                            </div>

                            <div class="form-item w-100">
                                <label class="form-label my-3">Date of birth</label>
                                <input type="text" class="form-control" value="<%= customer.getDob() %>" readonly>
                            </div>
                        </div>

                    </div>
                    <div class="form-item">
                        <label class="form-label my-3">Email</label>
                        <input type="email" class="form-control" value="<%= customer.getEmail() %>" readonly>
                    </div>
                    <div class="form-item">
                        <label class="form-label my-3">Address</label>
                        <input type="text" class="form-control" value="<%= customer.getAddress() %>" readonly>
                    </div>
                    <div class="form-item">
                        <label class="form-label my-3">Phone number</label>
                        <input type="tel" class="form-control" value="<%= customer.getPhoneNumber() %>" readonly>
                    </div>


                </div>
                <div class="col-md-12 col-lg-6 col-xl-5">
                    <div class="table-responsive">
                        <img src="<%= (customer.getImg() != null && !customer.getImg().isEmpty()) ? customer.getImg() : "Static_acess_shop/img/user.png" %>"
                             alt="Avatar" class="img-fluid mx-auto d-block"></div>

                </div>
            </div>
            <br>
            <input type="hidden" name="editMode" value="true">
            <button type="submit" class="btn btn-primary">Edit</button>
        </form>
        <%
            } else if(editMode) {
        %>
        <form action="profile" method="post" enctype="multipart/form-data">
            <div class="row g-5">
                <div class="col-md-12 col-lg-6 col-xl-7">
                    <div class="row">
                        <div class="col-md-12 col-lg-6">
                            <div class="form-item w-100">
                                <label class="form-label my-3">Full Name</label>
                                <input type="text" class="form-control" name="fullName" value="<%= customer.getFullname() %>" >

                                <label class="form-label my-3"></label>
                                <input type="radio" name="gender"
                                       value="Male" <%= customer.isGender() ? "checked" : "" %> > Male
                                <input type="radio" name="gender"
                                       value="Female" <%= !customer.isGender() ? "checked" : "" %> > Female
                            </div>

                            <div class="form-item w-100">
                                <label class="form-label my-3">Date of birth</label>
                                <input type="date" name="dob" class="form-control" value="<%= customer.getDob() %>" >
                            </div>
                        </div>

                    </div>
                    <div class="form-item">
                        <label class="form-label my-3">Email</label>
                        <input type="email" name="email" class="form-control" value="<%= customer.getEmail() %>" >
                    </div>
                    <div class="form-item">
                        <label class="form-label my-3">Address</label>
                        <input type="text" name="address" class="form-control" value="<%= customer.getAddress() %>" >
                    </div>
                    <div class="form-item">
                        <label class="form-label my-3">Phone number</label>
                        <input type="tel" name="phone" class="form-control" value="<%= customer.getPhoneNumber() %>" >
                    </div>


                </div>
                <div class="col-md-12 col-lg-6 col-xl-5">
                    <div class="table-responsive">
                        <label for="imageUpload">
                            <img src="<%= (customer.getImg() != null && !customer.getImg().isEmpty()) ? customer.getImg() : "Static_acess_shop/img/user.png" %>"
                                 alt="Avatar" class="img-fluid mx-auto d-block" style="cursor: pointer;">
                        </label>
                        <input type="file" id="imageUpload" name="imageUpload">
                    </div>
                </div>
            </div>
            <br>
            <button type="submit" class="btn btn-success">Save</button>


        </form>
           <% } %>
    </div>
</div>
<!-- Checkout Page End -->


<%--        <jsp:include page="Footer.jsp" />--%>
</body>
<jsp:include page="Footer.jsp"/>











<script src="Static_acess_shop/js/jquery-3.3.1.min.js"></script>
<script src="Static_acess_shop/js/bootstrap.min.js"></script>
<script src="Static_acess_shop/js/jquery.nice-select.min.js"></script>
<script src="Static_acess_shop/js/jquery-ui.min.js"></script>
<script src="Static_acess_shop/js/jquery.slicknav.js"></script>
<script src="Static_acess_shop/js/mixitup.min.js"></script>
<script src="Static_acess_shop/js/owl.carousel.min.js"></script>
<script src="Static_acess_shop/js/main.js"></script>
</html>