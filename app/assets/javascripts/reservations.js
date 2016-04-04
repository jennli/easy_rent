$(document).on("ready", function(){
  $("#checkin-date, #checkout-date").datepicker({
    minDate: new Date(),
    dateFormat: 'yy-MM-dd',
  }).on("changeDate", function(){
    $(this).datepicker('hide');
  });

  
});
