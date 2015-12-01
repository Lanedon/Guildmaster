/*var myModule = require('./module');*/

$("#buttonConnexion").on('click', function() {
	$("#popupConnexion").show();
});

$("#buttonInscription").on('click', function() {
	$("#popupInscription").show();
});

$(".close-popup").on('click', function() {
	var wrapper = $(this).parents('.popup-wrapper');
	wrapper.hide();
});

/*$('#donneUser').on('click', function() {
	alert(myModule.role);
})*/