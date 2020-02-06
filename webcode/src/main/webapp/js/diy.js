$(function() {
	layui.use('layer', function () {
		layer = layui.layer;
	});
	$('.filename').click(function() {
		$(this).css('display', 'none');
		$('.title-input').css('display', 'inline-block');
		$('.title-input').css({
			'margin': '0 auto',
			'margin-top': '50px'
		});
		$('.title-input').select();
	});
	$('.title-input').blur(function() {
		$('.filename').css('display', 'inline-block');
		$('.title-input').css('display', 'none');
		if($(this).val() == '') {
			$('.text').text('设置收件名称');
		} else {
			$('.filename').text($(this).val());
		}
	});
	$('#name1').click(function() {
		$('.first-body').css('display', 'none')
		$('.first-name').css('display', 'none')
		$('.first-input').css('display', 'inline-block')
		$('.first-input').select()
	});
	$('.first-input').blur(function() {
		$('.first-body').css('display', 'inline-block')
		$('.first-name').css('display', 'inline-block')
		$(this).css('display', 'none')
		if($(this).val() == '') {

		} else {
			$('.first-name').text($(this).val())
			$('.first-body').prop('value',$(this).val())
		}
	});
	$('#name2').click(function() {
		$('.second-body').css('display', 'none')
		$('.second-name').css('display', 'none')
		$('.second-input').css('display', 'inline-block')
		$('.second-input').select()
	});
	$('.second-input').blur(function() {
		$('.second-body').css('display', 'inline-block')
		$('.second-name').css('display', 'inline-block')
		$(this).css('display', 'none')
		if($(this).val() == '') {

		} else {
			$('.second-name').text($(this).val())
			$('.second-body').prop('value',$(this).val())
		}
	});

	$('.dropdown-menu li').click(function () {
		$('.model-sort').text($(this).text());
		$('.dropdown-menu li').css("backgroundColor","#fff");
		$(this).css("backgroundColor","#E6E6E6");
	});

	$('#next').click(function () {
		if($('.model-sort').text() == '请选择'){
			layer.msg("请选择所属模块");
			return;
		}
		var model = $('.model-sort').text();
		var title = $('.filename').text();
		var content = $('.Editor-editor').html();
		var deadline = 	$('.deadline').val();
		var arr = new Array();
		var uid = $('#uid').val();
		var filename;
		if($('input[name="filename"]').is(':checked')){
            filename = "1";
        }else{
		    filename = "0";
        }
		$("input[name='input']:checked").each(function(){
			arr.push($(this).val());
		});
		var url;
		var route;
		if($(this).attr('name') == ''){
			url = "../folder/createFolder.do";
		}else {
			url = "../folder/updateFolder.do";
			route = $('#route').val();
		}
		var obj = {};
		obj['title'] = title;
		obj['content'] = content;
		obj['deadline'] = deadline;
		obj['arr'] = arr;
		obj['uid'] = uid;
		obj['filename'] = filename;
		obj['route'] = route;
		obj['model'] = model;
		obj = JSON.stringify(obj);

		$.ajax({
			dataType: "json",
			type:"post",
			url:url,
			data:{
			    "obj":obj
            },
			success:function(res){
				$(window).attr("location","../folder/createSucccess.do?time="+res.time+"&route="+res.route+"&uid="+uid);
			}
		});
		return false;

	});
});