<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>收件系统</title>
		<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/img/icon.png">
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userinfo.css"/>
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
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
						data-content='<div class="list-group"><a href="#" class="list-group-item "><span class="glyphicon glyphicon-picture" aria-hidden="true"></span>修改头像</a><a href="${pageContext.request.contextPath}/user/findUser.do?uid=${user.uid}" class="list-group-item"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span>密码与安全</a><a href="#" class="list-group-item"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>退出登录</a></div>'></button>
			</div>
		</div>
	</div>
		<div class="container userinfo">
			<table>
				<tr>
					<td class="left">用户名</td>
					<td class="right">${user.uname}</td>
				</tr>
				<tr>
					<td class="left">登陆邮箱</td>
					<td class="right">
						<input type="text" value="${user.uemail}" name="email"/>
					</td>
				</tr>
				<tr>
					<td class="left"></td>
					<td class="right">
						<ul>
							<li>登录邮箱(${user.uemail})还未验证，帐号功能可能受到限制</li>
							<li>您可以
								<a>更换登录邮箱</a>或者
								<a>发送验证邮件</a>
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<td class="left">原密码</td>
					<td class="right">
						<input type="text" name="oldpwd" id="oldpwd"/>
					</td>
				</tr>
				<tr>
					<td class="left">新密码</td>
					<td class="right">
						<input type="text" name="newpwd" id="newpwd"/>
					</td>
				</tr>
				<tr>
					<td class="left">确认新密码</td>
					<td class="right">
						<input type="text" name="newpwd2" id="newpwd2"/>
					</td>
				</tr>
				<tr>
					<td class="left">验证码</td>
					<td class="right">
						<input type="text" name="code" id="code"/>
					</td>
				</tr>
				<tr>
					<td class="left"></td>
					<td class="right">
						<img id="code-img" src="${pageContext.request.contextPath}/user/getVerifyCode.do" />
					</td>
				</tr>
				<tr>
					<td class="left"></td>
					<td class="right">
						<button class="btn btn-info" id="save">保存修改</button>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<script type="text/javascript">
        layui.use('layer', function() {
            layer = layui.layer;
        });
		$('[data-toggle="popover"]').popover();
		$('#code-img').click(function () {
            $('#code-img').prop('src','${pageContext.request.contextPath}/user/getVerifyCode.do?param='+new Date().getTime());
        });
		$('#save').click(function () {
            if($('#oldpwd').val() == ''){
                layer.msg('原始密码不能为空!',{'icon':2});
                return;
            }
            if($('#newpwd').val() == ''){
                layer.msg('新密码不能为空!',{'icon':2});
                return;
            }
            if($('#newpwd2').val() == ''){
                layer.msg('确认新密码不能为空!',{'icon':2});
                return;
            }
            if($('#newpwd2').val() != $('#newpwd').val()){
                layer.msg('新密码不相同!',{'icon':2});
                return;
            }
            if($('#code').val() == ''){
                layer.msg('验证码不能为空!',{'icon':2});
                return;
            }
            $.post('${pageContext.request.contextPath}'+"/user/changePwd.do",{"uid":${user.uid},"oldpwd":$('#oldpwd').val(),"newpwd":$('#newpwd').val(),"code":$('#code').val()},function (res) {
                if(res.code > 0){
                    layer.alert(res.msg,{icon:2});
                }else{
                    layer.msg(res.msg);
                    setTimeout(function () {
                        window.location.reload();
                    },500);
                }
            });
        });
	</script>

</html>