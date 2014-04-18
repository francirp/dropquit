jQuery(document).ready(function($){
	var wpw = $(window).width();
	if (wpw == 600) {
		$("#container").addClass('gnex_pm');
		}
	if (wpw == 768) {
		$("#container").addClass('ipad_pm');
		}
	/* prepend menu icon */
	$('.logowrap img').after('<div id="menu-icon"></div>');
	
	/* toggle nav */
	$("#menu-icon").on("click", function(){
		$("ul#nav").slideToggle();
		//$(this).toggleClass("active");
	});
	/* Mobile navigation top position */
	var th = $('.top-bar').height();
	$('ul#nav').css('top', th );
});