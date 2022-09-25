$(document).ready(function(){
	jQuery( '#top_btn' ).click( function() {
	    var htmloffset = jQuery( 'html' ).offset();
	    jQuery( 'html, body' ).animate( { scrollTop : htmloffset.top }, 400 );
	});
});