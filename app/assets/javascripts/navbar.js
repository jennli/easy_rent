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


  // Slider Height
  var slideHeight = $(window).height();
  $('#home-carousel .carousel-inner .item, #home-carousel .video-container').css('height',slideHeight);

  $(window).on("resize", function(){
    $('#home-carousel .carousel-inner .item, #home-carousel .video-container').css('height',slideHeight);
  });


  // template

  initProgress('.progress');

  function initProgress(el){
    $(el).each(function(){
      var pData = $(this).data('progress');
      progress(pData,$(this));
    });
  }

  // on score fade bound effect
  $("#testimonial").owlCarousel({
    pagination : true, // Show bullet pagination
    slideSpeed : 300,
    paginationSpeed : 400,
    singleItem:true
  });

  wow = new WOW({
    animateClass: 'animated',
    offset: 100,
    mobile: false
  });
  wow.init();

});
