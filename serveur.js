var express     = require('express');
var session     = require('cookie-session'); // Charge le middleware de sessions
var bodyParser  = require('body-parser');    // Charge le middleware de gestion des paramètres  
var mysql = require('mysql');

var connection = mysql.createConnection({
  host     : "localhost",
  user     : "root",
  password : "sio",
  database : "guildmaster"
});
var urlencodedParser = bodyParser.urlencoded({ extended: false });



var app = express();
app.use(express.static(__dirname + '/public'));

/* connection.connect(function(err){
  if(!err) {
      //console.log("Database is connected ... \n\n");  
  } else {
      //console.log("Error connecting database ... \n\n");  
  }
}); */

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
    res.render('accueil.ejs', {role: req.session.user});
	//console.log(req.session.user);
	
})

/* Inscription */
.get('/guildmaster/inscription', function(req, res) {
    res.render('inscription.ejs', {role: req.session.user});
  
})


/* Inscription validation*/
.post('/guildmaster/inscription/validation', urlencodedParser, function(req, res) { 
	//console.log(req.body);
        var post={login:req.body.pseudo,
                  pass:req.body.mdp,
                  email:req.body.email,
                  role:'utilisateur'};
        connection.query("INSERT INTO user set ?", post, function(error){
                if(error){
                 // console.log(error.message);
                }else{
                 // console.log('success');
                  res.redirect('/guildmaster');
                }
        })
})

/* Connexion */
.get('/guildmaster/connexion', function(req, res) {
    res.render('connexion.ejs', {role: req.session.user});
})

/* Connexion validation*/
.post('/guildmaster/connexion/validation', urlencodedParser, function(req, res) { 
       //console.log('pseudo',req.body.pseudo);
       //console.log('MdP',req.body.MdP);
       connection.query("SELECT idUser, role FROM user WHERE login = '"+ req.body.pseudo +"' and pass = '"+ req.body.MdP +"'", function(err, rows, fields) {
		//console.log(rows);	 
		if (rows !== undefined && rows[0] !== undefined ){	
			//if(rows[0]['etat']==1){
				req.session.user = {id:rows[0]['idUser'],role:rows[0]['role']};
				res.redirect('/guildmaster/');
			//}
		}
		else{
	   		res.redirect('/guildmaster/connexion');		
		}
	})
})


/* personnel */
.get('/guildmaster/personnel', function(req, res) { 
     connection.query("SELECT name, surname, level, talent, fee FROM crew WHERE idUser = '"+ req.session.user['id'] +"'", function(err, rows, fields){
	if (!err){
	   console.log(rows);
	    res.render('personnel.ejs', {data:rows, role:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('personnel.ejs', {role:req.session.user});
	 // console.log(err.message);
        }
    })
})

/* recruter personnel */
.get('/guildmaster/personnel/recruter', function(req, res) { 
    res.render('recruter.ejs', {role: req.session.user});
	//console.log(req.session.user);
        
	
})

/* inventaire */
.get('/guildmaster/inventaire', function(req, res) { 
     connection.query("SELECT objets.nomObjet ,objets.strength, objets.intelligence, objets.vitalite, objets.dexterite, objets.niveauRequis, objets.classeRequise FROM equipement, inventaire WHERE inventaire.User_idUser = '"+ req.session.user['id'] +"'AND objets.idObjets = inventaire.objets_idObjets", function(err, rows, fields){
	if (!err){
	   console.log(rows);
	    res.render('inventaire.ejs', {data:rows, role:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('inventaire.ejs', {role:req.session.user});
	 // console.log(err.message);
        }
    })
})


/* quete */
.get('/guildmaster/quete', function(req, res) { 
    res.render('quete.ejs', {role: req.session.user});
	//console.log(req.session.user);
	
})


/* deconnexion */
.get('/guildmaster/deconnexion', function(req, res) {
    req.session = null;
    res.redirect('/guildmaster/');
})
 


/* gestion utilisateur */
.get('/guildmaster/gestion', function(req, res) { 
     connection.query("SELECT idUser, pseudo, nomGuilde ,mail ,role FROM User", function(err, rows, fields){
	if (!err){
	   //console.log(rows);
	    res.render('gestion.ejs', {data:rows, role:req.session.user});
	   //console.log(data);
      }
	else{
         res.render('gestion.ejs', {role:req.session.user});
	 // console.log(err.message);
        }
    })
	
})



/* On redirige vers l'accueil si la page demandée n'est pas trouvée */
.use(function(req, res, next){
    res.redirect('/guildmaster/');
})

.listen(8080);