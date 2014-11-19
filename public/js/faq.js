$(document).ready(function(e) {
	/*faq effect*/
	var tag = [];
	$('#faq02 .tab-content .qaBlock').each(function(i) {
	  tag[i] = 0;
	});


	$('#faq02 .tab-content .qaBlock .answ').hide();
	$('#faq02 .tab-content .qaBlock').click(function(){
	  	var x = $(this).index('.qaBlock');
	  	
		if(tag[x] == 0){
			$(this).css({'border-color':'#f47979'});
			$(this).find('.answ').slideDown();
			$(this).find('.ques').addClass('open').css({color:'#f47979'});
			tag[x] = 1;
		}else{
			$(this).css({'border-color':'#a2a2a2'});
			$(this).find('.answ').slideUp();
			$(this).find('.ques').removeClass('open').css({color:'#000'});
			tag[x] = 0;
		}
		
		
	});
});



