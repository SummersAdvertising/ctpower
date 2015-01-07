$(document).ready(function(e) {
	/*menu effect*/
	$('nav ul li').hover(function(){
			if($(window).width()>768){
				$(this).find('.dropdown-menu').stop(true,true).fadeIn(400);
			}
	},function(){
			if($(window).width()>768){
				$(this).find('.dropdown-menu').stop(true,true).fadeOut(400);
			}
	});

	$(window).resize(function(){
			$('nav ul li').hover(function(){
					if($(window).width()>768){
						$(this).find('.dropdown-menu').stop(true,true).fadeIn(400);
					}
			},function(){
					if($(window).width()>768){
						$(this).find('.dropdown-menu').stop(true,true).fadeOut(400);
					}
			});
	});
});