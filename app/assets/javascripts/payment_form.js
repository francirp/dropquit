$(document).on('page:change', function(){

  if ( $('body').hasClass('application') ){

    $("#change-card").on('click', function(e){
      e.preventDefault();
      $("#card-form").show();
    });

  }
});
