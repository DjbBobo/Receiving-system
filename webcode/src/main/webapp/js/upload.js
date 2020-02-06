$(function() {
	layui.use(['layer','upload'], function() {
		var $ = layui.jquery,
			upload = layui.upload,
			layer = layui.layer;;
		var list = $('#list'),
			uploadListIns = upload.render({
				elem: '#uploadfile',
				accept: 'file',
				exts: 'jpg|jpeg|png|doc|docx',
				auto: false, //不自动上传
				multiple: true,
				choose: function(obj) {
					var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
					//预读本地文件示例，不支持ie8
					obj.preview(function(index, file, result) {
						var p = $('#basePath').val()+"/img/word.png";
						var div = $(['<div class="img"><img src="'+p+'" alt="' + file.name + '"/>' + file.name + '<span class="glyphicon glyphicon glyphicon-remove" aria-hidden="true"></span></div>'].join(''));;
						$('.layui-upload-drag i,p').css('display', 'none');
						div.find('.glyphicon-remove').on('click', function(event) {
							delete files[index];
							div.remove();
							uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
							if($('#list div').length == 0) {
								$('.layui-upload-drag i,p').css('display', 'block');
							}
							event.stopPropagation();
						});
						$('#list').append(div);
					});
				},done: function (res) {

				}
			});
	});

	$('#submitfile').click(function () {
		var formData = new FormData($('#form')[0]);
		scroll();
		$.ajax({
			url:'file/upload.do',
			type:'post',
			data:formData,
			contentType:false,
			processData: false,
			success:function(data){

			 },
			error:function(){
				$(window).attr('location','../pages/uploadsuccess.jsp');
			},
			cache:false
		});
	});
	function scroll() {
		var width = $('.progress-bar').css('width');
		width = width.substring(0,width.length-2);

		if(width < 784){
			width = width+5;
			$('.progress-bar').css('width',width+'px');
		}else{
			window.clearInterval(intervalObj);

		}
	}
});