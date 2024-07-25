<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-light navbar-vertical navbar-expand-xl">
    <div class="d-flex align-items-center">
        <div class="toggle-icon-wrapper">
            <button class="btn navbar-toggler-humburger-icon navbar-vertical-toggle" data-bs-toggle="tooltip"
                    data-bs-placement="left" title="Toggle Navigation"><span class="navbar-toggle-icon"><span
                    class="toggle-line"></span></span></button>
        </div>
        <a class="navbar-brand" href="home">
            <div class="d-flex align-items-center py-3"><img class="me-2"
                                                             src="Static_access_manager/assets/img/icons/spot-illustrations/falcon.png"
                                                             alt="" width="40"/><span
                    class="font-sans-serif">Fluffy</span>
            </div>
        </a>
    </div>
    <div class="collapse navbar-collapse" id="navbarVerticalCollapse">
        <div class="navbar-vertical-content scrollbar">
            <ul class="navbar-nav flex-column mb-3" id="navbarVerticalNav">

                <c:if test="${acc.getRoleName() == 'Marketer'}">
                    <li class="nav-item">
                        <!-- parent pages--><a class="nav-link ${activeDashboard}" href="marketingdashboard"
                                               aria-controls="dashboard">
                        <div class="d-flex align-items-center"><span class="nav-link-icon"><span
                                class="fas fa-chart-pie"></span></span><span
                                class="nav-link-text ps-1">MKT Dashboard</span>
                        </div>
                    </a>
                    </li>
                </c:if>

                <c:if test="${acc.getRoleName() == 'Sale' || acc.getRoleName() == 'Manager Sale'}">
                    <li class="nav-item">
                        <!-- parent pages--><a class="nav-link ${activeDashboard}" href="saledashboard"
                                               aria-controls="dashboard">
                        <div class="d-flex align-items-center"><span class="nav-link-icon"><span
                                class="fas fa-chart-pie"></span></span><span
                                class="nav-link-text ps-1">Sale Dashboard</span>
                        </div>
                    </a>
                    </li>
                </c:if>

                <c:if test="${acc.getRoleName() == 'Admin'}">
                    <li class="nav-item">
                        <!-- parent pages--><a class="nav-link ${activeDashboard}" href="dashboard"
                                               aria-controls="dashboard">
                        <div class="d-flex align-items-center"><span class="nav-link-icon"><span
                                class="fas fa-chart-pie"></span></span><span
                                class="nav-link-text ps-1">Admin Dashboard</span>
                        </div>
                    </a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <c:if test="${acc.getRoleName() == 'Marketer' || acc.getRoleName() == 'Sale' || acc.getRoleName() == 'Manager Sale' || acc.getRoleName() == 'Warehouse Staff'}">
                        <!-- parent pages--><a class="nav-link dropdown-indicator" href="#e-commerce" role="button"
                        data-bs-toggle="collapse"
                        aria-expanded="${ecommerce == null ? 'false' : 'true'}"
                        aria-controls="e-commerce">
                        <div class="d-flex align-items-center"><span class="nav-link-icon"><span
                                class="fas fa-shopping-cart"></span></span><span
                                class="nav-link-text ps-1">E commerce</span>
                        </div>
                        </a>
                    </c:if>
                    <ul class="nav collapse ${ecommerce}" id="e-commerce">
                        <c:if test="${acc.getRoleName() == 'Marketer' || acc.getRoleName() == 'Warehouse Staff'}">
                            <li class="nav-item"><a class="nav-link dropdown-indicator" href="#product"
                                                    data-bs-toggle="collapse" aria-expanded="false"
                                                    aria-controls="e-commerce">
                                <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Product</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                                <ul class="nav collapse false ${ecommerce_product}" id="product">
                                    <li class="nav-item"><a class="nav-link ${listproduct}" href="products"
                                                            aria-expanded="false">
                                        <div class="d-flex align-items-center"><span
                                                class="nav-link-text ps-1">Product list</span>
                                        </div>
                                    </a>
                                        <!-- more inner pages-->
                                    </li>
                                    <li class="nav-item"><a class="nav-link ${inventory}" href="inventorymanagement"
                                                            aria-expanded="false">
                                        <div class="d-flex align-items-center"><span
                                                class="nav-link-text ps-1">Inventory Management</span>
                                        </div>
                                    </a>
                                        <!-- more inner pages-->
                                    </li>
                                    <li class="nav-item"><a class="nav-link ${productdetail}" href="product"
                                                            aria-expanded="false">
                                        <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Product details</span>
                                        </div>
                                    </a>
                                        <!-- more inner pages-->
                                    </li>
                                </ul>
                            </li>
                        </c:if>

                        <c:if test="${acc.getRoleName() == 'Marketer'}">
                            <li class="nav-item">
                                <a class="nav-link dropdown-indicator" href="#events"
                                   data-bs-toggle="collapse" aria-expanded="${post == null ? 'false' : 'true'}"
                                   aria-controls="events">
                                    <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Posts</span>
                                    </div>
                                </a>
                                <ul class="nav collapse ${post}" id="events">
                                    <li class="nav-item"><a class="nav-link ${createpost}" href="createanpost" aria-expanded="false">
                                        <div class="d-flex align-items-center"><span
                                                class="nav-link-text ps-1">Create an post</span>
                                        </div>
                                    </a>
                                        <!-- more inner pages-->
                                    </li>
                                    <li class="nav-item"><a class="nav-link ${postlist}" href="listpost"
                                                            aria-expanded="false">
                                        <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Post list</span>
                                        </div>
                                    </a>
                                        <!-- more inner pages-->
                                    </li>
                                </ul>
                            </li>
                        </c:if>

                        <c:if test="${acc.getRoleName() == 'Sale' || acc.getRoleName() == 'Manager Sale' || acc.getRoleName() == 'Warehouse Staff'}">
                            <li class="nav-item"><a class="nav-link dropdown-indicator" href="#orders"
                                                    data-bs-toggle="collapse" aria-expanded="false"
                                                    aria-controls="e-commerce">
                                <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Orders</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                                <ul class="nav collapse false ${ecommerce_order}" id="orders">
                                    <li class="nav-item"><a class="nav-link ${listorder}" href="orderlist"
                                                            aria-expanded="false">
                                        <div class="d-flex align-items-center"><span
                                                class="nav-link-text ps-1">Order list</span>
                                        </div>
                                    </a>
                                        <!-- more inner pages-->
                                    </li>
                                    <li class="nav-item"><a class="nav-link ${orderdetail}"
                                                            href="${oid == null ? 'orderlist' : 'orderdetailsale?oid='}${oid}"
                                                            aria-expanded="false">
                                        <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Order details</span>
                                        </div>
                                    </a>
                                        <!-- more inner pages-->
                                    </li>
                                </ul>
                            </li>
                        </c:if>

                        <c:if test="${acc.getRoleName() == 'Marketer'}">
                            <li class="nav-item"><a class="nav-link ${activeFeedback}" href="feedback-list"
                                                    aria-expanded="false">
                                <div class="d-flex align-items-center"><span class="nav-link-text ps-1">FeedBacks</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                            </li>
                            <li class="nav-item"><a class="nav-link ${activeCustom}" href="listcustomer"
                                                    aria-expanded="false">
                                <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Customers</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                            </li>
                            <li class="nav-item"><a class="nav-link ${activeSlider}" href="listslider"
                                                    aria-expanded="false">
                                <div class="d-flex align-items-center"><span class="nav-link-text ps-1">Sliders</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                            </li>
                        </c:if>
                    </ul>
                </li>
                <c:if test="${acc.getRoleName() == 'Admin'}">
                    <li class="nav-item">
                        <!-- parent pages--><a class="nav-link dropdown-indicator" href="#staff" role="button"
                                               data-bs-toggle="collapse" aria-expanded="false" aria-controls="staff">
                        <div class="d-flex align-items-center"><span class="nav-link-icon"><span
                                class="fas fa-user"></span></span><span
                                class="nav-link-text ps-1">Staff</span>
                        </div>
                    </a>
                        <ul class="nav collapse false ${showStaff}" id="staff">
                            <li class="nav-item"><a class="nav-link ${activeAdd}" href="addstaff" aria-expanded="false">
                                <div class="d-flex align-items-center"><span
                                        class="nav-link-text ps-1">Add new staff</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                            </li>
                            <li class="nav-item"><a class="nav-link ${liststaff}" href="liststaff"
                                                    aria-expanded="false">
                                <div class="d-flex align-items-center"><span
                                        class="nav-link-text ps-1">List staff</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                            </li>
                            <li class="nav-item"><a class="nav-link ${detail}"
                                                    href="${sid == null ? 'liststaff' : 'staffdetail?sid='}${sid}"
                                                    aria-expanded="false">
                                <div class="d-flex align-items-center"><span
                                        class="nav-link-text ps-1">Staff detail</span>
                                </div>
                            </a>
                                <!-- more inner pages-->
                            </li>
                        </ul>
                    </li>
                </c:if>
                <li class="nav-item">
                    <!-- parent pages--><a class="nav-link dropdown-indicator " href="#user" role="button"
                                           data-bs-toggle="collapse" aria-expanded="false" aria-controls="user">
                    <div class="d-flex align-items-center"><span class="nav-link-icon"><span class="fas fa-user"></span></span><span
                            class="nav-link-text ps-1">User</span>
                    </div>
                </a>
                    <ul class="nav collapse false ${user}" id="user">
                        <li class="nav-item"><a class="nav-link  ${userdetail}"
                                                href="staffprofile"
                                                aria-expanded="false">
                            <div class="d-flex align-items-center "><span class="nav-link-text ps-1">Profile</span>
                            </div>
                        </a>
                            <!-- more inner pages-->
                        </li>
                        <li class="nav-item"><a class="nav-link"
                                                href="changepassword"
                                                aria-expanded="false">
                            <div class="d-flex align-items-center"><span
                                    class="nav-link-text ps-1">Change password</span>
                            </div>
                        </a>
                            <!-- more inner pages-->
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>