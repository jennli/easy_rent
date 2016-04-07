$(document).on("ready", function(){
  // $(".datepicker").datepicker({
  //   minDate: new Date(),
  //   mode: 'range',
  //   dateFormat: 'yy-MM-dd',
  // });
  var invalid_dates;

  $(".datepicker").daterangepicker({
    minDate: new Date(),
    locale: {
      format: 'DDMMMYYYY'
    },
    isInvalidDate: function(date){
      for(var ii = 0; ii < invalid_dates.length; ii++){
        if (date.format('YYYY-MM-DD') == invalid_dates[ii]){
          return true;
        }
      }
    }
  });
  init();

  $("#reservation-range").on("change", function(){
    init();
  });

  function init(){
    getSelectedDates();
    checkReservedDates();
  }

  function getSelectedDates(){
    if($("#reservation-range").val() !== ""){
      var range = $("#reservation-range").val().split("-");
      var checkin = range[0].replace(/ /g,'');
      var checkout = range[1].replace(/ /g,'');
      $("#checkin-param").val(checkin);
      $("#checkout-param").val(checkout);
    }
  }

  function checkReservedDates(){
    $.get('http://localhost:3000/listings/' + $(".datepicker").data("lid") +'/reserved_dates.json', function(reserved_dates) {
      invalid_dates = reserved_dates;
    });
  }


  //
  // $(".datepicker").on("change", function(){
  //
  //   if($("#checkin-date").val() && $("#checkout-date").val()){
  //
  //     var checkin = Date.parse($("#checkin-date").val());
  //     var checkout = Date.parse($("#checkout-date").val());
  //     var oneDay = 24*60*60*1000;
  //     var days = (checkout - checkin)/oneDay ;
  //
  //     if (days <= 0){
  //       toastr.error(
  //         "your checkout date must be after checkin date!",
  //         {
  //           "closeButton": true,
  //           "positionClass": "toast-top-full-width",
  //           "timeOut": "0",
  //           "extendedTimeOut": "0",
  //         });
  //
  //         $("#proceed-to-payment-button").attr("disabled", true);
  //       }
  //       else{
  //         $("#proceed-to-payment-button").attr("disabled", false);
  //       }
  //
  //     }
  //   });
});
