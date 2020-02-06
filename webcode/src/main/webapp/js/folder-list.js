$(function () {
    $('.right-add button').click(function () {
        var uid = $('#uid').val();
        $(window).attr('location','../folder/diy.do?uid='+uid);

    });
});