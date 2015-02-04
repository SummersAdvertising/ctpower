$(document).ready(function(e) {
	/*menu effect*/
	checkScroll = 0;
	if(!$('.accessory')[0]){
		$('#btn04').parent('li').hide();
	}else{
		$('#btn04').parent('li').show();
	}
	var scrollY = $(window).scroll(function(){
		if((scrollY.scrollTop() >= 500) &&(checkScroll == 0)){
			$('#sideMenu').stop(true,true).animate({top:200,opacity:1},800);
			checkScroll = 1;	
		}
		if((scrollY.scrollTop() < 400) &&(checkScroll == 1)){
			$('#sideMenu').stop(true,true).animate({top:-400,opacity:0},800);
			checkScroll = 0;
		}
		if(scrollY.scrollTop() >= $('#accessory').offset().top-200){
			$('#btn04').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn04').parent('li').addClass('active');
		}else if(scrollY.scrollTop() >= $('#spec').offset().top-200){
			$('#btn03').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn03').parent('li').addClass('active');
		}else if(scrollY.scrollTop() >= $('#feature').offset().top-200){
			$('#btn02').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn02').parent('li').addClass('active');
		}else if(scrollY.scrollTop() >= $('#color').offset().top-200){
			$('#btn01').parent('li').addClass('active').siblings('.active').removeClass('active');
			$('#btn01').parent('li').addClass('active');
		}
    });
	

	$('#btn01').click(function(){
		$('html, body').animate({scrollTop: $('#color').offset().top}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn02').click(function(){
		$('html, body').animate({scrollTop: $('#feature').offset().top}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn03').click(function(){
		$('html, body').animate({scrollTop: $('#spec').offset().top}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn04').click(function(){
		$('html, body').animate({scrollTop: $('#accessory').offset().top}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	$('#btn05').click(function(){//alert(scrollY.scrollTop());
		$('html, body').animate({scrollTop: 0}, 500);
		$(this).parent('li').addClass('active').siblings('.active').removeClass('active');
		$(this).parent('li').addClass('active');
	});
	

});