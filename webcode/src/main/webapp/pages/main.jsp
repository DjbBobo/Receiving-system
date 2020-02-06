<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>收件系统</title>
		<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/img/icon.png">
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css"/>
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/main.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
	</head>
	<body>
		<div class="head">
			快速收件
		</div>
		<div class="content clearfix">
			<form class="form" action="#">
				<button class="login-btn" data-toggle="modal" data-target="#myModal-login">登陆</button>
				<button class="register-btn" data-toggle="modal" data-target="#myModal-register">注册</button>
			</form>
		</div>

		<!--登陆弹出层-->
		<div class="modal fade" id="myModal-login" tabindex="-1" role="dialog" aria-labelledby="myLoginLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myLoginLabel">登陆</h4>
					</div>
					<div class="modal-body">
						<form action="${pageContext.request.contextPath}/user/login.do" method="post">
							<div class="form-group">
								<input type="email" class="form-control" id="exampleInputEmail1" placeholder="邮箱或用户名" name="email">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" id="exampleInputPassword1" placeholder="登陆密码" name="pwd">
							</div>
							<div class="checkbox">
								<label>
							      <input type="checkbox">30天内自动登陆
							    </label>
								<a class="forget-pwd forget-func">忘记密码</a>
							</div>
							<button type="submit" class="btn btn-primary btn-block">登陆</button>
							<div class="form-group last">
								还没账号?
								<a class="register-func">&nbsp;&nbsp;立即注册</a>
							</div>
						</form>

					</div>
					<div class="modal-footer">
					</div>
				</div>
			</div>
		</div>

		<!--注册弹出层-->
		<div class="modal" id="myModal-register" tabindex="-1" role="dialog" aria-labelledby="myRegisterLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myRegisterLabel">注册</h4>
					</div>
					<div class="modal-body clearfix">
						<form class="register-form">
							<div class="form-group has-warning has-feedback">
								<label class="control-label" for="email">登陆邮箱</label>
								<input type="email" class="form-control" id="email" required name="email">
							</div>
							<div class="form-group has-warning has-feedback">
								<label class="control-label" for="name">用户名</label>
								<input type="text" class="form-control" id="name" required name="name">
							</div>
							<div class="form-group has-warning has-feedback">
								<label class="control-label" for="pwd">密码</label>
								<input type="text" class="form-control" id="pwd" required name="pwd">
							</div>
							<div class="form-group has-warning has-feedback">
								<label class="control-label" for="name">确认密码</label>
								<input type="text" class="form-control" id="pwd2" required name="pwd2">
							</div>
							<div class="form-group register-last">
								<button type="button" class="btn btn-primary">立即注册</button>
								<button type="submit" class="btn btn-default login-func">返回登陆</button>
							</div>
						</form>
					</div>
					<div class="modal-footer">
					</div>
				</div>
			</div>
		</div>
		
		<!--找回密码弹出层-->
		<div class="modal" id="myModal-forget" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">找回密码</h4>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group head-text">
								<p>找回密码邮件会发送到您的邮箱</p>
							</div>
							<div class="form-group content-forget-input">
								<input type="email" id="findemail" class="form-control" placeholder="请填写您的邮箱">
							</div>
							<div class="form-group content-forget-btn">
								<button type="button" class="btn btn-primary btn-block">重设密码</button>
							</div>
						</form>
					</div>
					<div class="modal-footer">
					</div>
				</div>
			</div>
		</div>
	<input type="hidden" value="${pageContext.request.contextPath}" id="basePath">
	</body>
</html>