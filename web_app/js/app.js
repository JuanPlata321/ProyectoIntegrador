// Invoke express

const express = require('express');
const app = express();

// Urlencoded to capture form data

app.use(express.urlencoded({extended:false}));
app.use(express.json());

// Server basic configuration

const port =  443;

app.use(express.static('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app'));

app.listen(port, () => {
    console.log(`Server running on port 443`);
});

// Routes definition

app.get('/', function(req, res){
    res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/login.html');
    //console.log('Se recibio una peticion tipo get');
});

app.post("/auth", async(req, res) => {
    const user = req.body.user;
    const pass = req.body.pass;

    // Invoke alert

    const alert = require('alert');

    //Invoke crypto

    const crypto = require('crypto');

    let encryptPassword = crypto.createHash("sha256").update(pass).digest('hex');

    connection.query('SELECT * FROM EMPLEADO WHERE CORREO_ELECTRONICO = ? AND CONTRASENA = ?', [user, encryptPassword], async(error, results)=>{
        if (results.length > 0){
            if (results[0].ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO == '1'){
                if (results[0].DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA == '1'){
                    res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/panelAdmin.html');
                }else{
                    res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/panelUsuario.html');
                }
            }else{
                res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/login.html');
                alert('Tu cuenta se encuentra actualmente actualmente en mantenimiento o dada de baja en el sistema, por favor contáctate el personal de soporte técnico!');
            }
        }else{
            res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/login.html');
            alert('Usuario y/o contraseña incorrecta!');
        }
    });
});

// Database connection

const connection = require('./database.js');