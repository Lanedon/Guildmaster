/*var myModule = require('./module');*/


function verifAction() {
    confirm("Etes vous sur de vouloir continuer ?");
}

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


$(".buttonModifUtilisateur").on('click', function() {
	var id = $(this).data('id');
	$("#popupModif").show();
	$("#popup-background").show();
	$("#idModif").val($(".id[data-id='"+id+"']").html());
	$("#pseudoModif").val($(".pseudo[data-id='"+id+"']").html());
	$("#guildModif").val($(".guild[data-id='"+id+"']").html());
	$("#emailModif").val($(".email[data-id='"+id+"']").html());
	$("#prestigeModif").val($(".prestige[data-id='"+id+"']").html());
	$("#goldModif").val($(".gold[data-id='"+id+"']").html());
	$("input:first").focus();
});

$(".buttonModifQuete").on('click', function() {
	var id = $(this).data('id');
	$("#popupModifQuete").show();
	$("#popup-background").show();
	$("#idModifQuete").val($(".idQuest[data-id="+id+"]").html());
	$("#nameModif").val($(".name[data-id="+id+"]").html());
	$("#summaryModif").val($(".summary[data-id="+id+"]").html());
	$("#experienceModif").val($(".experience[data-id="+id+"]").html());
	$("#dureeModif").val($(".duree[data-id="+id+"]").html());
	$("#difficultyModif").val($(".difficulty[data-id="+id+"]").html());
	$("#goldModif").val($(".gold[data-id="+id+"]").html());
	$("input:first").focus();
});


$(".buttonAjoutQuete").on('click', function() {
	var id = $(this).data('id');
	$("#popupAjoutQuete").show();
	$("#popup-background").show();
	$("input:first").focus();
});

$(".close-popup").on('click', function() {
	var wrapper = $(this).parents('.popup-wrapper');
	wrapper.hide();
	$("#popup-background").hide();
});

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