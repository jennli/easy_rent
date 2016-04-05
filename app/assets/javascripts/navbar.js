$(document).ready(function() {

  if ($("#home-carousel").length == 0 ){
    $("#navigation").css("background-color","rgb(21, 105, 128)");
    $("#navigation").addClass("animated-nav");
  }

  $(window).on("scroll",function() {
    if (($(window).scrollTop() > 400) || ($("#home-carousel").length == 0 )){
      $("#navigation").css("background-color","rgb(21, 105, 128)");
      $("#navigation").addClass("animated-nav");
    }
    else if($("#home-carousel").length >0){
      $("#navigation").css("background-color","transparent");
      $("#navigation").removeClass("animated-nav");
    }
  });

  $(".dropdown-toggle").on("click", function(e){
    $(".dropdown").toggleClass("open");
    $(".dropdown").addClass("current");
  });

  $(".navbar li").on("mouseenter", function(){
    console.log("enter");
    $(this).addClass("active");
  });

  $(".navbar li").on("mouseleave", function(){
    console.log('leave');
    $(this).removeClass("active");
  });

});
