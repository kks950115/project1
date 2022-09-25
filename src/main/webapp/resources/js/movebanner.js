// JavaScript Document

$(document).ready(function() {
   var position=0;  //최초위치
   var movesize=2; //이미지 하나의 너비
   var timeonoff;
   
   $('.partnerBox ul').after($('.partnerBox ul').clone());
   
   function partnerMove(){
        position-=movesize;  // 150씩 감소
    	$('.partnerBox').css('left',position);
		
		 if(position < -1890){
			   $('.partnerBox').css('left',00);
			   position=0;
		 } 
		
   };

     timeonoff= setInterval(partnerMove, 20);
    
   	$('.partnerBox').hover(function(){
		clearInterval(timeonoff);
	},function(){
		timeonoff= setInterval(partnerMove, 20);	
	});
	
    
 });