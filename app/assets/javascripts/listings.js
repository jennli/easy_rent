$(document).on("ready", function(){

  // new listing form country state select
  $("body").on("change","select#listing_country", function(e){
    console.log("hello world");
    var select_wrapper = $('#listing_state_code_wrapper');
    $('select', select_wrapper).attr('disabled', true);
    var country = $(this).val();
    var url = "/orders/subregion_options?parent_region=" + country;
    select_wrapper.load(url);

  });

  // template
  // portfolio filtering
  $("#listings").mixItUp();

  //fancybox
  $(".fancybox").fancybox({
    padding: 0,
    openEffect : 'elastic',
    openSpeed  : 650,
    closeEffect : 'elastic',
    closeSpeed  : 550,
  });

});
