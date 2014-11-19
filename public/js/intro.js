$(document).ready(function(e) {
	/*menu effect*/
	checkScroll = 0;
	var scrollY = $(window).scroll(function(){
		if((scrollY.scrollTop() >= 500) &&(checkScroll == 0)){
			$('#sideMenu').stop(true,true).animate({top:200,opacity:1},800);
			checkScroll = 1;	
		}
		if((scrollY.scrollTop() < 400) &&(checkScroll == 1)){
			$('#sideMenu').stop(true,true).animate({top:-400,opacity:0},800);
			checkScroll = 0;
		}
		if(scrollY.scrollTop() >= 3747){
			$('#btn04').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn04').parent('li').addClass('active');
		}else if(scrollY.scrollTop() >= 2934){
			$('#btn03').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn03').parent('li').addClass('active');
		}else if(scrollY.scrollTop() >= 1474){
			$('#btn02').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn02').parent('li').addClass('active');
		}else if(scrollY.scrollTop() >= 500){
			$('#btn01').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn01').parent('li').addClass('active');
		}
    });
	

	$('#btn01').click(function(){
		$('html, body').animate({scrollTop: 767}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn02').click(function(){
		$('html, body').animate({scrollTop: 1810}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn03').click(function(){
		$('html, body').animate({scrollTop: 3338}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn04').click(function(){
		$('html, body').animate({scrollTop: 4157}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn05').click(function(){//alert(scrollY.scrollTop());
		$('html, body').animate({scrollTop: 0}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	
	/*color*//*
	$('.colorTag ul li').click(function(){
		var colorStyle = $(this).index()+1;
		$('.motoImg img').css({'opacity':0});
		$('.motoImg img').attr('src','/sample/moto0'+colorStyle+'.png');
		$('.motoImg img').animate({'opacity':1},600);
	});*/
});