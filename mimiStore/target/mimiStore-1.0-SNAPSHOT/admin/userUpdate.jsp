<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/ajaxfileupload.js"></script>
	</head>

	<body>
		<div id="addAll">
			<div id="nav">
				<p>用户管理>修改用户</p>
			</div>

<script type="text/javascript">
	function myclose() {
		window.history.back()
	}
</script>
			<div id="table">
				<form action="${pageContext.request.contextPath}/user/update.action" enctype="multipart/form-data" method="post" id="myform">
					<input type="hidden" value="${prod.uid}" name="uid">

					<table>
						<tr>
							<td class="one">用户名称</td>
							<td><input type="text"  readonly="readonly" name="uname" class="two" value="${prod.uname}"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pnameerr"></span></td>
						</tr>
						<tr>
							<td class="one">用户等级</td>
							<td><input type="text" name="ulevel" class="two" value="${prod.ulevel}"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pcontenterr"></span></td>
						</tr>
						<tr>
							<td class="one">用户积分</td>
							<td><input type="number" name="score" class="two" value="${prod.score}"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="priceerr"></span></td>
						</tr>

						<tr>
							<td>
								<input type="submit" value="提交" class="btn btn-success">
							</td>
							<td>
								<input type="reset" value="取消" class="btn btn-default" onclick="myclose()">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

	</body>

</html>