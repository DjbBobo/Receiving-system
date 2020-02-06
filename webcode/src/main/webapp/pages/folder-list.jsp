<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>收件系统</title>
    <link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/img/icon.png">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/folder-list.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/folder-list.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js" type="text/javascript"
            charset="utf-8"></script>
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
        <div class="search clearfix">
            <form action="${pageContext.request.contextPath}/folder/searchFolder.do?uid=${uid}" method="post">
                <div class="search-input">
                    <input type="text" id="search-text" name="text" required/>
                </div>
                <div class="search-btn">
                    <button class="btn btn-default" type="submit">搜索</button>
                </div>
            </form>
        </div>
        <div class="right-info">
            <button tabindex="0" role="button" data-trigger="focus" data-placement="bottom" data-toggle="popover"
                    data-html="true"
                    data-content='<div class="list-group"><a href="#" class="list-group-item "><span class="glyphicon glyphicon-picture" aria-hidden="true"></span>修改头像</a><a href="${pageContext.request.contextPath}/user/findUser.do?uid=${uid}" class="list-group-item"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span>密码与安全</a><a href="${pageContext.request.contextPath}/pages/main.jsp" class="list-group-item"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>退出登录</a></div>'></button>
        </div>
    </div>
</div>
<div class="content container">

    <div class="content-title clearfix">
        模块分类:
        <div class="btn-group">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="model-sort"><c:if test="${model ne null}">${model}</c:if><c:if test="${model eq null}">全部模块</c:if></span><span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-model">
                <li><a href="${pageContext.request.contextPath}/folder/findList.do?uid=${uid}">全部模块</a></li>
                <li><a href="${pageContext.request.contextPath}/folder/findListByModel.do?model=课程&uid=${uid}">课程</a></li>
                <li><a href="${pageContext.request.contextPath}/folder/findListByModel.do?model=工作&uid=${uid}">工作</a></li>
                <li><a href="${pageContext.request.contextPath}/folder/findListByModel.do?model=学习&uid=${uid}">学习</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="${pageContext.request.contextPath}/folder/findListByModel.do?model=其他&uid=${uid}">其他</a></li>
            </ul>
        </div>
        <span style="display: inline-block;margin-left: 20px;">收件夹状态:</span>
        <div class="btn-group">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="search-status"><c:if test="${status eq null}">请选择查询</c:if><c:if test="${status ne null}">${status}</c:if></span><span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-status">
                <li><a href="${pageContext.request.contextPath}/folder/findListByStatus.do?uid=${uid}&status=0">未停止收件</a></li>
                <li role="separator" class="divider"></li>
                <li ><a style="color: red;" href="${pageContext.request.contextPath}/folder/findListByStatus.do?uid=${uid}&status=1">已停止收件</a></li>
            </ul>
        </div>
        <div class="right-add">
            <button class="btn btn-default">创建收件夹</button>
        </div>
    </div>

    <div class="content-folder-list">
        <c:forEach items="${pageInfo.list}" var="f" varStatus="i">
            <div class="folder clearfix">
                <div class="left-img">
                    <div class="files">${f.pnum}</div>
                    <a href="${pageContext.request.contextPath}/file/findAll.do?pid=${f.pid}&title=${f.title}&uid=${uid}">
                        <img src="${pageContext.request.contextPath}/img/folder-icon.png"/>
                    </a>
                </div>
                <div class="right-info">
                    <div class="top-title">
                        <a href="${pageContext.request.contextPath}/file/findPage.do?route=${f.route}" target="_blank">${f.title}</a>
                    </div>
                    <div class="bottom-info clearfix">
                        <div class="left-time">
                                <span style="display: inline-block;width: 110px;">${f.time}</span>&nbsp;&nbsp;&nbsp;截止时间:<span id="left-time">${f.deadline}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;模块:${f.model}
                        </div>

                        <div class="right-func">
                            <a name="${f.route}" data-trigger="focus" class="linkandcode" data-toggle="popover"
                               tabindex="0" role="button" data-placement="left" data-html="true"
                               title="收件地址和二维码"
                               data-content="<div class='LinkAndCode'><div class='code ${f.route}'>	</div><div class='link'><input class='link-input' type='text' readonly='readonly' value='22' style='background-color: #fff;' onclick='$(this).select();'></div></div>">
                                <img src="${pageContext.request.contextPath}/img/link.png"/>
                            </a>
                            <a tabindex="0" role="button" class="deadline-a${f.pid}" data-placement="left" data-toggle="popover"
                               data-html="true"
                               title="设置截止时间"
                               data-content='<div class="deadline"><input type="date" value="${f.deadline}" class="deadline-input"/><button class="btn btn-success" onclick="changeTime(${f.pid})">确定</button><button class="btn btn-default" onclick="notime(${f.pid})">取消</button></div>'>
                                <jsp:useBean id="now" class="java.util.Date" scope="page"/>
                                <c:set var="time1"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/></c:set>
                                <fmt:parseDate value="${f.deadline}" var="date1"/>
                                <c:set var="time2"><fmt:formatDate value="${date1}" pattern="yyyy-MM-dd"/></c:set>
                                <c:if test="${time1 > time2}">
                                    <img class="time-img img-${f.pid}"
                                         src="${pageContext.request.contextPath}/img/time2.png"/>
                                </c:if>
                                <c:if test="${time1 <= time2}">
                                    <img class="time-img img-${f.pid}"
                                         src="${pageContext.request.contextPath}/img/time.png"/>
                                </c:if>
                            </a>

                            <c:choose>
                                <c:when test="${time1 > time2}">
                                    <a onclick="restartTime(${f.pid})">
                                        <img src="${pageContext.request.contextPath}/img/stop.png"/>
                                    </a>
                                </c:when>
                                <c:when test="${f.status == 1}">
                                    <a onclick="restartReason(${f.pid})">
                                        <img src="${pageContext.request.contextPath}/img/stop.png"/>
                                    </a>
                                </c:when>
                                <c:when test="${time1 <= time2}">
                                    <a tabindex="0"  class="stop-a${f.pid}" role="button" data-placement="left"
                                       data-toggle="popover" data-html="true"
                                       title="设置暂停/停止原因"
                                       data-content='<div class="stopreason"><textarea rows="5" cols="20" class="textarea${f.pid}"><c:set var="fre" value="收件已停止"/><c:set var="sre" value="${f.stopreason}"/><c:if test="${f.stopreason eq null}">${fn:trim(fre)}</c:if><c:if test="${f.stopreason ne null}">${fn:trim(sre)}</c:if></textarea><button class="btn btn-success" onclick="stopReason(${f.pid})">确定</button><button class="btn btn-default" onclick="nostop(${f.pid})">取消</button></div>'>
                                        <img src="${pageContext.request.contextPath}/img/start.png"/>
                                    </a>
                                </c:when>
                            </c:choose>

                            <a tabindex="0" data-trigger="focus" role="button" data-placement="left" data-toggle="popover" data-html="true" title="设置" data-content='<div class="list-group" style="width:150px;"><a href="${pageContext.request.contextPath}/folder/edit.do?pid=${f.pid}" class="list-group-item" style="color:#23262E;width: 150px;"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span>编辑</a><a href="#" class="list-group-item" style="color:#D9534F;width: 150px;" onclick="deleteFolder(${f.pid})"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除</a></div>'>
                                <img src="${pageContext.request.contextPath}/img/intercalate.png" />
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>


    </div>

</div>
<div class="container">
    <div class="row">
        <div class="col-lg-4 col-lg-offset-8 page">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${pageContext.request.contextPath}/folder/findList.do?page=1&size=${pageInfo.pageSize}&uid=${uid}"
                           aria-label="Previous">
                            <span aria-hidden="true">首页</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/folder/findList.do?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}&uid=${uid}">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:if test="${pageInfo.pages <= 10}">
                        <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                            <c:if test="${pageInfo.pageNum == pageNum}">
                                <li class="active"><a
                                        href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                </li>
                            </c:if>
                            <c:if test="${pageInfo.pageNum != pageNum}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${pageInfo.pages > 10}">
                        <c:if test="${pageInfo.pageNum < 6}">
                            <c:forEach begin="1" end="6" var="pageNum">
                                <c:if test="${pageInfo.pageNum == pageNum}">
                                    <li class="active"><a
                                            href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                    </li>
                                </c:if>
                                <c:if test="${pageInfo.pageNum != pageNum}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <li><a href="#">...</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum > pageInfo.pages-3}">
                            <li><a href="#">...</a></li>
                            <c:forEach begin="${pageInfo.pages-3}" end="${pageInfo.pages}" var="pageNum">
                                <c:if test="${pageInfo.pageNum == pageNum}">
                                    <li class="active"><a
                                            href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                    </li>
                                </c:if>
                                <c:if test="${pageInfo.pageNum != pageNum}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${pageInfo.pageNum >= 6 && pageInfo.pageNum <= pageInfo.pages-3}">
                            <li><a href="#">...</a></li>
                            <c:forEach begin="${pageInfo.pageNum-1}" end="${pageInfo.pageNum+1}" var="pageNum">
                                <c:if test="${pageInfo.pageNum == pageNum}">
                                    <li class="active"><a
                                            href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                    </li>
                                </c:if>
                                <c:if test="${pageInfo.pageNum != pageNum}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/folder/findList.do?page=${pageNum}&size=${pageInfo.pageSize}&uid=${uid}">${pageNum}</a>
                                    </li>
                                </c:if>
                            </c:forEach>

                            <li><a href="#">...</a></li>
                        </c:if>

                    </c:if>


                    <li>
                        <a href="${pageContext.request.contextPath}/folder/findList.do?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}&uid=${uid}">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/folder/findList.do?page=${pageInfo.pages}&size=${pageInfo.pageSize}&uid=${uid}"
                           aria-label="Next">
                            <span aria-hidden="true">尾页</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<input type="hidden" value="${uid}" id="uid">
</body>
<script type="text/javascript">
    layui.use('layer', function () {
        layer = layui.layer;
    });
    $('[data-toggle="popover"]').popover();
    $(function () {

        $('.linkandcode').click(function () {
            var c = "." + $(this).attr('name');
            $(c).html('');
            $(c).qrcode({
                render: "canvas",
                width: 120,
                height: 120,
                text: 'http://115.29.243.96:8080${pageContext.request.contextPath}/file/findPage.do?route=' + $(this).attr('name')
            });
            $('.link-input').val('http://115.29.243.96:8080${pageContext.request.contextPath}/file/findPage.do?route=' + $(this).attr('name'))
        });

        $('#arrTime').click(function () {
            var arr;
            if($('#arrTime').attr('name') == 0){
                arr = 'desc';
                $('#arrTime').prop('name','1');
            }else{
                $('#arrTime').prop('name','0');
                arr = 'asc';
            }
            $(window).attr('location','${pageContext.request.contextPath}/folder/selectByTime.do?arr='+arr+"&uid="+${uid});
        });

        $('.dropdown-model li').click(function () {
            $('.model-sort').text($(this).text());
            $('.dropdown-model li').css("backgroundColor","#fff");
            $(this).css("backgroundColor","#E6E6E6");
        });

        $('.dropdown-status li').click(function () {
            $('.search-status').text($(this).text());
            $('.dropdown-status li').css("backgroundColor","#fff");
            $(this).css("backgroundColor","#E6E6E6");
        });

    });

    function stopReason(pid) {
        var c = ".textarea"+pid;
        var a = ".deadline-a"+pid;
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/folder/stopReason.do',
            data: {
                "reason": $(c).val(),
                "pid": pid
            },
            success: function (res) {
                layer.msg(res.msg);
                $(a).popover('hide');
                setTimeout(function () {
                    window.location.reload();
                }, 500);
            }
        });
    }
    function restartReason(pid) {
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/folder/restart.do',
            data: {
                "pid": pid
            },
            success: function (res) {
                layer.msg(res.msg);
                setTimeout(function () {
                    window.location.reload();
                }, 500);
            }
        });
    }

    function restartTime(pid) {
        var c = ".deadline-a"+pid;
        $(c).popover('show');
    }
    function notime(pid) {
        var c = ".deadline-a"+pid;
        $(c).popover('hide');
    }
    function nostop(pid) {
        var c = ".stop-a"+pid;
        $(c).popover('hide');
    }
    function deleteFolder(pid) {
        layer.confirm('即将删除所有收件记录，确定要删除吗?',{btn:['确定删除','取消']},function () {
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/folder/deleteFolder.do',
                data: {
                    "pid": pid,
                    "uid":${uid}
                },
                success: function (res) {
                    layer.msg(res.msg);
                    setTimeout(function () {
                        window.location.reload();
                    }, 500);
                }
            });
        });

    }
    function changeTime(pid) {
        $.ajax({
            type: 'post',
            url: '${pageContext.request.contextPath}/folder/changeTime.do',
            data: {
                "deadline": $('.deadline-input').val(),
                "pid": pid
            },
            success: function (res) {
                layer.msg(res.msg);
                $('#left-time').text(res.ftime);
                var c = ".deadline-a"+pid;
                $(c).popover('hide');
                setTimeout(function () {
                    window.location.reload();
                }, 500);
            }
        });
    }

</script>
</html>