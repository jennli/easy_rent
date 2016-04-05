$(document).ready(function() {

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
