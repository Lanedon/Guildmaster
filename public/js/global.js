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
	$("#procDexModif").val($(".procDex[data-id="+id+"]").html());
	$("#procStrModif").val($(".procStr[data-id="+id+"]").html());
	$("#procEndModif").val($(".procEnd[data-id="+id+"]").html());
	$("#procLukModif").val($(".procLuk[data-id="+id+"]").html());
	$("#procIntModif").val($(".procInt[data-id="+id+"]").html());
	$("#experienceModif").val($(".experience[data-id="+id+"]").html());
	$("#dureeModif").val($(".duree[data-id="+id+"]").html());
	$("#difficultyModif").val($(".difficulty[data-id="+id+"]").html());
	$("#goldModif").val($(".gold[data-id="+id+"]").html());
	$("input:first").focus();
});


$(".buttonModifArmure").on('click', function() {
	var id = $(this).data('id');
	$("#popupModifArmure").show();
	$("#popup-background").show();
	$("#idModifArmure").val($(".idEquipment[data-id="+id+"]").html());
	$("#nameModif").val($(".name[data-id="+id+"]").html());
	$("#slotModif").val($(".slot[data-id="+id+"]").html());
	$("#buyableModif").val($(".buyable[data-id="+id+"]").html());
	$("#rarityModif").val($(".rarity[data-id="+id+"]").html());
	$("#priceModif").val($(".price[data-id="+id+"]").html());
	$("#minDexModif").val($(".minDex[data-id="+id+"]").html());
	$("#minStrModif").val($(".minStr[data-id="+id+"]").html());
	$("#minEndModif").val($(".minEnd[data-id="+id+"]").html());
	$("#minLukModif").val($(".minLuk[data-id="+id+"]").html());
	$("#minIntModif").val($(".minInt[data-id="+id+"]").html());
	$("#bonusDexModif").val($(".bonusDex[data-id="+id+"]").html());
	$("#bonusStrModif").val($(".bonusStr[data-id="+id+"]").html());
	$("#bonusEndModif").val($(".bonusEnd[data-id="+id+"]").html());
	$("#bonusLukModif").val($(".bonusLuk[data-id="+id+"]").html());
	$("#bonusIntModif").val($(".bonusInt[data-id="+id+"]").html());
	$("#protectionModif").val($(".protection[data-id="+id+"]").html());
	$("input:first").focus();
});

$(".buttonAjoutArmure").on('click', function() {
	$("#popupAjoutArmure").show();
	$("#popup-background").show();
	$("input:first").focus();
});

$(".buttonModifArme").on('click', function() {
	var id = $(this).data('id');
	$("#popupModifArme").show();
	$("#popup-background").show();
	$("#idModifArme").val($(".idEquipment[data-id="+id+"]").html());
	$("#nameModif").val($(".name[data-id="+id+"]").html());
	$("#distanceModif").val($(".distance[data-id="+id+"]").html());
	$("#buyableModif").val($(".buyable[data-id="+id+"]").html());
	$("#rarityModif").val($(".rarity[data-id="+id+"]").html());
	$("#priceModif").val($(".price[data-id="+id+"]").html());
	$("#minDexModif").val($(".minDex[data-id="+id+"]").html());
	$("#minStrModif").val($(".minStr[data-id="+id+"]").html());
	$("#minEndModif").val($(".minEnd[data-id="+id+"]").html());
	$("#minLukModif").val($(".minLuk[data-id="+id+"]").html());
	$("#minIntModif").val($(".minInt[data-id="+id+"]").html());
	$("#bonusDexModif").val($(".bonusDex[data-id="+id+"]").html());
	$("#bonusStrModif").val($(".bonusStr[data-id="+id+"]").html());
	$("#bonusEndModif").val($(".bonusEnd[data-id="+id+"]").html());
	$("#bonusLukModif").val($(".bonusLuk[data-id="+id+"]").html());
	$("#bonusIntModif").val($(".bonusInt[data-id="+id+"]").html());
	$("#minDamageModif").val($(".minDamage[data-id="+id+"]").html());
	$("#maxDamageModif").val($(".maxDamage[data-id="+id+"]").html());
	$("input:first").focus();
});

$(".buttonAjoutArme").on('click', function() {
	$("#popupAjoutArmure").show();
	$("#popup-background").show();
	$("input:first").focus();
});


$(".buttonAjoutQuete").on('click', function() {
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
	if (parseInt(value) > parseInt(limite)) {
		var points = $("#pointsAttributs").text();
		if (parseInt(value) >= 1) {
			$(this).parent().find('span').text(parseInt(value)-1);
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
	if (points >= 1) {
		$(this).parent().find('span').text(parseInt(value)+1);
		$("#pointsAttributs").text(points-1);
		if ($(this).parent().find('span').text() > limite)
				$(this).parent().find('.attr-minus').prop("disabled", false);
	}
});

$('.enregistrer-attributs').on('click', function () {
	var data = {};
	data.idCrew = $('#idCrew').val();
	data.nbFor = $('#nbFor').text();
	data.nbDex = $('#nbDex').text();
	data.nbEnd = $('#nbEnd').text();
	data.nbInt = $('#nbInt').text();
	data.nbLuk = $('#nbLuk').text();

	$.ajax({
        url: '/guildmaster/enregistrer-attributs',
        type: 'POST',
		data: data,
        success: function (data) {
            /*var ret = jQuery.parseJSON(data);
            $('body').html(ret.msg);
            console.log('Success: ')*/
            if (data == "Erreur") {
            	alert('Vous avez commis une erreur, veuillez réessayer !');
            } else if (data == "Fail") {
            	alert('La connection à la base de données est impossible, veuillez réesayer plus tard !')
            } else if (data == "OK") {
            	alert('Changements enregistrés !');
            }
            location.reload();
        },
        error: function (xhr, status, error) {
            /*console.log('Error: ' + error.message);
            $('body').html('Error connecting to the server.');*/
            alert('Erreur !');
            location.reload();
        },
    });
});

$('.placer-item').on('click', function() {
	$('.itemChoisi').removeClass('itemChoisi');
	$('.color-row-equipement').removeClass('green-row');
	$('.color-row-equipement').find('.fleche-equip').hide();
	$(this).parent().parent().parent().parent().parent().addClass('itemChoisi');

	var slot = $(this).parent().parent().find('.slot').text();
	if (slot == 'hand' || slot == 'hands') {
		$('#handLeft').addClass('green-row');
		$('#handRight').addClass('green-row');
	} else {
		$('#' + slot).addClass('green-row');
	}
	
	$('.green-row').find('.fleche-equip').show();

});

$('.fleche-equip').on('click', function() {
	var idEquip = $('.itemChoisi').find('.idEquipement').text();
	var slotItem = $('.itemChoisi').find('.slot').text();
	var slot = $(this).parent().parent().parent().attr('id');
	var data = {};
	data.idCrew = $('#idCrew').val();
	data.slot = slot;
	data.slotItem = slotItem;
	data.idEquip = idEquip;
	console.log(data);
	$.ajax({
        url: '/guildmaster/equipItem',
        type: 'POST',
		data: data,
        success: function (data) {
            if (data == "Erreur") {
            	alert('Vous avez commis une erreur, veuillez réessayer !');
            } else if (data == "Fail") {
            	alert('La connection à la base de données est impossible, veuillez réesayer plus tard !')
            } else if (data == "OK") {
            	alert('Changements enregistrés !');
            }
            location.reload();
        },
        error: function (xhr, status, error) {
            alert('Erreur !');
            location.reload();
        },
    });
});


 $('[data-countdown]').each(function() {
	       var $this = $(this), finalDate = $this.data('countdown'), idQuest = $this.data('idquest'), exp = $this.data('exp'), gold = $this.data('gold'), reward = $this.data('reward'), idSquad = $this.data('idsquad'), nameSquad = $this.data('squadname'), nameQuest = $this.data('questname'), reussiteQuete = $this.data('reussitequete');
	       var fin = "";
	       var recompense = "gain exp: "+exp+", gain or: "+gold;
	       if (reward) {
		recompense = recompense+", bonus: "+reward;
	       }
	       if (reussiteQuete!=1) {
		fin = "<a href='/guildmaster/quete/terminer/"+idQuest+"/"+nameQuest+"/"+idSquad+"/"+nameSquad+"'> Echec de la mission</a>";
	       }
	       else{
		fin = "<a onclick=\"alert('"+recompense+"')\" href='/guildmaster/quete/terminer/"+idQuest+"/"+nameQuest+"/"+idSquad+"/"+nameSquad+"'>Reussite de la mission</a>";
	       }
	       $this.countdown(finalDate, {elapse: true}).on('update.countdown', function(event) {
		if (event.elapsed) {
		    $this.html(fin);
		} else {
		    $this.html(event.strftime('%Djours %Hh %Mmin %Ssec'));
		}
	       })
	    });
});