<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" deferredSyntaxAllowedAsLiteral="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>收件系统</title>
		<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/img/icon.png">
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/editor.js"></script>
		<script src="${pageContext.request.contextPath}/js/diy.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
		<link href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/css/editor.css" type="text/css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/diy.css"/>
	</head>

	<body>
	<div class="head container-fluid">
		<div class="head-content container clearfix">
			<div class="left-icon">
				<img src="${pageContext.request.contextPath}/img/folder-head.png"/>
			</div>
			<div class="left-text">
				<span>收件夹</span>
			</div>
			<div class="right-info">
				<button tabindex="0" role="button" data-trigger="focus" data-placement="bottom" data-toggle="popover"
						data-html="true"
						data-content='<div class="list-group"><a href="#" class="list-group-item "><span class="glyphicon glyphicon-picture" aria-hidden="true"></span>修改头像</a><a href="${pageContext.request.contextPath}/user/findUser.do?uid=${uid}" class="list-group-item"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span>密码与安全</a><a href="#" class="list-group-item"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>退出登录</a></div>'></button>
			</div>
		</div>
	</div>

		<div class="container content">
			<form>
				<div class="row content-title">
					<div class="col-lg-2">

					</div>
					<div class="col-lg-8 title-main">
						<span class="filename"><c:if test="${folder.title eq null}">设置收件名称</c:if>${folder.title}</span>
						<input type='text' class='title-input' placeholder='设置收件名称' />
					</div>
					<div class="col-lg-2">

					</div>
				</div>
				<div class="row content-main">
					<div class="col-lg-2">

					</div>
					<div class="col-lg-8 content-center">
						<div class="row">
							<div class="content-explain col-lg-12">
								<span>收件说明:</span>
								<textarea id="txtEditor"></textarea>
							</div>
						</div>
						<div class="row">
							<div class="content-nameRule col-lg-12">
								<span>文件命名规则:</span>
								<div class="checkbox">
									<label>
										<input type="checkbox" class="first-body" name="input" value="班级名称" <c:if test="${folder.finput ne null}">checked</c:if>>&nbsp;&nbsp;
										<span class="first-name"><c:if test="${folder.finput eq null}">班级名称</c:if>${folder.finput}</span>
										<input type="text" class="first-input" />
										<img src="${pageContext.request.contextPath}/img/pen.png" id="name1" class="name first-body" />
									</label>
									<span class="and">+</span>
									<label>
										<input type="checkbox" class="second-body" name="input" value="提交人姓名" <c:if test="${folder.sinput ne null}">checked</c:if>>&nbsp;&nbsp;
										<span class="second-name"><c:if test="${folder.sinput eq null}">提交人姓名</c:if>${folder.sinput}</span>
										<input type="text" class="second-input" />
										<img src="${pageContext.request.contextPath}/img/pen.png" id="name2" class="name second-body" />
									</label>
									<span class="and">+</span>
									<label>
										<input type="checkbox" name="filename" value="文件名" <c:if test="${folder.tinput ne null}">checked</c:if>>&nbsp;&nbsp;文件名
									</label>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="content-time col-lg-12">
								<span>提交截止时间:</span>
								<div>
									<input type="date" class="deadline" value="<c:if test="${folder.deadline eq null}"></c:if>${folder.deadline}"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="content-model col-lg-12">
								<span>选择分类模块:</span>
								<div class="btn-group">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<span class="model-sort"><c:if test="${folder.model eq null}">请选择</c:if><c:if test="${folder.model ne null}">${folder.model}</c:if></span><span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li><a >课程</a></li>
										<li><a >工作</a></li>
										<li><a >学习</a></li>
										<li role="separator" class="divider"></li>
										<li><a >其他</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="row last-btn">
							<div class="col-lg-4 col-lg-offset-3 last">
								<button class="btn btn-default">上一步</button>
							</div>
							<div class="col-lg-4 next">
								<button class="btn btn-default" id="next" name="${folder.pid}">下一步</button>
							</div>
						</div>
					</div>

					<div class="col-lg-2">

					</div>
				</div>
			</form>
		</div>
		<input type="hidden" value="${uid}" id="uid">
        <input type="hidden" value="${folder.route}" id="route">
	</body>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#txtEditor").Editor();
			$('[data-toggle="popover"]').popover();
		});
	</script>

</html>