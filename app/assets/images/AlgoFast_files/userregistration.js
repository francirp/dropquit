
$( document ).ready(function() {
  $( document ).on( "change", "#algofast_user_email", function() {
    var email = $("#algofast_user_email").val();
    var url = "/checkemail?checkemail="+email;
    $.get( url, function( data ) {

      $("#email_flag").val($.trim(data));
    });
  });
});


$.validator.addMethod("regx", function(value, element, regexpr) {
  return regexpr.test(value);
}, "must contain one capital, lower case, and number each.");
function validateFirstPage(){
  validator = $('#new_algofast_user').validate({
    rules: {
      algofast_user_first_name:{ required:true},
      ans_1: {required: true},
      ans_2: {required: true},
      ans_3: {required: true},
      algofast_user_last_name:{ required:true},
      algofast_user_email: { required:true,email:true},
      algofast_user_password: { required:true,minlength:8, regx: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/ },
      algofast_user_password_confirmation: { required:true,minlength:8,equalTo:"#algofast_user_password" },
      algofast_user_street:{ required:true},
      algofast_user_city:{ required:true},
      algofast_user_state: { required:true},
      algofast_user_zipcode: { required:true,number:true,maxlength:5,minlength:5 },
      algofast_user_phone: { required:true,number:true } ,
      recaptcha_response_field: {required:true},
      agUserSignature: { required:true}

    },
    messages: {
      algofast_user_first_name:{ required: "Please enter First Name"},
      algofast_user_last_name: { required: "Please enter Last Name"},
      algofast_user_email:   { required: "Please enter Email",email:"Please enter valid Email(ex: test@test.com)"},
      algofast_user_password:{ required: "Please enter Password",minlength:"Password should be 8 or more characters" },
      algofast_user_password_confirmation: { required: "Please enter Confirm Password",
      minlength: "Passwords do not match",
      equalTo: "Passwords do not match"
    },

    algofast_user_street:{ required: "Please enter Street"},
    algofast_user_city:{ required: "Please enter City"},
    algofast_user_state: { required: "Please enter State"},
    algofast_user_zipcode: { required: "Please enter Zip" ,  number: "Please enter a valid number", maxlength: "5 chars", minlength: "5 chars" },
    algofast_user_phone: { required: "Please enter Phone no" , number: "Please enter a valid number" },
    ans_1: {required: "Please enter answer"},
    ans_2: {required: "Please enter answer"},
    ans_3: {required: "Please enter answer"},
    recaptcha_response_field: {required: "Please enter the words in the captcha"},
    agUserSignature: {required: "Please specify your Signature"}
  }

});
$("#algofast_user_email").rules("add", {
  email:true
});
$("#algofast_user_zipcode").rules("add", {
  minlength:5,
  number:true
});
$("#algofast_user_password").rules("add", {
  minlength:8,
  regx: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/
});
$("#algofast_user_password_confirmation").rules("add", {
  minlength:8,
  equalTo:algofast_user_password
});
$("#algofast_user_phone").rules("add", {
  minlength:10,
  number:true
});
var resultValidation = validator.form();
var email_flag = $.trim($("#email_flag").val());
var agUserEmail = $("#algofast_user_email").val();

if(resultValidation && email_flag =="1"){
  $("#error_explanation1").html("").fadeOut();
  return resultValidation;
}else{
  if(agUserEmail != "" && email_flag !="1"){
    var error_msg = "Email already exists";
    $("#error_explanation1").html(error_msg).fadeIn();
  } else{
    $("#error_explanation1").html("").fadeOut();
  }

  return false;
}


}

function validateSecondPage(){
  var fields = $("input[name='prdAgg[]']").serializeArray();
  if (fields.length < $("input[name='prdAgg[]']").length)
  {

    $('#error_explanation2').html('You must agree to all terms');
    $('#error_explanation2').show();

    return false;
  }
  else
  {

    $('#error_explanation2').hide();
  }

  if(validator.form()){
    checkRecaptch();
  }
  return true;

}
function checkRecaptch(){
  var challengeField = $("#recaptcha_challenge_field").val();
  var responseField = $("#recaptcha_response_field").val();

  $.ajax({
    type: "POST",
    url: "/checkCaptcha",
    dataType: "json",
    data: "recaptcha_challenge_field="+challengeField+ "&amp;recaptcha_response_field="+responseField,

    success: function(data) {
      /* alert('response from recaptcha'+data);*/
      $("#error_explanation").html("").fadeOut();
      if(data)  {

       /*     alert("true");*/
     }
     else
     {
      var error_msg = "Invalid recaptcha";
      $("#error_explanation").html(error_msg).fadeIn();
      Recaptcha.reload();
      $("#error_explanation").html(error_msg).fadeOut();
    }
  },
  error: function() {
    $("#error_explanation").show();
  }
});

}



function userSignup() {

  $.ajax({
    type : 'GET',
    url : "/webusersignup",
    data : $('#new_algofast_user').serialize(),
    error : function() {
    },
    success : function(data) {
            // alert("success\t"+data);
            $('#error_explanation').hide();
            var obj = data;
            var newssource = obj.signupdata.newssource;

            var newsSourceDivData = "<div class=\"popTablerow\"><div class=\"left text-left popTablesubhead\">News Source</div><div class=\"right text-right popTablesubhead\">Subscribe</div></div>";
            $.each(newssource, function(i, news) {

              newsSourceDivData = newsSourceDivData + "<div class=\"popTablerow\"><div class=\"left text-left\">" + (i + 1) + ". " + news.name + "</div>";
              newsSourceDivData = newsSourceDivData + "<div class=\"right text-right\">";

              newsSourceDivData = newsSourceDivData + "<input  type=\"checkbox\" id=\"news_sources"+news.id+"\" name=\"news_sources[]\" value='" + news.id+ "' class=\"er require-one\" />";
              newsSourceDivData = newsSourceDivData + "<label for=\"news_sources" + news.id + "\"><div></div></label></div></div>";

            });
            $('#newsSourceData').html(newsSourceDivData);
            //alert($('#newsSourceData').html());
          },
          complete : function() {
            // alert("complete");
          }
        });
return true;

}

function GetNewsSourceAgreements(){

  $.ajax({
    type : 'POST',
    url : "/getNewsSourceAgreements",
    data : $('#new_algofast_user').serialize(),
    error : function() {
      alert("error");
    },
    success : function(data) {
      var div_data = "<div class=\"popTablerow\"><div class=\"left text-left popTablesubhead\">Agreement</div><div class=\"right text-right popTablesubhead\">Agree</div></div>";
      $.each(data, function(i, prdagg) {

        div_data = div_data + "<div class=\"popTablerow\"><div class=\"left text-left\">" + (i + 1) + ". ";
        div_data = div_data + "  <a alt='Agreement'  target='_blank' onclick='openAgreementPopup("+prdagg.id +")'> " + prdagg.name ;

        div_data = div_data +" </a>"+ "</div>";
        div_data = div_data + "<div class=\"right text-right\"><input type=\"checkbox\" id=\"agg_" + prdagg.id + "\" value='"+prdagg.id+"'  name=\"prdAgg[]\" class=\"er\"/><label for=\"agg_" + prdagg.id + "\"><div></div></label></div></div>";

      });
      $('#aggMasterData').html(div_data);


    },
    complete : function() {
            //alert("complete");
            /*$('#popup4').show();*/
          }
        });

return true;
}


function openAgreementPopup(prd_agr_id) {
	var strWindowFeatures = "menubar=no,location=no,resizable=yes,scrollbars=no,status=yes,width=620,height=600";

	windowObjectReference = window.open("/pdf_agreement?agg_id=" + prd_agr_id, "agreement", strWindowFeatures);
}

;
