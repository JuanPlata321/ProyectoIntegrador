// Invoke express, alert, ejs, path

const { application } = require('express');
const express = require('express');
const app = express();
const path = require('path');
app.set('view engine', 'ejs');

// View definition path

app.set('views', path.join(__dirname, 'views'));

// Middlewares

// const connection = require('./database/database.js');
app.use(express.urlencoded({extended:false}));

// Routes

const customerRoutes = require('./routes/customer');
app.use('/', customerRoutes);

// Static files

app.use(express.static(path.join(__dirname, 'public')));

// Server basic configuration

const port =  443;

app.listen(port, () => {
    console.log(`Server running on port 443`);
});

/*

// Display data for items 

app.get('/getVehicles', (req, res) => {
    connection.query('SELECT * FROM VEHICULOS', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realziar la consulta a la base de datos');
        }else{
            res.send(results);
        }
    })
});

// Display data for clients 

app.get('/getClients', (req, res) => {
    connection.query('SELECT * FROM CLIENTES', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
            throw error;
        }else{
            // res.write("<table>");
            // res.write("<tr>");
            // for(var column in results[0]){
                // res.write("<th><label>" + column + "</label></th>");
            // }
            // res.write("</tr>");
            // for(var row in results){
                // res.write("<tr>");
                // for(var column in results[ row ]){
                    // res.write("<td><label>" + results[ row ][ column ] + "</label></td>");       
                // }
                // res.write("</tr>");         
            // }
            // res.write("</table>");
            // res.send(results);
        }
    })
});

// Display data for users

app.get('/getUsers', (req, res) => {
    connection.query('SELECT * FROM EMPLEADO', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.send(results);
        }
    })
});

// Register items

app.post('/postVehicles', (req, res) => {
    let data = {marca:req.body.brand, modelo:req.body.model, año:req.body.year, descripcion:req.body.description, tipo:req.body.type, imagen_url:req.body.image, unidades_stock:req.body.unit, valor_unitario:req.body.value};
    let sql = "INSERT INTO VEHICULOS SET ?";
    connection.query(sql, data, function (error, results) {
        res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/registroVehiculo.html');
        if(error){
            alert('Ups! Tuvimos problemas al realizar el registro del vehículo, revisa los campos ingresados, seguramente algunos ya están en uso y si el problema persiste contácte con el personal de soporte técnico');
        }else{
            alert('Registro realizado exitosamente!');
        }
    });
});

// Register clients

app.post('/postClients', (req, res) => {

    const patternEmail = new RegExp(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
    const email = req.body.email;

    if (patternEmail.test(email)){
        let data = {cedula_nit:req.body.identification, nombres:req.body.name, correo_electronico:req.body.email, contacto:req.body.contact, direccion:req.body.address};
        let sql = "INSERT INTO CLIENTES SET ?";
        connection.query(sql, data, function (error, results) {
            res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/registroCliente.html');
            if(error){
                alert('Ups! Tuvimos problemas al realizar el registro del cliente, revisa los campos ingresados, seguramente algunos ya están en uso y si el problema persiste contácte con el personal de soporte técnico');
            }else{
                alert('Registro realizado exitosamente!');
            }
        });
    }else{
        alert("La dirección de correo electrónico ingresada no es válida!");
    }
});

// Register users

app.post('/postUsers', (req, res) => {

    const area = req.body.area;
    const status = req.body.status;
    
    if (area != 0 && status != 0){

        const patternEmail = new RegExp(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        const patternPassword = new RegExp(/^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/);
        
        const pass = req.body.pass;
        const email = req.body.email; 


        if (patternEmail.test(email)){
            if(pass.length > 8 && patternPassword.test(pass)){
                //Invoke crypto

                const crypto = require('crypto');

                let encryptPassword = crypto.createHash("sha256").update(pass).digest('hex');

                let data = {cedula:req.body.identification, nombres:req.body.name, apellidos:req.body.lastname, correo_electronico:email, contacto:req.body.contact, direccion:req.body.address, contrasena:encryptPassword, departamento_area_id_departamento_area:area, estado_empleado_id_estado_empleado:status};
                let sql = "INSERT INTO EMPLEADOS SET ?";
                connection.query(sql, data, function (error, results) {
                    res.sendFile('D:/User/Personal/Universidad/2.5 Quinto semestre/Proyecto integrador/Desarrollo/Implementación/Github Repository/web_app/html/registroUsuario.html');
                    if(error){
                        alert('Ups! Tuvimos problemas al realizar el registro del cliente, revisa los campos ingresados, seguramente algunos ya están en uso y si el problema persiste contácte con el personal de soporte técnico');
                    }else{
                        alert('Registro realizado exitosamente!');
                    }
                });
            }else{
                alert("La contraseña no es válida! Esta debe tener más de ocho caracteres, incluir al menos una letra en minúscula y una en mayúscula, incluir un número y un caracter especial, entre estos últimos están únicamente los siguientes !@#$%^&*");
            }
        }else{
            alert("La dirección de correo electrónico ingresada no es válida!");
        }
    }else{
        alert("Por favor, selecciona una opción para cada una de las secciones desplegables!");
    }
});

module.exports = app;*/