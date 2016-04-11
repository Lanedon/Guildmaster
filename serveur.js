var express     = require('express');
var session     = require('cookie-session'); // Charge le middleware de sessions
var bodyParser  = require('body-parser');    // Charge le middleware de gestion des paramètres  
var mysql       = require('mysql');

var connection = mysql.createConnection({
  host     : "localhost",
  user     : "root",
  password : "sio",
  database : "guildmaster"
});
var urlencodedParser = bodyParser.urlencoded({ extended: false });

var app = express();
app.use(express.static(__dirname + '/public'));
/*
connection.connect(function(err){
  if(!err) {
      console.log("Database is connected ... \n\n");  
  } else {
      console.log("Error connecting database ... \n\n" + err);  
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
                 // console.log(err.message);
                }else{
                 // console.log('success');
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
       connection.query("SELECT user.idUser, role FROM user WHERE login = '"+ req.body.pseudo +"' and pass = '"+ req.body.MdP +"'", function(err, rows, fields) {
		//console.log(rows);
		if (rows !== undefined && rows[0] !== undefined ){
		        var user = {id:rows[0]['idUser'],
				    role:rows[0]['role']};
			if(rows[0]['role']!=='en attente'){
			  connection.query("SELECT gold FROM guild where idUser = '"+ rows[0]['idUser'] +"'", function(err, rows, fields) {
				  req.session.user = {id:user['id'], role:user['role'], gold:rows[0]['gold']};
				  res.redirect('/guildmaster/');
			  })
			}
			else{
			  req.session.user = {id:user['id'], role:user['role']};
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
		  gold: 100,
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
		     // console.log('success');
		     req.session.user = {id:req.session.user['id'], role:'user', gold:'100'};
		     res.redirect('/guildmaster');
		    }
		  })
                }
        })
})

/* personnel */
.get('/guildmaster/personnel',urlencodedParser, function(req, res) {
     connection.query("SELECT crew.idCrew, name, surname, level, talent, fee, job, 0 as hero FROM worker, crew WHERE idUser = '"+ req.session.user['id'] +"' and worker.idCrew = crew.idCrew UNION SELECT crew.idCrew, name, surname, level, talent, fee, classe, 1 as hero FROM heroes, crew WHERE idUser = '"+ req.session.user['id'] +"' and heroes.idCrew = crew.idCrew" , function(err, rows, fields){
	if (!err){  
	   //console.log(rows);
	    res.render('personnel.ejs', {data:rows, user:req.session.user});
      }
	else{
         res.render('personnel.ejs', {user:req.session.user});
	 // console.log(err.message);
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
             connection.query("SELECT classe, prestige, str, dex, intel, luk, end, handRight, handLeft, torso, head, legs, feet  FROM heroes WHERE idCrew = '"+ req.params['id'] +"'", function(err, rows, fields){
              if (!err){
                //console.log(rows);
                res.render('detail.ejs', {data:rows, user: req.session.user});
                //console.log(data);
              }
              else{
               res.redirect('/guildmaster/personnel');
               // console.log(err.message);
              }
             }) 
          }
      }
      else{
        res.render('personnel.ejs', {user:req.session.user});
        // console.log(err.message);
      }
    })
	//console.log(req.session.user);	
})

/* recruter personnel */
.get('/guildmaster/recruter', function(req, res) { 
     connection.query("SELECT crew.idCrew, name, surname, level, talent, fee, job, 0 as hero FROM worker, crew WHERE idUser is null and worker.idCrew = crew.idCrew UNION SELECT crew.idCrew, name, surname, level, talent, fee, classe, 1 as hero FROM heroes, crew WHERE idUser is null and heroes.idCrew = crew.idCrew" , function(err, rows, fields){
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
             connection.query("select name, surname, crew.idCrew, classe, prestige, str, dex, intel, luk, end, handRight, handLeft, torso, head, legs, feet  FROM crew, heroes WHERE crew.idCrew = '"+ req.params['id'] +"'", function(err, rows, fields){
              if (!err){
                //console.log(rows);
                res.render('detailRecrue.ejs', {data:rows, user: req.session.user});
                //console.log(data);
              }
              else{
               res.redirect('/guildmaster/recruter');
               // console.log(err.message);
              }
             })
          }
        })
	//console.log(req.session.user);	
})

/* recruter personnel */
.get('/guildmaster/recruter/:id/:name/:surname', function(req, res) { 
     connection.query("SELECT crew.idCrew, name, surname, level, talent, fee, job, 0 as hero FROM worker, crew WHERE crew.idcrew = '"+ req.params['id'] +"' and worker.idCrew = crew.idCrew UNION SELECT crew.idCrew, name, surname, level, talent, fee, classe, 1 as hero FROM heroes, crew WHERE crew.idcrew = '"+ req.params['id'] +"' and heroes.idCrew = crew.idCrew" , function(err, rows, fields){
	if (rows !== undefined && rows[0] !== undefined ){
	  var perso={name:rows[0]['name'],
                    surname:rows[0]['surname'],
                    level:rows[0]['level'],
		    talent:rows[0]['talent'],
		    fee:rows[0]['fee'],
		    idUser:req.session.user['id']};
	  var hero = {job:rows[0]['job'],
		      hero:rows[0]['hero']};
	  connection.query("INSERT INTO crew set ?", perso, function(err){
                if(err){
                 // console.log(err.message);
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
			    // console.log(err.message);
			    res.redirect('/guildmaster/recruter');	
			   }else{
			    // console.log('success');
			    res.redirect('/guildmaster/personnel');
			   }
		       })
		     }
// hero // 
		    if (hero['hero']==1) {
		      connection.query("SELECT classe, prestige, str, dex, intel, luk, end, handRight, handLeft, torso, head, legs, feet  FROM heroes WHERE idCrew = '"+ req.params['id'] +"'", function(err, rows, fields){
			if (rows !== undefined && rows[0] !== undefined){
			   var detailPers={classe:rows[0]['classe'],
					   prestige:rows[0]['prestige'],
					   str:rows[0]['str'],
					   dex:rows[0]['dex'],
					   intel:rows[0]['intel'],
					   luk:rows[0]['luk'],
					   end:rows[0]['end'],
					   handRight:rows[0]['handRight'],
					   handLeft:rows[0]['handLeft'],
					   torso:rows[0]['torso'],
					   head:rows[0]['head'],
					   legs:rows[0]['legs'],
					   feet:rows[0]['feet'],
					   idCrew:detail['idCrew']};
			  connection.query("INSERT INTO heroes set ?", detailPers, function(err){
			    if(err){
			    //  console.log(err.message);
			     res.redirect('/guildmaster/recruter');	
			    }else{
			     // console.log('success');
			     res.redirect('/guildmaster/personnel');
			    }
			  })
			}
			else{
			 res.redirect('/guildmaster/recruter');
			 // console.log(err.message);
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
	 // console.log(err.message);
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
             connection.query("SELECT classe, prestige, str, dex, intel, luk, end FROM heroes WHERE idSquad = '"+ req.params['id'] +"'", function(err, rows, fields){
              if (!err){
                //console.log(rows);
                res.render('detailEscouades.ejs', {data:rows, user: req.session.user});
                //console.log(data);
              }
              else{
               res.redirect('/guildmaster/personnel');
               // console.log(err.message);
              }
             }) 
          }
      }
      else{
        res.render('personnel.ejs', {user:req.session.user});
        // console.log(err.message);
      }
    })
	//console.log(req.session.user);	
})


/* nouvelle escouade */
.get('/guildmaster/escouades/creer', function(req, res) {
    if (req.session.user['role']=='admin' || req.session.user['role']=='user') {
         connection.query("SELECT heroes.idCrew, classe, prestige, str, dex, intel, luk, end FROM heroes, crew WHERE idUser = '"+ req.session.user['id'] +"' and idSquad is null and crew.idCrew = heroes.idCrew", function(err, rows, fields){
              if (!err){
                res.render('creerEscouade.ejs', {data:rows, user: req.session.user});
              }
              else{
               res.redirect('/guildmaster/personnel');
               // console.log(err.message);
              }
             }) 
    } else
      res.redirect('/guildmaster/');
})



/* nouvelle escouade validation */
.post('/guildmaster/escouades/creer/validation', urlencodedParser, function(req, res) { 
	var squad={name:req.body.name,
		   experience: 0,
		   idUser: req.session.user['id']};
        var membres = req.body.membres;
        connection.query("INSERT INTO squad set ?", squad, function(err){
                if(err){
                 // console.log(err.message);
		 res.redirect('/guildmaster/');
                }else{
		  connection.query("select MAX(idSquad) FROM squad" , function(err, rows, fields){
		    var idSquad = rows[0]['MAX(idSquad)'];
		      for (i=0;i<membres.length;i++) {
			connection.query("UPDATE heroes SET idSquad = "+ idSquad +" WHERE idCrew = "+ membres[i] +";", function(err){
			  if(err){
			    connection.query("DELETE FROM squad WHERE idSquad = "+ idSquad , function(err){});
			    res.redirect('/guildmaster/');
			  }else{
			   // console.log('success');
			  }
		        })
		      }
		      res.redirect('/guildmaster/escouades/detail/'+idSquad+'/'+squad['name']);
		  })
                }
        })
})


/*supprimer escouade */
.get('/guildmaster/escouades/supprimer/:id/:name', urlencodedParser, function(req, res) {
        connection.query("DELETE FROM squad WHERE idSquad = "+ req.params['id'] +" and name = '"+ req.params['name'] +"'", function(err){
	    if(err){
	     // console.log(err.message);
	    }else{
	    }
        })
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
	 // console.log(err.message);
        }
    })
})



/* inventaire */
.get('/guildmaster/inventaire', function(req, res) { 
     connection.query("SELECT idInventory, quantity, name, price, rarity, description, minStr, minDex, minInt, minLuk, minEnd, bonusStr, bonusDex, bonusInt, bonusLuk, bonusEnd FROM inventory,equipment WHERE idUser = '"+ req.session.user['id'] +"' and inventory.idEquipment = equipment.idEquipment ", function(err, rows, fields){
	if (!err){
	   //console.log(rows);
	    res.render('inventaire.ejs', {data:rows, user:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('inventaire.ejs', {user:req.session.user});
	 // console.log(err.message);
        }
    })
})

/* quete */
.get('/guildmaster/quete', function(req, res) { 
     connection.query("SELECT idQUest, experience, name, summary, length, reward FROM quest", function(err, rows, fields){
	if (!err){
	   //console.log(rows);
	    res.render('quete.ejs', {data:rows, user:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('queste.ejs', {user:req.session.user});
	 // console.log(err.message);
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
	   //console.log(rows);
	    res.render('gestion.ejs', {data:rows, user:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('accueil.ejs', {user:req.session.user});
	 // console.log(err.message);
        }
    })
})

/* On redirige vers l'accueil si la page demandée n'est pas trouvée */
.use(function(req, res, next){
    res.redirect('/guildmaster/');
})

.listen(8080);