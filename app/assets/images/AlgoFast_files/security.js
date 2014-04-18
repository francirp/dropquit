$('#cq_wrap').hide();

$('#cq_id').on('click',function(){
  $('#cq1').show();
  $('#cq2').hide();
  $('#cq3').hide();
  $('#cq4').hide();

  $('#sc_cq1').on('click',function(){
    $('#cq1').hide();
    $('#cq2').show();
    $('#cq3').hide();
    $('#cq4').hide();
  });

  $('#sc_cq2').on('click',function(){
    $('#cq1').hide();
    $('#cq2').hide();
    $('#cq3').show();
    $('#cq4').hide();
  });

  $('#sc_cq3').on('click',function(){
    $('#cq1').hide();
    $('#cq2').hide();
    $('#cq3').hide();
    $('#cq4').show();
  });

  $('#backstep1').on('click',function(){
    $('#cq1').show();
    $('#cq2').hide();
    $('#cq3').hide();
    $('#cq4').hide();
  });

  $('#backstep2').on('click',function(){
    $('#cq1').hide();
    $('#cq2').show();
    $('#cq3').hide();
    $('#cq4').hide();
  });

  $('#backstep3').on('click',function(){
    $('#cq1').hide();
    $('#cq2').hide();
    $('#cq3').show();
    $('#cq4').hide();
  });

  $('#backstep4').on('click',function(){
    $('#cq1').hide();
    $('#cq2').hide();
    $('#cq3').hide();
    $('#cq4').show();
  });
});
