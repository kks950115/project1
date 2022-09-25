$(document).ready(function() {
  $('ul.dropdownmenu li ul').hide();

  $('ul.dropdownmenu').hover(
  function() { 
      $('ul.dropdownmenu li.menu ul').fadeIn('slow',function(){$(this).stop();});
      $('.header_wapper').animate({height:200},'fast').clearQueue();
      },
      function() {
      $('ul.dropdownmenu li.menu ul').fadeOut('fast');
      $('.header_wapper').animate({height:200},'fast').clearQueue();
      });
  
});
