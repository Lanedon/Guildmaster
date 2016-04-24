/*var myModule = require('./module');*/
$(document).ready ( function () {
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

    $('.attr-minus').on('click', function () {
    	var value = $(this).parent().find('span').text();
    	var limite = $(this).parent().find('div').text();
    	if (value > limite) {
	    	var points = $("#pointsAttributs").text();
	    	if (value >= 1 && points >= 1) {
	    		$(this).parent().find('span').text(value-1);
	    		$("#pointsAttributs").text(parseInt(points)+1);

	    		if ($(this).parent().find('span').text() == limite)
	    			$(this).prop("disabled", true);
	    	}
	    }
    });

    $('.attr-plus').on('click', function () {
    	var value = $(this).parent().find('span').text();
    	var points = $("#pointsAttributs").text();
    	var limite = $(this).parent().find('div').text();
    	if (value >= 1 && points >= 1) {
    		$(this).parent().find('span').text(parseInt(value)+1);
    		$("#pointsAttributs").text(points-1);
    		if ($(this).parent().find('span').text() > limite)
	    			$(this).parent().find('.attr-minus').prop("disabled", false);
    	}
    });
});