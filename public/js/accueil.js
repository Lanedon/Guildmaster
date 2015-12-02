/*var myModule = require('./module');*/

$("#buttonConnexion").on('click', function() {
	$("#popupConnexion").show();
	$("#popup-background").show();
});

$("#buttonInscription").on('click', function() {
	$("#popupInscription").show();
	$("#popup-background").show();
});

$(".close-popup").on('click', function() {
	var wrapper = $(this).parents('.popup-wrapper');
	wrapper.hide();
	$("#popup-background").hide();
});

/*$('#donneUser').on('click', function() {
	alert(myModule.role);
})*/