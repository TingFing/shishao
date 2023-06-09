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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">
    //全选复选框功能实现
    function allClick() {
        //获得当前点击后全选按钮的状态
        var flag = $("#all").prop("checked");
        //将此状态赋值给下面五个复选框
        $("input[name='ck']").each(function () {
            this.checked = flag;
        });
    }

    //单个复选框点击改变全选复选框功能实现
    function ckClick() {
        //得到下面五个复选框的个数
        var fiveLength = $("input[name='ck']").length;
        //得到下面五个复选框被选中的个数
        var checkedLength = $("input[name='ck']:checked").length;
        //进行对比,改变全选复选框的状态
        if(fiveLength == checkedLength){
            $("#all").prop("checked",true);
        }else{
            $("#all").prop("checked",false);
        }
    }
</script>
<body>
<div id="brall">
    <div id="nav">
        <p>用户管理>用户列表</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            用户姓名：<input name="uname" id="uname">&nbsp;&nbsp;&nbsp;
            用户状态：<select name="ustatus" id="ustatus">
            <option value="-1">请选择</option>
            <option value="0">0</option>
            <option value="1">1</option>
        </select>&nbsp;&nbsp;&nbsp;
            积分：<input name="lprice" id="lprice">-<input name="hprice" id="hprice">
            <input type="button" value="查询" onclick="condition()">
        </form>
    </div>
    <br>
    <div id="table">

        <c:choose>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选


                    <input type="button" class="btn btn-warning" id="btn1"
                           value="批量删除" onclick="deleteBatch()">
                </div>
                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>用户名称</th>
                            <th>用户状态</th>
                            <th>用户等级</th>
                            <th>用户积分</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${userInfo.list}" var="p">
                            <tr>
                                <td valign="center" align="center">
                                    <input type="checkbox" name="ck" id="ck" value="${p.uid}" onclick="ckClick()"></td>
                                <td>${p.uname}</td>
                                <td>${p.ustatus}</td>
                                <td>${p.ulevel}</td>
                                <td>${p.score}</td>
                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.uid},${userInfo.pageNum})">编辑
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.uid},${userInfo.pageNum})">删除
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
                                            <%--                                        <a href="${pageContext.request.contextPath}/prod/split.action?page=${info.prePage}" aria-label="Previous">--%>
                                        <a href="javascript:ajaxsplit(${userInfo.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${userInfo.pages}" var="i">
                                        <c:if test="${userInfo.pageNum==i}">
                                            <li>
                                                    <%--                                                <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}" style="background-color: grey">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: grey">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${userInfo.pageNum!=i}">
                                            <li>
                                                    <%--                                                <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                            <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=1" aria-label="Next">--%>
                                        <a href="javascript:ajaxsplit(${userInfo.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">总共&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${userInfo.pages}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${userInfo.pageNum!=0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${userInfo.pageNum}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${userInfo.pageNum==0}">

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
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">暂时没有符合条件的用户！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    //批量删除
    function deleteBatch() {
        //得到所有选中复选框的对象,根据其长度判断是否有选中商品
        var cks = $("input[name='ck']:checked");  //1,4,5
        //如果有选中的商品
        if(cks.length == 0){
            alert("请先选择将要删除的商品!");
        }else{
            var str = "";
            var uid = "";
            if(confirm("您确定要删除"+cks.length+"条商品吗?")){
                // alert("可以进行删除!");
                //获取其value的值,进行字符串拼接
                $.each(cks,function () {
                    uid = $(this).val();
                    //进行非空判断,避免出错
                    if(uid != null){
                        str += uid+",";  //145   ===>1,4,5,
                    }
                });

                //发送ajax请求,进行批量删除的提交
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/deleteBatch.action",
                    data:{"uids":str},
                    type:"post",
                    dataType:"text",
                    success:function (msg) {
                        alert(msg);//批量删除成功!失败!不可删除!
                        //将页面上显示商品数据的容器重新加载
                        $("#table").load("http://localhost:8080/admin/user.jsp #table");
                    }
                });
            }
        }
    }

    //单个删除
    function del(uid,page) {
        //弹框提示
        if (confirm("您确定删除吗?")) {
            //发出ajax的请求,进行删除操作
            //取出查询条件
            var uname = $("#uname").val();
            var ustatus = $("#ustatus").val();
            var lprice = $("#lprice").val();
            var hprice = $("#hprice").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/user/delete.action",
                data: {"uid": uid,"page": page,"uname":uname,"ustatus":ustatus,"lprice":lprice,"hprice":hprice},
                type: "post",
                dataType: "text",
                success: function (msg) {
                    alert(msg);
                    $("#table").load("http://localhost:8080/admin/user.jsp #table");
                }
            });
        }
    }

    function one(uid,page) {
        //取出查询条件
        var uname = $("#uname").val();
        var ustatus = $("#ustatus").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        //向服务器提交请求,传递商品id
        var str = "?uid="+uid+"&page="+page+"&uname="+uname+"&ustatus="+ustatus+"&lprice="+lprice+"&hprice="+hprice;

        location.href = "${pageContext.request.contextPath}/user/one.action" + str;
    }
</script>
<!--分页的AJAX实现-->
<script type="text/javascript">
    function ajaxsplit(page) {
        //取出查询条件
        var uname = $("#uname").val();
        var ustatus = $("#ustatus").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/user/ajaxSplit.action",
            data: {"page": page,"uname":uname,"ustatus":ustatus,"lprice":lprice,"hprice":hprice},
            type: "post",
            success: function () {
                //重新加载显示分页数据的容器
                $("#table").load("http://localhost:8080/admin/user.jsp #table");
            }
        });

    }

    function condition() {
        //取出查询条件
        var uname = $("#uname").val();
        var ustatus = $("#ustatus").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/user/ajaxSplit.action",
            data:{"uname":uname,"ustatus":ustatus,"lprice":lprice,"hprice":hprice},
            success:function () {
                //刷新显示数据的容器
                $("#table").load("http://localhost:8080/admin/user.jsp #table");
            }
        });
    }
</script>

</html>
