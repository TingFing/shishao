<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>

    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/message.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>

<body>
<div id="brall">
    <div id="nav">
        <p>订单管理>订单列表</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            订 单 ID：<input name="oid" id="oid">&nbsp;&nbsp;&nbsp;
            订单状态：<select name="status" id="status">
            <option value="-1">请选择</option>
            <option value="0">待发货</option>
            <option value="1">已发货</option>
        </select>&nbsp;&nbsp;&nbsp;
            <input type="button" value="查询" onclick="condition()">
        </form>
    </div>
    <br>
    <div id="table" style="align-self: center">

        <c:choose>
            <c:when test="${orderList.list.size()!=0}">

                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>订单ID</th>
                            <th>用户ID</th>
                            <th>地址ID</th>
                            <th>总价格</th>
                            <th>备注</th>
                            <th>订单状态</th>
                            <th>下单时间</th>
                        </tr>
                        <c:forEach items="${orderList.list}" var="p">
                            <tr>
                                <td></td>
                                <td>${p.oid}</td>
                                <td>${p.uid}</td>
                                <td>${p.addressid}</td>
                                <td>${p.totalprice}</td>
                                <td>${p.remarks}</td>
                                <td>${p.status}</td>
                                <td>${p.date}</td>
                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.uid})">查看详情
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>


                    <!--分页栏-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                        <a href="javascript:ajaxsplit(${orderList.prePage})" aria-label="Previous">
                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${orderList.pages}" var="i">
                                        <c:if test="${orderList.pageNum==i}">
                                            <li>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: grey">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${orderList.pageNum!=i}">
                                            <li>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                        <a href="javascript:ajaxsplit(${orderList.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">总共&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${orderList.pages}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${orderList.pageNum!=0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${orderList.pageNum}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${orderList.pageNum==0}">

                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">暂时没有符合条件的订单！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <form id="message-box">
        <span class="close-button" onclick="hideMessage()">&times;</span>

        <label for="recipient">收货人：</label>
        <input type="text" id="recipient" readonly>
        <label for="order-number">订单号：</label>
        <input type="text" id="order-number" readonly>

        <label for="delivery-address">收货地址：</label>
        <input type="text" id="delivery-address" readonly>

        <label for="quantity">购买数量：</label>
        <input type="text" id="quantity" readonly>

        <label for="total-price">总价格：</label>
        <input type="text" id="total-price" readonly>
    </form>
</div>
</body>

<script type="text/javascript">

    function hideMessage() {

        // 隐藏信息框
        var messageBox = document.getElementById("message-box");
        messageBox.style.display = "none";
    }

    function mysubmit() {
        $("#myform").submit();
    }

    function one(uid) {
        $.ajax({
            url: "${pageContext.request.contextPath}/order/MultiTableCheck.action",
            type: "get",
            data: {"uid": uid},
            success: function (orderDetailVO) {
                if (orderDetailVO!=''){
                    var recipient = orderDetailVO.uname
                    console.log(recipient)
                    document.getElementById("recipient").value = recipient;
                    var oid = orderDetailVO.oid
                    document.getElementById("order-number").value = oid;
                    var address = orderDetailVO.address
                    document.getElementById("delivery-address").value = address;
                    var quantity = orderDetailVO.pnumber
                    document.getElementById("quantity").value = quantity;
                    var price = orderDetailVO.ptotal
                    document.getElementById("total-price").value = price;
                    // 显示信息框
                    var messageBox = document.getElementById("message-box");
                    messageBox.style.display = "block";
                }else {
                    alert("订单信息异常！请核实后查看")
                }

            },
            error: function () {
                alert("aaaaaaaaaaaaa")
            }
        })
    }

</script>
<!--分页的AJAX实现-->
<script type="text/javascript">
    function ajaxsplit(page) {
        //取出查询条件
        var oid = $("#oid").val();
        var status = $("#status").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/order/ajaxSplit.action",
            data: {"page": page, "oid": oid, "status": status},
            type: "post",
            success: function () {
                //重新加载显示分页数据的容器
                $("#table").load("http://localhost:8080/admin/order.jsp #table");
            }
        });

    }

    function condition() {
        //取出查询条件
        var oid = $("#oid").val();
        var status = $("#status").val();
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/order/ajaxSplit.action",
            data: {"oid": oid, "status": status},
            success: function () {
                //刷新显示数据的容器
                $("#table").load("http://localhost:8080/admin/order.jsp #table");
            }
        });
    }

</script>

</html>
