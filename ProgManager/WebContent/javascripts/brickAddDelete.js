// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var brick;
    brick = "<div class='brick small'></div>";
    $(document).on("click", ".gridly .brick", function(event) {
      var $this, size;
      var sizeflag;
      event.preventDefault();
      event.stopPropagation();
      $this = $(this);
      $this.toggleClass('small');
      $this.toggleClass('large');
      if ($this.hasClass('small')) {
        size = 140;
      }
      if ($this.hasClass('large')) {
        size = 300;
      }
      $this.data('width', size);
      $this.data('height', size);
      var jsonProject = eval("("+this.getAttribute('value')+")");
//      var jsonProject = JSON.parse(this.getAttribute('value'));
//      alert(this.getAttribute('value'));
      alert(jsonProject);
      var clickid = this.getAttribute('id');
      if($this.hasClass('large')){
         /*document.getElementById("contents"+clickid).innerHTML="프로젝트 제목 : "+this.getAttribute('value'). + "<br>"
         														+"담당자 Id : "+this.getAttribute('value').pmento+"<br>"
         														+"프로젝트 시작일 : "+this.getAttribute('value').pstart+"<br>";*/
    	  
    	  document.getElementById("contents"+clickid).innerHTML = "프로젝트 제목 : "+jsonProject.pname+"프로젝트 제목 : ";
      }
      if($this.hasClass('small')){
     /*    document.getElementById("contents"+clickid).innerHTML=this.getAttribute('value').pname;*/
      }
      
      var value = this.getElementById
      
      return $('.gridly').gridly('layout');
    });
    $(document).on("click", ".gridly .delete", function(event) {
      var $this;
      event.preventDefault();
      event.stopPropagation();
      $this = $(this);
      $this.closest('.brick').remove();
      return $('.gridly').gridly('layout');
    });
    $(document).on("click", ".cancel", function(event){
    	event.preventDefault();
    	event.stopPropagation();
    	document.getElementById("createProjectPop").style.display="none";
    })
    $(document).on("click", ".add", function(event) {
      event.preventDefault();
      event.stopPropagation();
      $('.gridly').append(brick);
	  document.getElementById("createProjectPop").style.display="none";
      return $('.gridly').gridly();
    });
    return $('.gridly').gridly();
  });

}).call(this);
