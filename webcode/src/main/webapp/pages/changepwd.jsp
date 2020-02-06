<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>收件系统</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>

<body style="background-color: #23262E;">
<div>
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myChangeLabel">修改密码</h4>
            </div>
            <div class="modal-body clearfix">
                <form class="changepwd-form">
                    <div class="form-group has-warning has-feedback">
                        <label class="control-label" for="email">登陆邮箱</label>
                        <input type="email" class="form-control" id="email" readonly="">
                    </div>
                    <div class="form-group has-warning has-feedback">
                        <label class="control-label" for="pwd">新密码</label>
                        <input type="text" class="form-control" id="pwd" required="required">
                    </div>
                    <div class="form-group has-warning has-feedback">
                        <label class="control-label" for="pwd2">确认新密码</label>
                        <input type="text" class="form-control" id="pwd2" required="required">
                    </div>
                    <div class="form-group changepwd-last">
                        <button type="button" class="btn btn-primary btn-block">修改密码</button>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    layui.use('layer', function () {
        layer = layui.layer;
    });
    $('.changepwd-last button').click(function () {
        if ($('#email').val() == '') {
            layer.alert("邮箱不能为空");
            return;
        }
        if ($('#pwd').val() != $('#pwd2').val()) {
            layer.alert("新密码不一致");
            return;
        }
        $.ajax({
            type: "post",
            url: "",
            data: {
                "email": $('#email').val(),
                "pwd": $('#pwd').val(),
                "pwd2": $('#pwd2').val()
            },
            success: function (res) {
                if (res.code > 0) {
                    layer.alert(res.msg);
                } else {
                    layer.msg(res.msg);
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                }
            }
        });
    });
</script>
</html>
