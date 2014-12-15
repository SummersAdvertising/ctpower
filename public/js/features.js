$('#content-2 .row .col-sm-4').css({opacity:0});
$('#content-2 .row').appear();
$(document.body).on('appear', '#content-2 .row', function(e, $affected) {
    $('#content-2 .row .col-sm-4').eq(0).animate({opacity:1},600);
  	$('#content-2 .row .col-sm-4').eq(1).delay(300).animate({opacity:1},600);
  	$('#content-2 .row .col-sm-4').eq(2).delay(600).animate({opacity:1},600);

});

$('#content-3 .cmp').css({opacity:0});
$('#content-3 .clearfix:eq(0)').appear();
$(document.body).on('appear', '#content-3 .clearfix:eq(0)', function(e, $affected) {
    $('#content-3 .clearfix:eq(0)').find('.cmp').eq(0).animate({opacity:1},800);
  	$('#content-3 .clearfix:eq(0)').find('.cmp').eq(1).delay(200).animate({opacity:1},800);
});
$('#content-3 .clearfix:eq(1)').appear();
$(document.body).on('appear', '#content-3 .clearfix:eq(1)', function(e, $affected) {
    $('#content-3 .clearfix:eq(1)').find('.cmp').eq(0).delay(400).animate({opacity:1},800);
  	$('#content-3 .clearfix:eq(1)').find('.cmp').eq(1).delay(600).animate({opacity:1},800);
});
$('#content-3 .clearfix:eq(2)').appear();
$(document.body).on('appear', '#content-3 .clearfix:eq(2)', function(e, $affected) {
    $('#content-3 .clearfix:eq(2)').find('.cmp').eq(0).delay(800).animate({opacity:1},800);
  	$('#content-3 .clearfix:eq(2)').find('.cmp').eq(1).delay(1000).animate({opacity:1},800);
});

$('#content-4 .row p').css({bottom:'-100px'});
$('#content-4 .row .col-sm-3').appear();
$(document.body).on('appear', '#content-4 .row .col-sm-3', function(e, $affected) {
    $('#content-4 .col-sm-3').eq(0).find('p').animate({bottom:'-10'},400);
  	$('#content-4 .col-sm-3').eq(1).find('p').delay(300).animate({bottom:'-10'},400);
  	$('#content-4 .col-sm-3').eq(2).find('p').delay(600).animate({bottom:'-10'},400);
  	$('#content-4 .col-sm-3').eq(3).find('p').delay(900).animate({bottom:'-10'},400);
});

$('#content-5 li').css({opacity:0});
$('#content-5 ol').appear();
$(document.body).on('appear', '#content-5 ol', function(e, $affected) {
		var x=0;
    for(var i=0;i<$('#content-5 li').length;i++){
    	x=i*300;
    	$('#content-5 li').eq(i).delay(x).animate({opacity:1},500);
    }
});

$('#content-6 .pull-right').css({opacity:0});
$('#content-6').appear();
$(document.body).on('appear', '#content-6', function(e, $affected) {
		$('#content-6 .pull-right').delay(1000).animate({opacity:1},800);
});


var trigger7 = 0;
$('#content-7 .col-sm-3').appear();
$(document.body).on('appear', '#content-7 .col-sm-3', function(e, $affected) {
  if(trigger7 == 0){
    $('.timer').each(count);
    trigger7 = 1;
  }
});
function count(options) {
  var $this = $(this);
  options = $.extend({}, options || {}, $this.data('countToOptions') || {});
  $this.countTo(options);
}

$('#ipr-1, #ipr-2, #ipr-3, #ipr-4, #ipr-5, #ipr-6, #ipr-7, #ipr-8').css({opacity:0});
$('#content-8 .text-center').appear();
$(document.body).on('appear', '#content-8 .text-center', function(e, $affected) {
		$('#ipr-1, #ipr-2, #ipr-3, #ipr-4').delay(500).animate({opacity:1},500);
		$('#ipr-5, #ipr-6, #ipr-7, #ipr-8').delay(1200).animate({opacity:1},500);
});



/*-------------------------------puzzle*/
var clickTag = [];
  $('#content-6 .pull-right a').each(function(i) {
    clickTag[i] = 0;
  });
$('#content-6 .pull-right a span').hide();
$('#content-6 .pull-right a').click(function(){
	var indexTag = $(this).index();
	var indexImg = $(this).index()+1;
	if(clickTag[indexTag]==0){
		$(this).find('img').attr('src','/images/icon_f0'+indexImg+'h.png');
		$(this).find('span').fadeIn(400);
		clickTag[indexTag] = 1;
	}else{
		$(this).find('img').attr('src','/images/icon_f0'+indexImg+'.png');
		$(this).find('span').fadeOut(400);
		clickTag[indexTag] = 0;
	}

});