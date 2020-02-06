<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>收件系统</title>
		<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/img/icon.png">
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/diysuccess.css"/>
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/clipboard.min.js"></script>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					
				</div>
				<div class="col-lg-6 main">
					<div class="row head">
						<div class="col-lg-12">
							当前收件箱收件截止时间:&nbsp;
							<span class="deadline">${deadline}</span>
						</div>
					</div>
					<div class="row address">
						<div class="col-lg-10">
							<input type="text" class="form-control" id="address" readonly="readonly" value="http://115.29.243.96:8080${pageContext.request.contextPath}/file/findPage.do?route=${route}" style="background-color: #fff;" onclick="$(this).select();">
						</div>
						<div class="col-lg-2">
							<button class="btn btn-default clip" data-clipboard-text="http://115.29.243.96:8080${pageContext.request.contextPath}/file/findPage.do?route=${route}">复制地址</button>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-4 col-lg-offset-4 code">
							<h5>扫描二维码,分享到手机</h5>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-3 col-lg-offset-4 back">
							<button class="btn btn-default">返回列表</button>
						</div>
					</div>
				</div>
				<div class="col-lg-3">
					
				</div>
			</div>
		</div>
	<input id="basePath" type="hidden" value="${pageContext.request.contextPath}"/>
	<input id="route" type="hidden" value="${route}" />
		<input id="uid" type="hidden" value="${uid}" />
	</body>
	<script type="text/javascript">
		var addr = 'http://115.29.243.96:8080'+$('#basePath').val()+"/file/findPage.do?route="+$('#route').val();
		$('.code').qrcode({
			render: "canvas",
			width: 130,
			height: 130,
			text: addr
		});
		$('.back').click(function () {
			$(window).attr("location","../folder/findList.do?uid="+$('#uid').val())
		});
		//必须要初始化 第一种初始化
		var clipboard = new ClipboardJS('.clip');
		clipboard.on('success', function(e) {
			console.log(e);
		});
		clipboard.on('error', function(e) {
			console.log(e);
		});
	</script>
</html>
