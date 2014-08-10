// Login Form
$(function() {
    var button = $('#loginButton');
    var box = $('#loginBox');
    var form = $('#loginForm');
    button.removeAttr('href');
    button.mouseup(function(login) {
        box.toggle();
        button.toggleClass('active');
    });
    form.mouseup(function() { 
        return false;
    });
    $(this).mouseup(function(login) {
        if(!($(login.target).parent('#loginButton').length > 0)) {
            button.removeClass('active');
            box.hide();
        }
    });
});

//Join Form
$(function() {
    var button = $('#JoinButton');
    var box = $('#JoinBox');
    var form = $('#JoinForm');
    button.removeAttr('href');
    button.mouseup(function(Join) {
        box.toggle();
        button.toggleClass('active');
    });
    form.mouseup(function() { 
        return false;
    });
    $(this).mouseup(function(Join) {
        if(!($(Join.target).parent('#JoinButton').length > 0)) {
            button.removeClass('active');
            box.hide();
        }
    });
});
