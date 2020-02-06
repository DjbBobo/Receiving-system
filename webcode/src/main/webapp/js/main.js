$(function() {
	layui.use('layer', function() {
		layer = layui.layer;
	});
	$('.login-func').click(function() {
		$('#myModal-register').modal('toggle');
		$('#myModal-login').modal('toggle');
	});
	$('.register-func').click(function() {
		$('#myModal-login').modal('toggle');
		$('#myModal-register').modal('toggle');
	});
	$('.forget-func').click(function() {
		$('#myModal-login').modal('toggle');
		$('#myModal-forget').modal('toggle');
	});
    $('.register-form button:first').click(function(){
        if($('#email').val() == ''){
            layer.msg("邮箱不能为空!!",{icon:2});
            return;
        }
        if($('#name').val() == ''){
            layer.msg("用户名不能为空!!",{icon:2});
            return;
        }
        if($('#pwd').val() == ''||$('#pwd2').val() == ''){
            layer.msg("密码不能为空!!",{icon:2});
            return;
        }
        if($('#pwd').val() != $('#pwd2').val()){
            layer.msg("密码不一致!",{icon:2});
            return;
        }
        $.ajax({
            type:'post',
            url:$('#basePath').val()+"/user/add.do",
            data:{
                "email":$('#email').val(),
                "name":$('#name').val(),
                "pwd":$('#pwd').val(),
                "pwd2":$('#pwd2').val()
            },
            success: function (res) {
                if(res.code > 0){
                    layer.alert(res.msg);
                }else{
                    layer.msg(res.msg);
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                }

            }
        });
    });
    $('.content-forget-btn button').click(function () {
        if($('#findemail').val() == ''){
            layer.alert("邮箱不能为空");
            return;
        }
        $.ajax({
            type: "post",
            url: $('#basePath').val()+"/email/send.do",
            data: {
                "email":$('#findemail').val()
            },
            success: function(res) {
                if(res.code > 0){
                    layer.alert(res.msg);
                }else{
                    $(this).prop('disabled','disabled');
                    layer.msg(res.msg);
                }

            }
        });
    });
});