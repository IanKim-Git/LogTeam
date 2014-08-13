//main.html에서 버튼 리스너 등록 스크립트
$(function() {
    var button = $('#createProject');
    var box = $('#createProjectBox');
 //   var form = $('#loginForm');
    button.removeAttr('href');
    button.mouseup(function(login) {
        box.toggle();
        button.toggleClass('active');
    });
    $(this).mouseup(function(login) {
        if(!($(login.target).parent('#createProject').length > 0)) {
            button.removeClass('active');
            box.hide();
        }
    });
});
