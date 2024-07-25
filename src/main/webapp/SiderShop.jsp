<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="sidebar">
    <div class="blog__sidebar__search">
        <form action="shopping">
            <input type="text" name="search" placeholder="Search...">
            <button type="submit"><span class="icon_search"></span></button>
        </form>
    </div>
    <div class="sidebar__item">
        <h4>Categories</h4>
        <ul>
            <li><a style="${(cid == null && product == null && category == -1) ? "font-weight: bold" : ""}" href="shopping">All</a></li>
            <ul>
                <c:forEach items="${listC}" var="c">
                    <li><a style="${(c.getId() == product.getCategory().getId() || c.getId() == category) ? "font-weight: bold" : ""}"
                           href="shopping?category=${c.getId()}" >${c.getName()}</a></li>
                </c:forEach>
            </ul>
        </ul>
    </div>
    <c:if test="${isShopping == 1}">
        <div class="sidebar__item">
            <h4>Price</h4>
            <div class="price-range-wrap">
                <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                     data-min="10" data-max="540">
                    <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                </div>
                <div class="range-slider">
                    <div class="price-input">
                        <input type="text" id="minamount">
                        <input type="text" id="maxamount">
                    </div>
                </div>
            </div>
        </div>
        <div class="sidebar__item sidebar__item__color--option">
            <h4>Brand</h4>
            <c:forEach items="${listB}" var="l">
            <div class="sidebar__item__color" style="width: 50%;  margin-bottom: 10px;">
                <a href="shopping" style="font-size: 16px; color: black">
                    ${l.getName()}
                </a>
            </div>
            </c:forEach>
        </div>
    </c:if>

    <div class="sidebar__item">
        <div class="latest-product__text">
            <h4>Latest Products</h4>
            <div class="latest-product__slider owl-carousel">
                <div class="latest-product__slider owl-carousel">
                    <div class="latest-prdouct__slider__item">
                        <c:forEach items="${latestProduct}" var="l" begin="0" end="2">
                            <a href="productdetail?pid=${l.id}" class="latest-product__item">
                                <div class="latest-product__item__pic">
                                    <img src="${l.img}" alt="">
                                </div>
                                <div class="latest-product__item__text">
                                    <h6>${l.name}</h6>
                                    <span><fmt:formatNumber value="${l.price}" type="number"
                                                            minFractionDigits="0"
                                                            maxFractionDigits="2"/></span>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                    <div class="latest-prdouct__slider__item">
                        <c:forEach items="${latestProduct}" var="l" begin="3">
                            <a href="productdetail?pid=${l.id}" class="latest-product__item">
                                <div class="latest-product__item__pic">
                                    <img src="${l.img}" alt="">
                                </div>
                                <div class="latest-product__item__text">
                                    <h6>${l.name}</h6>
                                    <span><fmt:formatNumber value="${l.price}" type="number"
                                                            minFractionDigits="0"
                                                            maxFractionDigits="2"/></span>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>