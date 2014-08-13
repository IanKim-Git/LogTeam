//main.html���� ��ư ������ ��� ��ũ��Ʈ
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

//main.html���� ��ư ������ ��� ��ũ��Ʈ
$(function() {
    var button = $('#joinProject');
    var box = $('#joinProjectBox');
 //   var form = $('#loginForm');
    button.removeAttr('href');
    button.mouseup(function(login) {
        box.toggle();
        button.toggleClass('active');
    });
    $(this).mouseup(function(login) {
        if(!($(login.target).parent('#joinProject').length > 0)) {
            button.removeClass('active');
            box.hide();
        }
    });
});
