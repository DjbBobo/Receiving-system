<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="content-type" content="text/html; charset=UTF-8">
    <title>收件系统</title>
    <link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/img/icon.png">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/file-list.css"/>
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
                    data-content='<div class="list-group"><a href="#" class="list-group-item "><span class="glyphicon glyphicon-picture" aria-hidden="true"></span>修改头像</a><a href="${pageContext.request.contextPath}/user/findUser.do?uid=${uid}" class="list-group-item"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span>密码与安全</a><a href="#" class="list-group-item"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>退出登录</a></div>'></button>
        </div>
    </div>
</div>
<div class="container btn-download">
    <button class="btn btn-default" id="zipdownload" onclick="getZip()">打包下载</button>
</div>
<div class="container content">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <td class="td-checkbox">
                <label class="checkbox-inline">
                    <input type="checkbox" id="allcheck">全选
                </label>
            </td>
            <td>文件名称</td>
            <td>文件大小</td>
            <td>上传时间</td>
            <td>删除/下载</td>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${fileList}" var="f">
            <tr>
                <td class="td-checkbox">
                    <input type="checkbox" class="check" value="${f.fid}">
                </td>
                <td>
                        ${f.fname}
                </td>
                <td>
                        ${f.fsize}
                </td>
                <td>
                        ${f.ftime}
                </td>
                <td>
                    <a id="removefile" href="" class="btn-lg" onclick="removeFile(${f.fid},${pid});return false">
								<span class="glyphicon glyphicon-remove-circle" aria-hidden="true">
								</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/file/downloadFile.do?fid=${f.fid}" class="btn-lg">
								<span class="glyphicon glyphicon-save" aria-hidden="true">
								</span>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <input type="hidden" value="${pageContext.request.contextPath}" id="basePath">
    <input type="hidden" value="${title}" id="title">
</div>
</body>
<script type="text/javascript">
    layui.use('layer', function() {
        layer = layui.layer;
    });
    $(document).ready(function () {
        $('[data-toggle="popover"]').popover();
        $('#allcheck').click(function () {
            if ($(this).is(':checked')) {
                $('.check').prop('checked', 'checked');
            } else {
                $('.check').removeAttr('checked');
            }
        });
    });

    function getZip() {
        var fids = new Array();
        $.each($('input[class=check]'),function () {
            if($(this).is(':checked')){
                fids.push($(this).val());
            }
        });
        if(fids.length == 0){
            layer.msg('没有选中文件!',{icon:2});
            return;
        }
        layer.confirm('确定要打包下载吗?',{btn:['确定','取消']},function () {
            layer.close(layer.index);
            window.location.href = '${pageContext.request.contextPath}/file/getZip.do?fids='+fids+"&title="+$('#title').val();
        });
    }

    function removeFile(fid, pid) {
        layer.confirm('确定要删除吗?',{btn:['确定','取消']},function () {
            $.post("../file/removeFile.do",{"fid": fid,"pid": pid},function (res) {
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
    }
</script>

</html>