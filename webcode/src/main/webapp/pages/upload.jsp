<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="deadline" value="${folder.deadline}" scope="page"></c:set>
<c:set var="pid" value="${folder.pid}" scope="page"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>收件系统</title>
		<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/img/icon.png">
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/upload.css"/>
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
		<script src="${pageContext.request.contextPath}/js/upload.js" type="text/javascript" charset="utf-8"></script>
	</head>
	<script>
		<c:if test="${folder.status eq 1}">
			var c = '${pageContext.request.contextPath}'+"/pages/notime.jsp";
			window.location.href = c;
		</c:if>
		<jsp:useBean id="now" class="java.util.Date" scope="page"/>
		<c:set var="time1"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/></c:set>
		<fmt:parseDate value="${folder.deadline}" var="date1"/>
		<c:set var="time2"><fmt:formatDate value="${date1}" pattern="yyyy-MM-dd"/></c:set>
		<c:if test="${time1 > time2}">
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/folder/stop.do',
				data:{
					"pid":${folder.pid}
				},
				success:function (res) {
					var c = '${pageContext.request.contextPath}'+"/pages/notime.jsp";
					$(window).attr('Location',c);
				}
			});
		</c:if>
	</script>
	<body>
		<div class="container nav">
			<div class="row">
				<div class="col-lg-2">

				</div>
				<div class="col-lg-8 nav-main">
					<div class="row nav-title">
						<div class="col-lg-12 ">
							<span class="title">${folder.title}</span>
						</div>
					</div>
					<div class="row nav-text">
						<div class="text">
							${folder.content}
						</div>
					</div>
					<form id="form" action="${pageContext.request.contextPath}/file/upload.do" enctype="multipart/form-data" method="post">
					<div class="row nav-content">
						<div class="col-lg-12">
							<div class="row nav-input">
								<c:if test="${folder.finput ne null}">
									<div class="col-lg-6 first-input form-group form-inline">
										<label for="first">${folder.finput}</label>
										<input type="text" name="first" class="form-control" id="first" required>
									</div>
								</c:if>
								<c:if test="${folder.sinput ne null}">
									<div class="col-lg-6 second-input form-group form-inline">
										<label for="second">${folder.sinput}</label>
										<input type="text" name="second" class="form-control" id="second" required>
									</div>
								</c:if>
							</div>
							<div class="row nav-file">
								<div class="layui-upload-drag col-lg-12  col-xs-12" id="uploadfile">
									<i class="layui-icon"></i>
									<p>点击上传，或将文件拖拽到此处</p>
									<div class="layui-upload-list clearfix" id="list">
									</div>
								</div>
							</div>
							<div class="row nav-btn">
								<div class="col-lg-0 col-lg-offset-10  btn">
									<button class="btn btn-default" id="submitfile">提交</button>
								</div>
							</div>
							<div class="row nav-progress">
								<div class="progress " style="display: none;">
									<div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
									</div>
								</div>
							</div>
						</div>
					</div>
						<input type="hidden" value="${folder.pid}" name="pid" id="pid">
						<input type="hidden" value="${folder.uid}" name="uid" id="uid">
						<input type="hidden" value="${pageContext.request.contextPath}" name="basePath" id="basePath">
					</form>
				</div>
				<div class="col-lg-2">

				</div>
			</div>

		</div>

		
	</body>

</html>