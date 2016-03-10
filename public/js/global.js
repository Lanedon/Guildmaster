/*var myModule = require('./module');*/

$("#buttonConnexion").on('click', function() {
	$("#popupConnexion").show();
	$("#popup-background").show();
	$("input:first").focus();
});

$("#buttonInscription").on('click', function() {
	$("#popupInscription").show();
	$("#popup-background").show();
	$("input:first").focus();
});

$(".close-popup").on('click', function() {
	var wrapper = $(this).parents('.popup-wrapper');
	wrapper.hide();
	$("#popup-background").hide();
});

/*$('#donneUser').on('click', function() {
	alert(myModule.role);
})*/

$('#createGuild').on('click', function(){
	$.ajax({
        url: '/createGuild',
        
        success: function(data) {
            $("#test").append(data);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert('error ' + textStatus + " " + errorThrown);
        }
    });
});