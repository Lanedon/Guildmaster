var express     = require('express');
var session     = require('cookie-session'); // Charge le middleware de sessions
var bodyParser  = require('body-parser');    // Charge le middleware de gestion des paramètres  
var mysql       = require('mysql');
var util = require('util');

var connection = mysql.createConnection({
  host     : "localhost",
  user     : "root",
  password : "",
  database : "guildmaster"
});
var urlencodedParser = bodyParser.urlencoded({ extended: false });

var app = express();
app.use(express.static(__dirname + '/public'));
/*
connection.connect(function(err){
  if(!err) {
      //console.log("Database is connected ... \n\n");  
  } else {
      //console.log("Error connecting database ... \n\n" + err);  
  }
}); 
*/

/* On utilise les sessions */
app.use(session({secret: 'UserSession'}))

/* S'il n'y a pas de liste dans la session,
on en crée une vide sous forme d'array avant la suite */
.use(function(req, res, next){
   if (typeof(req.session.user) == 'undefined') {
        req.session.user = {role:'anonyme'};
    }
    next();
})


/* accueil */
.get('/guildmaster', function(req, res) { 
    if (req.session.user['role'] !== 'en attente'){
     res.render('accueil.ejs', {user: req.session.user});
    }
    else {
     //req.session.user = {role:'anonyme'};
     res.render('nouveauJoueur.ejs', {user: req.session.user});
     //console.log(req.session.user);
    }
})

.get('/guildmaster/nouveauJoueur', function(req, res) {
  //req.session.user = {role:'anonyme'};
  res.render('nouveauJoueur.ejs', {user: req.session.user});
})

/* Inscription */
.get('/guildmaster/inscription', function(req, res) {
    res.render('inscription.ejs', {user: req.session.user});
})

/* Inscription validation*/
.post('/guildmaster/inscription/validation', urlencodedParser, function(req, res) { 
	//console.log(req.body);
        var post={login:req.body.pseudo,
                  pass:req.body.mdp,
                  email:req.body.email,
                  role:'en attente'};
        connection.query("INSERT INTO user set ?", post, function(err){
                if(err){
                 // //console.log(err.message);
                }else{
                 // //console.log('success');
                  res.redirect('/guildmaster');
                }
        })
})

/* Connexion */
.get('/guildmaster/connexion', function(req, res) {
    res.render('connexion.ejs', {user: req.session.user});
})

/* Connexion validation*/
.post('/guildmaster/connexion/validation', urlencodedParser, function(req, res) { 
       //console.log('pseudo',req.body.pseudo);
       //console.log('MdP',req.body.MdP);
       connection.query("SELECT user.idUser,login, role FROM user WHERE login = '"+ req.body.pseudo +"' and pass = '"+ req.body.MdP +"'", function(err, rows, fields) {
		//console.log(rows);
		if (rows !== undefined && rows[0] !== undefined ){
		        var user = {id:rows[0]['idUser'],
				    login:rows[0]['login'],
				    role:rows[0]['role']};
			if(rows[0]['role']!=='en attente'){
			  connection.query("SELECT gold FROM guild where idUser = '"+ rows[0]['idUser'] +"'", function(err, rows, fields) {
				  req.session.user = {id:user['id'],name:user['login'], role:user['role'], gold:rows[0]['gold']};
				  res.redirect('/guildmaster/');
			  })
			}
			else{
			  req.session.user = {id:user['id'],name:user['login'], role:user['role']};
			  res.redirect('/guildmaster/');
			}
			
		}
		else{
	   		res.redirect('/guildmaster/');		
		}
	})
})

/* nouveau joueur validation */
.post('/guildmaster/nouveauJoueur/validation', urlencodedParser, function(req, res) { 
        var post={name:req.body.guilde,
		  prestige: 0,
		  rank: req.session.user['id'],
		  gold: 1000,
		  idUser: req.session.user['id']};
                  //option:req.body.optionsRadios
        connection.query("INSERT INTO guild set ?", post, function(err){
                if(err){
                  //console.log(err.message);
                }else{
		  connection.query("UPDATE user SET role = 'user' WHERE idUser ="+ req.session.user['id'] +";", post, function(err){
		    if(err){
		      //console.log(err.message);
		    }else{
		     // //console.log('success');
		     req.session.user = {id:req.session.user['id'], role:'user', gold:'1000'};
		     res.redirect('/guildmaster');
		    }
		  })
                }
        })
})

/* personnel */
.get('/guildmaster/personnel',urlencodedParser, function(req, res) {
     connection.query("SELECT crew.idCrew, name, surname,null as niveau, talent, fee, job, 0 as hero FROM worker, crew WHERE idUser = '"+ req.session.user['id'] +"' and worker.idCrew = crew.idCrew UNION SELECT crew.idCrew, name, surname, niveau, talent, fee, classe, 1 as hero FROM heroes, crew WHERE idUser = '"+ req.session.user['id'] +"' and heroes.idCrew = crew.idCrew" , function(err, rows, fields){
	if (!err){  
	   //console.log(rows);
	    res.render('personnel.ejs', {data:rows, user:req.session.user});
      }
	else{
         res.render('personnel.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})

/* detail personnel */
.get('/guildmaster/personnel/detail/:id/:name/:surname', function(req, res) {
  //console.log(req.params);
      connection.query("SELECT idUser FROM crew WHERE idCrew = '"+ req.params['id'] +"'", function(err, rows, fields){
	if (!err){
	//console.log(rows , req.session.user['id']);
        //console.log(rows[0]['idUser'] === req.session.user['id']);
          if (rows[0]['idUser'] === req.session.user['id'] ) {
             connection.query("SELECT * FROM heroes WHERE idCrew = '"+ req.params['id'] +"'", function(err, rows, fields){
              if (!err){
                //Infos sur la personne (Nom, prenom, ...)
                connection.query("SELECT * FROM crew WHERE idCrew = '"+ req.params['id'] +"'", function(err, crew, fields){
                  //Infos sur les armes et armures
                  connection.query("select * from inventory NATURAL JOIN equipment NATURAL JOIN armor where idCrew = "+ req.params['id'], function(err, equipArmor, fields){
		    connection.query("select * from inventory NATURAL JOIN equipment NATURAL JOIN weapon where idCrew = "+ req.params['id'], function(err, equipWeapon, fields){
		      connection.query("select * from inventory NATURAL JOIN equipment NATURAL JOIN armor where idUser = "+ req.session.user['id'] , function(err, inventoryArmor, fields){
		        connection.query("select * from inventory NATURAL JOIN equipment NATURAL JOIN weapon where idUser = "+ req.session.user['id'] , function(err, inventoryWeapon, fields){
			  rows[0]['handRight'] = '';
			  rows[0]['handLeft'] = '';
			  rows[0]['torso'] = '';
			  rows[0]['head'] = '';
			  rows[0]['legs'] = '';
			  rows[0]['feet'] = '';
			  if (equipArmor) {
			    for (var i = 0;i<equipArmor.length;i++) {
			      rows[0][equipArmor[i]['slot']] = equipArmor[i];
			    }
			  }
			  if (equipWeapon) {
			    for (var i = 0;i<equipWeapon.length;i++) {
            if (equipWeapon[i]['slot'] == 'hand' && (equipWeapon[i]['handSpecial'] == 'handLeft' || (equipWeapon[i]['handSpecial'] == 'handRight'))) {
              rows[0][equipWeapon[i]['handSpecial']] = equipWeapon[i];
            } else {
              rows[0][equipWeapon[i]['handRight']] = equipWeapon[i];
            }
			    }
			  }
			  //console.log(inventoryArmor);
			  res.render('detail.ejs', {data:rows[0], crew:crew[0], inventoryWeapon:inventoryWeapon, inventoryArmor:inventoryArmor, user: req.session.user});
                        });
                      });
                    });
                  });
                });
                //console.log(data);
              }
              else{
               res.redirect('/guildmaster/personnel');
               // //console.log(err.message);
              }
             }) 
          }
      }
      else{
        res.render('personnel.ejs', {user:req.session.user});
        // //console.log(err.message);
      }
    })
	//console.log(req.session.user);	
})

/*supprimer personnel */
.get('/guildmaster/personnel/supprimer/:id/:name/:surname', urlencodedParser, function(req, res) {
        connection.query("DELETE FROM crew WHERE idCrew = "+ req.params['id'] +" and name = '"+ req.params['name'] +"' and surname = '"+ req.params['surname'] +"' and idUser="+req.session.user['id'], function(err){
	    if(err){
	     // //console.log(err.message);
	    }else{
	    connection.query(" select idSquad from squad where idUser = "+req.session.user['id']+" and idSquad not in(select idSquad from crew,heroes where idSquad is not null and idUser = "+req.session.user['id']+" group by idSquad);",  function(err, rows, fields){
		if(err){
		 // //console.log(err.message);
		}else{
		  if (rows !== undefined && rows[0] !== undefined ){
		    //console.log(rows);
		    connection.query("DELETE FROM squad WHERE idSquad = "+ rows[0]['idSquad'] +" and idUser="+req.session.user['id'], function(err){})
		  }
	        }
	    })
	    }
	})
	res.redirect('/guildmaster/personnel');
})


/* magasin d'armures*/
.get('/guildmaster/magasin', function(req, res) { 
    connection.query("select * from equipment NATURAL JOIN armor where buyable = 1", function(err, Armor, fields){
	res.render('magasin.ejs', {data: Armor, user:req.session.user});
    });
})


/* magasin d'armes*/
.get('/guildmaster/magasin/armes', function(req, res) { 
      connection.query("select * from equipment NATURAL JOIN weapon where buyable =1", function(err, Weapon, fields){
	res.render('magasinArme.ejs', {data: Weapon, user:req.session.user});
      });
})


/* achat armes/armures */
.get('/guildmaster/magasin/achat/:id/:name', function(req, res) { 
      connection.query("select gold, equipment.name, equipment.idEquipment, price from equipment, armor,guild where equipment.idEquipment= "+req.params['id']+" and equipment.name = '"+req.params['name']+"' and guild.idUser = "+req.session.user['id']+" and equipment.idEquipment = armor.idEquipment group by equipment.idEquipment UNION select gold, equipment.name, equipment.idEquipment, price from equipment, weapon,guild where equipment.idEquipment = "+req.params['id']+" and equipment.name = '"+req.params['name']+"' and guild.idUser = "+req.session.user['id']+" and equipment.idEquipment = weapon.idEquipment group by equipment.idEquipment", function(err, rows, fields){
	var gold = rows['0']['gold'];
	var inventory={idEquipment:rows[0]['idEquipment'],
		      idUser:req.session.user['id']};
	  if (gold-rows['0']['price']>=0) {
	    gold = gold - rows['0']['price'];
	    connection.query("UPDATE guild SET gold = "+gold+" WHERE idUser ="+req.session.user['id'], function(err, rows, fields){
            if (!err){
	      req.session.user['gold'] = gold;
	      // //console.log(req.session.user);
	      connection.query("INSERT INTO inventory set ?", inventory, function(err){ 
		if(err){
		  // //console.log(err.message);
		  res.redirect('/guildmaster/magasin');	
	        }
		else{
		   res.redirect('/guildmaster/inventaire');	
		}
	      });
	    }
	    });
          }
	  else {
	    res.redirect('/guildmaster/magasin');	
	  }
      });
})

/* recruter personnel */
.get('/guildmaster/recruter', function(req, res) { 
     connection.query("SELECT crew.idCrew, name, surname,null as niveau, talent, fee, job, 0 as hero FROM worker, crew WHERE idUser is null and worker.idCrew = crew.idCrew UNION SELECT crew.idCrew, name, surname,niveau, talent, fee, classe, 1 as hero FROM heroes, crew WHERE idUser is null and heroes.idCrew = crew.idCrew" , function(err, rows, fields){
	if (!err){  
	   //console.log(rows);
	    res.render('recruter.ejs', {data:rows, user:req.session.user});
      }
	else{
          res.render('recruter.ejs', {user:req.session.user});
	  //console.log(err.message);
        }
    })
})


/* detail recruter */
.get('/guildmaster/recruter/detail/:id/:name/:surname', function(req, res) {
  //console.log(req.params);
      connection.query("SELECT idUser FROM crew WHERE idCrew = '"+ req.params['id'] +"'", function(err, rows, fields){
	if (!err){
	//console.log(rows , req.session.user['id']);
        //console.log(rows[0]['idUser'] === req.session.user['id']);
             connection.query("select experience,niveau, classe, prestige, sum(coalesce(a.str + b.bonusStr, a.str)) as str, sum(coalesce(a.end + b.bonusEnd, a.end)) as end, sum(coalesce(a.intel + b.bonusInt, a.intel)) as intel, sum(coalesce(a.luk + b.bonusLuk, a.luk)) as luk, sum(coalesce(a.dex + b.bonusDex, a.dex)) as dex from (SELECT experience, classe, prestige,niveau, str, dex, luk, end, intel, idCrew FROM heroes where idCrew = "+ req.params['id'] +") as a left join (select sum(bonusStr) as bonusStr, sum(bonusDex) as bonusDex, sum(bonusLuk) as bonusLuk, sum(bonusEnd) as bonusEnd, sum(bonusInt) as bonusInt, idCrew from equipment,inventory where idCrew = "+ req.params['id'] +" AND equipment.idEquipment = inventory.idEquipment) as b on b.idCrew = a.idCrew", function(err, rows, fields){
              if (!err){
                //console.log(rows);
                res.render('detailRecrue.ejs', {data:rows, user: req.session.user});
                //console.log(data);
              }
              else{
               res.redirect('/guildmaster/recruter');
               // //console.log(err.message);
              }
             })
          }
        })
	//console.log(req.session.user);	
})

/* recruter personnel */
.get('/guildmaster/recruter/:id/:name/:surname', function(req, res) { 
     connection.query("SELECT gold, crew.idCrew, crew.name, surname, talent, fee, job, 0 as hero FROM worker, guild, crew WHERE crew.idcrew = "+req.params['id']+" and worker.idCrew = crew.idCrew and guild.idUser = "+req.session.user['id']+" UNION SELECT gold, crew.idCrew, crew.name, surname, talent, fee, classe, 1 as hero FROM heroes,guild, crew WHERE crew.idcrew = "+req.params['id']+" and heroes.idCrew = crew.idCrew and guild.idUser = "+req.session.user['id'] , function(err, rows, fields){
	if (rows !== undefined && rows[0] !== undefined ){
	  var gold = rows[0]['gold'];
	  var perso={name:rows[0]['name'],
                    surname:rows[0]['surname'],
		    talent:rows[0]['talent'],
		    fee:rows[0]['fee'],
		    idUser:req.session.user['id']};
	  var hero = {job:rows[0]['job'],
		      hero:rows[0]['hero']};
	  if (gold >= perso['fee']) {
	    gold = gold-perso['fee'];

	    connection.query("UPDATE guild SET gold = "+gold+" WHERE idUser ="+req.session.user['id'], function(err, rows, fields){
              if (!err){
	       req.session.user['gold'] = gold;
	      // //console.log(req.session.user);
	       connection.query("INSERT INTO crew set ?", perso, function(err){
		  if(err){
		   // //console.log(err.message);
		   res.redirect('/guildmaster/recruter');	
		  }else{
		  connection.query("select MAX(idCrew) FROM crew" , function(err, rows, fields){
		    if(rows == undefined && rows[0] == undefined){
		      }else{
			var detail = {idCrew:rows[0]['MAX(idCrew)'],
				      job:hero['job']};
// worker // 
		       if (hero['hero']==0) {
			 connection.query("INSERT INTO worker set ?", detail, function(err){
			     if(err){
			      // //console.log(err.message);
			      res.redirect('/guildmaster/recruter');	
			     }else{
			      // //console.log('success');
			      res.redirect('/guildmaster/personnel');
			     }
			 })
		       }
// hero // 
		      if (hero['hero']==1) {
			connection.query("SELECT classe, prestige,niveau,experience, str, dex, intel, luk, end FROM heroes WHERE idCrew = '"+ req.params['id'] +"'", function(err, rows, fields){
			  if (rows !== undefined && rows[0] !== undefined){
			     var detailPers={classe:rows[0]['classe'],
					     prestige:rows[0]['prestige'],
					     experience:rows[0]['experience'],
					     niveau:rows[0]['niveau'],
					     str:rows[0]['str'],
					     dex:rows[0]['dex'],
					     intel:rows[0]['intel'],
					     luk:rows[0]['luk'],
					     end:rows[0]['end'],
					     idCrew:detail['idCrew']};
			    connection.query("INSERT INTO heroes set ?", detailPers, function(err){
			      if(err){
			      //  //console.log(err.message);
			       res.redirect('/guildmaster/recruter');	
			      }else{
			       // //console.log('success');
			       res.redirect('/guildmaster/personnel');
			      }
			    })
			  }
			  else{
			  //console.log(err.message);
			   res.redirect('/guildmaster/recruter');
			  }
			})
		      }
		    }
		  })
		}
	    })
              }
              else{
               res.redirect('/guildmaster/recruter');
               // //console.log(err.message);
              }
             })
       }
	} 
	else{
	  res.redirect('/guildmaster/recruter');		
	}
     })
})


/* escouades */
.get('/guildmaster/escouades',urlencodedParser, function(req, res) {
     connection.query("select idSquad, name from squad where idUser ='"+ req.session.user['id'] +"'" , function(err, rows, fields){
	if (!err){  
	   //console.log(rows);
	    res.render('escouades.ejs', {data:rows, user:req.session.user});
      }
	else{
         res.render('escouades.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})

/* detail escouades */
.get('/guildmaster/escouades/detail/:id/:name', function(req, res) {
  //console.log(req.params);
      connection.query("SELECT idUser FROM squad WHERE idSquad = '"+ req.params['id'] +"'", function(err, rows, fields){
	if (!err){
	//console.log(rows , req.session.user['id']);
        //console.log(rows[0]['idUser'] === req.session.user['id']);
          if (rows[0]['idUser'] === req.session.user['id'] ) {
             connection.query("select a.idCrew, experience,niveau, classe, prestige, coalesce(a.str + b.bonusStr, a.str) as str, niveau, coalesce(a.end + b.bonusEnd, a.end) as end, coalesce(a.intel + b.bonusInt, a.intel) as intel, coalesce(a.luk + b.bonusLuk, a.luk) as luk, coalesce(a.dex + b.bonusDex, a.dex) as dex from (SELECT experience,niveau, classe, prestige, str, dex, luk, end, intel, idCrew FROM heroes where idSquad = "+ req.params['id'] +" group by idCrew) as a left join (select sum(bonusStr) as bonusStr, sum(bonusDex) as bonusDex, sum(bonusLuk) as bonusLuk, sum(bonusEnd) as bonusEnd, sum(bonusInt) as bonusInt, heroes.idCrew as idCrew from equipment,inventory, heroes where heroes.idCrew = inventory.idCrew and idSquad = "+ req.params['id'] +" AND equipment.idEquipment = inventory.idEquipment) as b on b.idCrew = a.idCrew", function(err, rows, fields){
              if (!err){
                //console.log(rows);
                res.render('detailEscouades.ejs', {data:rows, user: req.session.user});
                //console.log(data);
              }
              else{
               res.redirect('/guildmaster/personnel');
               // //console.log(err.message);
              }
             }) 
          }
      }
      else{
        res.render('personnel.ejs', {user:req.session.user});
        // //console.log(err.message);
      }
    })
	//console.log(req.session.user);	
})


/* nouvelle escouade */
.get('/guildmaster/escouades/creer', function(req, res) {
    if (req.session.user['role']=='admin' || req.session.user['role']=='user') {
         connection.query("select a.idCrew, experience,niveau, classe, prestige, coalesce(a.str + b.bonusStr, a.str) as str, coalesce(a.end + b.bonusEnd, a.end) as end, coalesce(a.intel + b.bonusInt, a.intel) as intel, coalesce(a.luk + b.bonusLuk, a.luk) as luk, coalesce(a.dex + b.bonusDex, a.dex) as dex from (SELECT experience, classe, prestige, str, dex, luk,niveau, end, intel, heroes.idCrew as idCrew FROM heroes, crew where idSquad is null and idUser = "+ req.session.user['id'] +" and crew.idCrew = heroes.idCrew group by idCrew) as a left join (select sum(bonusStr) as bonusStr, sum(bonusDex) as bonusDex, sum(bonusLuk) as bonusLuk, sum(bonusEnd) as bonusEnd, sum(bonusInt) as bonusInt, idCrew from equipment,inventory where equipment.idEquipment = inventory.idEquipment group by idCrew) as b on b.idCrew = a.idCrew", function(err, rows, fields){
              if (!err){
                res.render('creerEscouade.ejs', {data:rows, user: req.session.user});
              }
              else{
               res.redirect('/guildmaster/personnel');
               // //console.log(err.message);
              }
             }) 
    } else
      res.redirect('/guildmaster/');
})



/* nouvelle escouade validation */
.post('/guildmaster/escouades/creer/validation', urlencodedParser, function(req, res) { 
	var squad={name:req.body.name,
		   idUser: req.session.user['id']};
	if (req.body.membres != undefined){
	  if (req.body.membres.length <= 4 || typeof req.body.membres === 'string' ) {
	   if (typeof req.body.membres === 'string' ) {
	    connection.query("INSERT INTO squad set ?", squad, function(err){
		   if(err){
		    // //console.log(err.message);
		    res.redirect('/guildmaster/escouades');
		   }else{
		     connection.query("select MAX(idSquad) FROM squad" , function(err, rows, fields){
		       var idSquad = rows[0]['MAX(idSquad)'];
			   connection.query("UPDATE heroes SET idSquad = "+ idSquad +" WHERE idCrew = "+ req.body.membres +";", function(err){
			     if(err){
			       connection.query("DELETE FROM squad WHERE idSquad = "+ idSquad , function(err){});
			       res.redirect('/guildmaster/');
			     }else{
			      // //console.log('success');
			     }
			   })
			 res.redirect('/guildmaster/escouades/detail/'+idSquad+'/'+squad['name']);
		     })
		   }
	     })
	   }
	   else{
	    connection.query("INSERT INTO squad set ?", squad, function(err){
		  if(err){
		   // //console.log(err.message);
		   res.redirect('/guildmaster/escouades');
		  }else{
		    connection.query("select MAX(idSquad) FROM squad" , function(err, rows, fields){
		      var idSquad = rows[0]['MAX(idSquad)'];
			for (i=0;i<req.body.membres.length;i++) {
			  connection.query("UPDATE heroes SET idSquad = "+ idSquad +" WHERE idCrew = "+ req.body.membres[i] +";", function(err){
			    if(err){
			      connection.query("DELETE FROM squad WHERE idSquad = "+ idSquad , function(err){});
			      res.redirect('/guildmaster/');
			    }else{
			     // //console.log('success');
			    }
			  })
			}
			res.redirect('/guildmaster/escouades/detail/'+idSquad+'/'+squad['name']);
		    })
		  }
	    })
	  }
	  }
	  else {
	     res.redirect('/guildmaster/escouades');
	  }
	}
	else{
	  res.redirect('/guildmaster/escouades');
	}
})

/*supprimer escouade */
.get('/guildmaster/escouades/supprimer/:id/:name', urlencodedParser, function(req, res) {
        connection.query("DELETE FROM squad WHERE idSquad = "+ req.params['id'] +" and name = '"+ req.params['name'] +"' and idUser="+req.session.user['id'], function(err){})
	res.redirect('/guildmaster/escouades')
})


/* profil */
.get('/guildmaster/profil', function(req, res) {
    connection.query("SELECT login, email ,role, name, rank, prestige, gold FROM user, guild where user.idUser = guild.idUser AND user.idUser = "+req.session.user['id'], function(err, rows, fields){
      if (!err){
	   //console.log(rows);
	    res.render('profil.ejs', {data:rows, user:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})



/* inventaire */
.get('/guildmaster/inventaire', function(req, res) { 
     connection.query("SELECT equipment.name as equipmentName,inventory.idCrew, slot, rarity, description, minStr, minDex, minInt, minLuk, minEnd, bonusStr, bonusDex, bonusInt, bonusLuk, bonusEnd, crew.name, surname FROM crew,inventory,equipment WHERE inventory.idUser = "+ req.session.user['id'] +" and inventory.idEquipment = equipment.idEquipment and (crew.idCrew = inventory.idCrew or inventory.idCrew is null) group by idInventory", function(err, rows, fields){
	if (!err){
	   //console.log(rows);
	    res.render('inventaire.ejs', {data:rows, user:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('inventaire.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})

/* affichage quete */
.get('/guildmaster/quete', function(req, res) { 
     connection.query("SELECT idQuest,gold, experience, name, summary, duree, reward FROM quest", function(err, rows, fields){
	if (!err){
	   //console.log(rows);
	    res.render('quete.ejs', {data:rows, user:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('quete.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})


/* commencer quete */
.get('/guildmaster/quete/commencer/:id/:name', function(req, res) {
     connection.query("SELECT idQuest, experience, gold, name, summary, duree, reward FROM quest where idQuest ="+ req.params['id'] +" and name = '"+ req.params['name'] +"'", function(err, rows, fields){
	if (!err){
	   var quest = rows;
	    connection.query("SELECT name, idSquad FROM squad where idQuest is null and idUser="+req.session.user['id'], function(err, rows, fields){
		if (!err){
		  var squad = rows;
		  res.render('queteCommencer.ejs', {quest:quest, squad:squad, user:req.session.user});
	      }
		else{
		// res.redirect('accueil.ejs', {user:req.session.user});
		 // //console.log(err.message);
		}
	    })
	   //console.log(data);
      }
	else{
       //  res.redirect('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})

/* commencer quete validation*/
.get('/guildmaster/quete/commencer/validation/:idQuest/:nameQuest/:idSquad/:nameSquad', function(req, res) {
     connection.query("SELECT procEnd, procStr, procDex, procInt, procLuk, duree, difficulty FROM quest where idQuest ="+ req.params['idQuest'] +" and name = '"+ req.params['nameQuest'] +"'", function(err, rows, fields){
	if (!err){
	   var quest = rows[0]; 
	    connection.query("select sum(coalesce(a.str + b.bonusStr, a.str)) as str, sum(coalesce(a.end + b.bonusEnd, a.end)) as end, sum(coalesce(a.intel + b.bonusInt, a.intel)) as intel, sum(coalesce(a.luk + b.bonusLuk, a.luk)) as luk, sum(coalesce(a.dex + b.bonusDex, a.dex)) as dex from (SELECT str, dex, luk, end, intel, idCrew FROM heroes where idSquad = "+ req.params['idSquad'] +") as a left join (select sum(bonusStr) as bonusStr, sum(bonusDex) as bonusDex, sum(bonusLuk) as bonusLuk, sum(bonusEnd) as bonusEnd, sum(bonusInt) as bonusInt, heroes.idCrew as idCrew from equipment,inventory,heroes where inventory.idCrew = heroes.idCrew and idSquad = "+ req.params['idSquad'] +" and equipment.idEquipment = inventory.idEquipment) as b on b.idCrew = a.idCrew", function(err, rows, fields){
		if (!err){
		  var squad = rows[0];
		  var stats = squad['str']*quest['procStr'] + squad['end']*quest['procEnd'] + squad['intel']*quest['procInt'] + squad['luk']*quest['procLuk'] + squad['dex']*quest['procDex'];
		  //console.log(stats);
		  var reussiteChance = Math.floor((Math.random() * quest['difficulty']) + 1);
		  var reussite = 0;
		  if (stats >= reussiteChance){ reussite = 1 }
		  var dateTime =  Math.round(new Date() / 1000);
		  var dateFinQuete = new Date((dateTime+quest['duree'])*1000);
		  dateFinQuete =  dateFinQuete.getFullYear()+"-"+parseInt(dateFinQuete.getMonth()+1)+"-"+dateFinQuete.getDate()+" "+dateFinQuete.getHours()+":"+dateFinQuete.getMinutes()+":"+dateFinQuete.getSeconds();
		 
		  connection.query("UPDATE squad SET idQuest = "+ req.params['idQuest'] +", reussiteQuete = "+ reussite +", dateFinQuete = '"+ dateFinQuete +"' WHERE idSquad = "+ req.params['idSquad'] +";", function(err){
			  if(err){
			   
			  }else{
			   res.redirect('/guildmaster/quete/enCours');
			  }
		        })
		}
		else{
		 res.redirect('/guildmaster/quete/commencer/'+req.params['idQuest']+'/'+req.params['nameQuest']);
		 // //console.log(err.message);
		}
	    })
	   //console.log(data);
      }
	else{
        res.redirect('/guildmaster/quete/commencer/'+req.params['idQuest']+'/'+req.params['nameQuest']);
	 // //console.log(err.message);
        }
    })
})



/* quete en cours */
.get('/guildmaster/quete/enCours', function(req, res) { 
     connection.query("SELECT reussiteQuete, squad.idQuest, experience, gold, reward, idSquad, quest.name as questName, squad.name as squadName, dateFinQuete FROM squad, quest where squad.idQuest is not null and quest.idQuest = squad.idQuest", function(err, rows, fields){
	if (!err){
	   //console.log(rows);
	   var dateFin = [];
	   for (i=0; i< rows.length;i++) {
	    var dateFinQuete =  (rows[i]['dateFinQuete']);
	    dateFinQuete =  dateFinQuete.getFullYear()+"-"+parseInt(dateFinQuete.getMonth()+1)+"-"+dateFinQuete.getDate()+" "+dateFinQuete.getHours()+":"+dateFinQuete.getMinutes()+":"+dateFinQuete.getSeconds();
	    dateFin[i] = dateFinQuete; 
	   }
	   res.render('queteEnCours.ejs', {data:rows, dateFin:dateFin, user:req.session.user});
	   //console.log(data);
       } 
	else{
         res.render('quete.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})


/* quete terminer */
.get('/guildmaster/quete/terminer/:idQuest/:nameQuest/:idSquad/:nameSquad', function(req, res) {
     connection.query("SELECT dateFinQuete, reward, guild.gold as guildGold, quest.gold, experience, reussiteQuete FROM squad,quest,guild where squad.idSquad = "+req.params[ 'idSquad']+" and squad.name = '"+req.params[ 'nameSquad']+"' and quest.idQuest ="+req.params[ 'idQuest']+"  and quest.name = '"+req.params[ 'nameQuest']+"' and guild.idUser = "+req.session.user['id'], function(err, rows, fields){
	if (!err){
	  //console.log(rows[0]);
	  var quest = rows[0];
	  var gold =  rows[0]['guildGold']+ rows[0]['gold'];
	  if (quest['dateFinQuete'].getTime()/1000 - Math.round(new Date() / 1000)<=0) {
	      connection.query("UPDATE squad SET reussiteQuete = NULL ,idQuest = NULL ,dateFinQuete = NULL WHERE idSquad ='"+ req.params['idSquad'] +"';", function(err){
		if(err){
		}else{
		  if (quest['reussiteQuete']==1) {
		    connection.query("select idCrew,attrPoints, experience,niveau from heroes where idSquad ="+ req.params['idSquad'], function(err, rows, fields){
		      if(err){
		      }else{
			//console.log(rows);
			var exp = 0;
			var lvl = 0;
			var attrP = 0;
			var lvlUp = 0;
			for (i=0; i<rows.length; i++) {
			  exp = rows[i]['experience']+quest['experience'];
			  lvl = rows[i]['niveau'];
			  attrP = rows[i]['attrPoints'];
			  while (exp > lvlUp) {
			    lvlUp = ((lvl)*(lvl))*25;
			    if (exp >= lvlUp) {
			      lvl++;
			      exp = exp-lvlUp;
			      attrP =  attrP + 2;
			    }
			  }
			  lvlUp = 0;
			  connection.query("UPDATE heroes SET attrPoints = "+attrP+",experience ="+ exp +",niveau = "+lvl+"  WHERE idCrew ="+ rows[i]['idCrew'], function(err){
			   if(err){
			    }else{
			    }
			  })
			}
			connection.query("UPDATE guild SET gold = "+gold+" WHERE idUser ="+req.session.user['id'], function(err, rows, fields){
			   if(err){
			   }else{
			      req.session.user['gold'] = gold;
			      res.redirect('/guildmaster/quete/enCours');
			   }
			})
		      }
		    })
		  }
		  else{
		       res.redirect('/guildmaster/quete/enCours');
		  }
		}
	      })
	  }
      }
	else{
        res.redirect('/guildmaster/quete/enCours');
	 // //console.log(err.message);
        }
    })
})


/* deconnexion */
.get('/guildmaster/deconnexion', function(req, res) {
    req.session = null;
    res.redirect('/guildmaster/');
})

/* gestion utilisateur */
.get('/guildmaster/gestion', function(req, res) { 
     connection.query("SELECT user.idUser, login, email ,role, name, rank, prestige, gold FROM user, guild where user.idUser = guild.idUser", function(err, rows, fields){
	if (!err){
	  var admin = 0;
	  for (var i = 0;i<rows.length;i++) {
	    if (rows[i]['role']== "admin") {
	      // //console.log(rows[i]);
	      // //console.log(req.session.user);
	       if (req.session.user['id']==rows[i]['idUser'] && req.session.user['name']==rows[i]['login'] && req.session.user['role']==rows[i]['role']) {
	          res.render('gestion.ejs', {data:rows, user:req.session.user});
	       }
	    }
	  }
	}
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})


/* modifier utilisateur validation*/
.post('/guildmaster/gestion/modifier/utilisateur/validation', urlencodedParser, function(req, res) { 
       // //console.log(req.body);
        connection.query("UPDATE user SET login = '"+ req.body['pseudo'] +"',email = '"+ req.body['email'] +"',role = '"+ req.body['role'] +"' WHERE idUser ="+ req.body['id'], function(err){
                if(err){
                 // //console.log(err.message);
                }else{
                  connection.query("UPDATE guild SET name = '"+ req.body['guild'] +"',prestige = "+ req.body['prestige'] +",gold = "+ req.body['gold'] +" WHERE idUser ="+ req.body['id'], function(err){
			  if(err){
			   // //console.log(err.message);
			  }else{
			   // //console.log('success');
			    res.redirect('/guildmaster/gestion/');
			  }
		  })
                }
        })
})


/*supprimer utilisateur */
.get('/guildmaster/gestion/supprimer/utilisateur/:id/:userName/:email', urlencodedParser, function(req, res) {
  connection.query("SELECT user.idUser, login, role FROM user, guild where user.idUser = guild.idUser and user.idUser="+req.session.user['id'], function(err, rows, fields){
	if (!err){
	// //console.log(req.params);
	  if (req.session.user['id']==rows[0]['idUser'] && req.session.user['name']==rows[0]['login'] && req.session.user['role']==rows[0]['role']) {
	    //console.log(rows);
	       connection.query("DELETE FROM user WHERE idUser = "+ req.params['id'] +" and login = '"+ req.params['userName'] +"' and email = '"+ req.params['email']+"'", function(err){})
	       res.redirect('/guildmaster/gestion/');
	  }
	}
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})


/* gestion magasin arme */
.get('/guildmaster/gestion/magasin/arme', function(req, res) { 
      connection.query("SELECT user.idUser, login, role FROM user, guild where user.idUser = guild.idUser", function(err, rows, fields){
	if (!err){
	  var admin = 0;
	  for (var i = 0;i<rows.length;i++) {
	    if (rows[i]['role']== "admin") {
	      // //console.log(rows[i]);
	      // //console.log(req.session.user);
	       if (req.session.user['id']==rows[i]['idUser'] && req.session.user['name']==rows[i]['login'] && req.session.user['role']==rows[i]['role']) {
	              connection.query("select * from equipment NATURAL JOIN weapon", function(err, Armor, fields){
			  res.render('gestionArme.ejs', {data: Armor, user:req.session.user});
		      });
	       }
	    }
	  }
	}
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})

/* ajout d'une arme*/
.post('/guildmaster/gestion/magasin/arme/ajout/validation', urlencodedParser, function(req, res) { 
	//console.log(req.body);
        var equipment={name:req.body.name,
		      price:req.body.price,
		      rarity:req.body.rarity,
		      minStr:req.body.minStr,
		      minEnd:req.body.minEnd,
		      minInt:req.body.minInt,
		      minLuk:req.body.minLuk,
		      minDex:req.body.minDex,
		      slot:'hand',
		      bonusStr:req.body.bonusStr,
		      bonusEnd:req.body.bonusEnd,
		      bonusInt:req.body.bonusInt,
		      bonusLuk:req.body.bonusLuk,
		      bonusDex:req.body.bonusDex,
		      buyable:req.body.buyable};
	//console.log(equipment);
        connection.query("INSERT INTO equipment set ?", equipment, function(err){
	  if(err){
	   // //console.log(err.message);
	  }else{
	   // //console.log('success');
	   connection.query("select MAX(idEquipment) as idEquipment FROM equipment" , function(err, rows, fields){
	    if(err){
	      // //console.log(err.message);
	     }else{
	      // //console.log('success');
	       var weapon = {distance:req.body.distance,
			    idEquipment:rows[0]['idEquipment'],
			    minDamage:req.body.minDamage,
			    maxDamage:req.body.maxDamage};
	       //console.log(weapon);
	       connection.query("INSERT INTO weapon set ?", weapon, function(err){
		if(err){
		 // //console.log(err.message);
		}else{
		 // //console.log('success');
		  res.redirect('/guildmaster/gestion/magasin/arme');
		}
	       })
	     }
	   })
	  }
        })
})



/* modification d'une arme*/
.post('/guildmaster/gestion/magasin/arme/modifier/validation', urlencodedParser, function(req, res) { 
	//console.log(req.body);
        connection.query("UPDATE equipment SET name = '"+req.body.name+"', slot='hand', price = "+req.body.price+",rarity = '"+req.body.rarity+"',minStr = "+req.body.minStr+",minDex = "+req.body.minDex+",minInt = "+req.body.minInt+",minLuk = "+req.body.minLuk+",minEnd = "+req.body.minEnd+",bonusStr = "+req.body.bonusStr+",bonusDex = "+req.body.bonusDex+",bonusInt = "+req.body.bonusInt+",bonusEnd = "+req.body.bonusEnd+",bonusLuk = "+req.body.bonusLuk+",buyable = "+req.body.buyable+" WHERE idEquipment ="+req.body.id, function(err){
	  if(err){
	  //  //console.log(err.message);
	  }else{
	   // //console.log('success');
	    connection.query("UPDATE weapon SET distance = "+req.body.distance+", minDamage= "+req.body.minDamage+",  maxDamage= "+req.body.maxDamage+"   WHERE idEquipment = "+req.body.id, function(err){
	     if(err){
	      // //console.log(err.message);
	     }else{
	      // //console.log('success');
	       res.redirect('/guildmaster/gestion/magasin/arme');
	     }
	    })
	  }
        })
})


/* gestion magasin armure */
.get('/guildmaster/gestion/magasin', function(req, res) { 
      connection.query("SELECT user.idUser, login, role FROM user, guild where user.idUser = guild.idUser", function(err, rows, fields){
	if (!err){
	  var admin = 0;
	  for (var i = 0;i<rows.length;i++) {
	    if (rows[i]['role']== "admin") {
	      // //console.log(rows[i]);
	      // //console.log(req.session.user);
	       if (req.session.user['id']==rows[i]['idUser'] && req.session.user['name']==rows[i]['login'] && req.session.user['role']==rows[i]['role']) {
	              connection.query("select * from equipment NATURAL JOIN armor", function(err, Armor, fields){
			  res.render('gestionArmure.ejs', {data: Armor, user:req.session.user});
		      });
	       }
	    }
	  }
	}
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})


/*supprimer armure/arme */
.get('/guildmaster/gestion/magasin/supprimer/:id/:name', urlencodedParser, function(req, res) {
  connection.query("SELECT user.idUser, login, role FROM user, guild where user.idUser = guild.idUser and user.idUser="+req.session.user['id'], function(err, rows, fields){
	if (!err){
	 //console.log(req.params);
	  if (req.session.user['id']==rows[0]['idUser'] && req.session.user['name']==rows[0]['login'] && req.session.user['role']==rows[0]['role']) {
	       connection.query("DELETE FROM equipment WHERE idEquipment = "+ req.params['id'] +" and name = '"+ req.params['name'] +"'", function(err){})
	       res.redirect('/guildmaster/gestion/magasin');
	  }
	}
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})




/* ajout d'une armure*/
.post('/guildmaster/gestion/magasin/ajout/validation', urlencodedParser, function(req, res) { 
	//console.log(req.body);
        var equipment={name:req.body.name,
		      price:req.body.price,
		      rarity:req.body.rarity,
		      minStr:req.body.minStr,
		      minEnd:req.body.minEnd,
		      minInt:req.body.minInt,
		      minLuk:req.body.minLuk,
		      minDex:req.body.minDex,
		      slot:req.body.slot,
		      bonusStr:req.body.bonusStr,
		      bonusEnd:req.body.bonusEnd,
		      bonusInt:req.body.bonusInt,
		      bonusLuk:req.body.bonusLuk,
		      bonusDex:req.body.bonusDex,
		      buyable:req.body.buyable};
	//console.log(equipment);
        connection.query("INSERT INTO equipment set ?", equipment, function(err){
	  if(err){
	    //console.log(err.message);
	  }else{
	   // //console.log('success');
	   connection.query("select MAX(idEquipment) as idEquipment FROM equipment", function(err, rows, fields){
	    if(err){
	       //console.log(err.message);
	     }else{
	      // //console.log('success');
	       var armor = {idEquipment:rows[0]['idEquipment'],
			    protection:req.body.protection};
	      //console.log(armor);
	       connection.query("INSERT INTO armor set ?", armor, function(err){
		if(err){
		 // //console.log(err.message);
		}else{
		 // //console.log('success');
		  res.redirect('/guildmaster/gestion/magasin');
		}
	       })
	     }
	   })
	  }
        })
})



/* modification d'une armure*/
.post('/guildmaster/gestion/magasin/modifier/validation', urlencodedParser, function(req, res) { 
	//console.log(req.body);
        connection.query("UPDATE equipment SET name = '"+req.body.name+"',price = "+req.body.price+", slot= '"+req.body.slot+"',rarity = '"+req.body.rarity+"',minStr = "+req.body.minStr+",minDex = "+req.body.minDex+",minInt = "+req.body.minInt+",minLuk = "+req.body.minLuk+",minEnd = "+req.body.minEnd+",bonusStr = "+req.body.bonusStr+",bonusDex = "+req.body.bonusDex+",bonusInt = "+req.body.bonusInt+",bonusEnd = "+req.body.bonusEnd+",bonusLuk = "+req.body.bonusLuk+",buyable = "+req.body.buyable+" WHERE idEquipment ="+req.body.id, function(err){
	  if(err){
	   // //console.log(err.message);
	  }else{
	   // //console.log('success');
	    connection.query("UPDATE armor SET protection = "+req.body.protection+" WHERE idEquipment = "+req.body.id, function(err){
	     if(err){
	       //console.log(err.message);
	     }else{
	      // //console.log('success');
	       res.redirect('/guildmaster/gestion/magasin');
	     }
	    })
	  }
        })
})


/* gestion quete */
.get('/guildmaster/gestion/quete', function(req, res) {
  connection.query("SELECT user.idUser, login, role FROM user, guild where user.idUser = guild.idUser", function(err, rows, fields){
	if (!err){
	  var admin = 0;
	  for (var i = 0;i<rows.length;i++) {
	    if (rows[i]['role']== "admin") {
	      // //console.log(rows[i]);
	      // //console.log(req.session.user);
	       if (req.session.user['id']==rows[i]['idUser'] && req.session.user['name']==rows[i]['login'] && req.session.user['role']==rows[i]['role']) {
		connection.query("SELECT procEnd, procStr, procInt, procLuk, procDex, idQuest, gold, difficulty, experience, name, summary, duree, reward FROM quest", function(err, rows, fields){
		   if (!err){
		      //console.log(rows);
		       res.render('gestionQuete.ejs', {data:rows, user:req.session.user});
		      //console.log(data);
		 }

	       })
	      }
	    }
	  }
	}
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})

/* modifier quete validation*/
.post('/guildmaster/gestion/quete/modifier/validation', urlencodedParser, function(req, res) { 
        //console.log(req.body);
        connection.query("UPDATE quest SET name = '"+ req.body['name'] +"',procLuk = "+req.body['procLuk'] +",procDex = "+req.body['procDex'] +",procInt = "+req.body['procInt'] +",procStr = "+req.body['procStr'] +",procEnd = "+req.body['procEnd'] +",difficulty = "+ req.body['difficulty'] +",experience = "+ req.body['experience'] +",gold = "+ req.body['gold'] +",summary = '"+ req.body['summary'] +"',duree = "+ req.body['duree'] +" WHERE idQuest ="+ req.body['id'], function(err){
                if(err){
                 // //console.log(err.message);
                }else{
		  res.redirect('/guildmaster/gestion/quete');
                }
        })
})


/*supprimer quete */
.get('/guildmaster/gestion/quete/supprimer/:id/:name', urlencodedParser, function(req, res) {
  connection.query("SELECT user.idUser, login, role FROM user, guild where user.idUser = guild.idUser and user.idUser="+req.session.user['id'], function(err, rows, fields){
	if (!err){
	 //console.log(req.params);
	  if (req.session.user['id']==rows[0]['idUser'] && req.session.user['name']==rows[0]['login'] && req.session.user['role']==rows[0]['role']) {
	       connection.query("DELETE FROM quest WHERE idQuest = "+ req.params['id'] +" and name = '"+ req.params['name'] +"'", function(err){})
	       res.redirect('/guildmaster/gestion/quete');
	  }
	}
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // //console.log(err.message);
        }
    })
})


/* ajout d'une quete*/
.post('/guildmaster/gestion/quete/ajout/validation', urlencodedParser, function(req, res) { 
	//console.log(req.body);
        var post={name:req.body.name,
                  difficulty:req.body.difficulty,
		  summary:req.body.summary,
                  experience:req.body.experience,
                  duree:req.body.duree,
		  procLuk:req.body.procLuk,
                  procDex:req.body.procDex,
		  procStr:req.body.procStr,
                  procEnd:req.body.procEnd,
                  procInt:req.body.procInt,
                  gold:req.body.gold};
        connection.query("INSERT INTO quest set ?", post, function(err){
                if(err){
                 // //console.log(err.message);
                }else{
                 // //console.log('success');
                  res.redirect('/guildmaster/gestion/quete');
                }
        })
})

.post('/guildmaster/enregistrer-attributs',urlencodedParser, function(req, res) {
  connection.query("SELECT * FROM heroes WHERE idCrew = " + req.body.idCrew, 
    function(err, rows, fields){
    if (!err){
      var forMin = rows[0].str;
      var dexMin = rows[0].dex;
      var endMin = rows[0].end;
      var intMin = rows[0].intel;
      var lukMin = rows[0].luk;
      if (forMin > req.body.nbFor || dexMin > req.body.nbDex || endMin > req.body.nbEnd || intMin > req.body.nbInt || lukMin > req.body.nbLuk) {
        res.send('Erreur');
      } else {
        var total = parseInt(req.body.nbFor - forMin) + parseInt(req.body.nbDex - dexMin) + parseInt(req.body.nbEnd - endMin) + 
        parseInt(req.body.nbInt - intMin) + parseInt(req.body.nbLuk - lukMin);
        if (total == 0) {
          res.send('Same');
        } else if (total < 0) {
          res.send('Erreur');
        } else if (total > 0) {
          if (total <= rows[0].attrPoints) {
            //Requete
            var diff = rows[0].attrPoints - total;
            connection.query("UPDATE heroes SET str = " + req.body.nbFor +", dex = " + req.body.nbDex +", end = " + req.body.nbEnd +", " +
              "intel = " + req.body.nbInt +", luk = " + req.body.nbLuk + ", attrPoints = " + diff + " WHERE idCrew = " + 
              req.body.idCrew, function(err){
                if (!err)
                  res.send('OK');
                else
                  res.send('Fail');
            })
          } else {
            res.send('Erreur');
          }
        }
      }
    }
    else {
      res.send('Fail');
    }
  })
})

.post('/guildmaster/equipItem',urlencodedParser, function(req, res) {
  var finalSlot = "";
  if (req.body.slot == "handLeft" || req.body.slot == "handRight")
    finalSlot = "hand' OR slot = 'hands";
  else
    finalSlot = req.body.slot;
  var query = "select * from inventory INNER JOIN equipment ON inventory.idEquipment = equipment.idEquipment WHERE idUser = " + 
    req.session.user['id'] + " AND idCrew = " + req.body.idCrew +" AND slot = '" + finalSlot + "'";


  //Check si il y a un item equipe au slot
  connection.query(query, function(err, rows, fields){
    
    if (!err){
      
      if (rows.length > 0) { //Swap les items

        var quer1 = "UPDATE inventory SET idCrew = NULL, handSpecial = NULL WHERE idInventory = " + rows[0]['idInventory'];
        var quer2 = "UPDATE inventory SET idCrew = " + req.body.idCrew + ", handSpecial = '" + req.body.slot + "' WHERE idEquipment = " 
        + req.body.idEquip + " AND idUser = " + req.session.user['id'] + " AND idCrew IS NULL LIMIT 1";

        if (finalSlot == "hand' OR slot = 'hands") { //Si c'est une arme
          if (rows[0]['slot'] == 'hands') { //C'est une arme à deux mains
            connection.query(quer1);
            connection.query(quer2);
            //console.log('Cas 1');
            res.send('OK');
          } else { //Sinon on regarde il est sur quelle main
            if (rows[0]['handSpecial'] != req.body.slot) {
              connection.query(quer2);
              //console.log('Cas 2');
              res.send('OK');
            } else {
              connection.query(quer1);
              connection.query(quer2);
              //console.log('Cas 3');
              res.send('OK');
            }
          }
        } else { //Sinon on UPDATE juste
          connection.query(quer1, function(err){});
          connection.query("UPDATE inventory SET idCrew = " + req.body.idCrew + ", handSpecial = NULL WHERE idEquipment = " + req.body.idEquip + 
            " AND idUser = " + req.session.user['id'] + " AND idCrew IS NULL LIMIT 1", function(err){});
          //console.log('Cas 4');
          res.send('OK');
        }
      } else {
        if (finalSlot == "hand' OR slot = 'hands") {
          connection.query("UPDATE inventory SET idCrew = " + req.body.idCrew + ", handSpecial = '" + req.body.slot + "' WHERE idEquipment = " 
          + req.body.idEquip + " AND idUser = " + req.session.user['id'] + " AND idCrew IS NULL LIMIT 1", function(err){});
          res.send('OK');
        } else {
          connection.query("UPDATE inventory SET idCrew = " + req.body.idCrew + ", handSpecial = NULL WHERE idEquipment = " + req.body.idEquip + 
          " AND idUser = " + req.session.user['id'] + " AND idCrew IS NULL LIMIT 1", function(err){});
          //console.log('Cas 6');
          res.send('OK');
        }
        
      }
    }
    else {
      //console.log(err);
      res.send('Fail');
    }
  })
})

/* On redirige vers l'accueil si la page demandée n'est pas trouvée */
.use(function(req, res, next){
    res.redirect('/guildmaster/');
})

.listen(8080);