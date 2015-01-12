$(document).ready(function(e) {
	/*menu effect*/
	function menu(){
		$('nav ul li').hover(function(){
				if($(window).width()>768 && (/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i.test(navigator.userAgent)==false)){
					$(this).find('.dropdown-menu').stop(true,true).fadeIn(400);
				}
		},function(){
				if($(window).width()>768 && (/(iPad)|(iPhone)|(iPod)|(android)|(webOS)/i.test(navigator.userAgent)==false)){
					$(this).find('.dropdown-menu').stop(true,true).fadeOut(400);
				}
		});
	}
	menu();
	$(window).resize(function(){
			menu();
	});
});