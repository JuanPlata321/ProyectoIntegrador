const connection = require('../database/database.js');
const alert = require('alert');
const controller = {}

controller.init = (req, res) => {
    res.render('login');
};

controller.login = (req, res) => {
    const user = req.body.user;
    const pass = req.body.pass;

    //Invoke crypto

    const crypto = require('crypto');

    let encryptPassword = crypto.createHash("sha256").update(pass).digest('hex');

    connection.query('SELECT * FROM EMPLEADOS WHERE CORREO_ELECTRONICO = ? AND CONTRASENA = ?', [user, encryptPassword], async(error, results)=>{
        if (results.length > 0){
            if (results[0].ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO == '1'){
                if (results[0].DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA == '1'){
                    res.render('adminDashboard');
                }else{
                    res.render('userDashboard');
                }
            }else{
                res.render('login');
                alert('Tu cuenta se encuentra actualmente actualmente en mantenimiento o dada de baja en el sistema, por favor contáctate el personal de soporte técnico!');
            }
        }else{
            res.sendFile('login');
            alert('Usuario y/o contraseña incorrecta!');
        }
    });
};

controller.goSearchCustomer = (req, res) => {
    res.render('searchCustomer');
}

controller.goSearchVehicle = (req, res) => {
    res.render('searchVehicle');
}

controller.goSearchUser = (req, res) => {
    res.render('searchUser');
}

controller.goAcounttingReport = (req, res) => {
    res.render('acounttingReport');
}

controller.goPurchaseOrder = (req, res) => {
    res.render('purchaseOrderRegister');
}

controller.goDataPolicy = (req, res) => {
    res.render('dataPolicy');
}

controller.goRegisterCustomer = (req, res) => {
    res.render('registerCustomer');
}

controller.goRegisterVehicle = (req, res) => {
    res.render('registerVehicle');
}

controller.goRegisterUser = (req, res) => {
    res.render('registerUser');
}

controller.getVehicles = (req, res) => {
    connection.query('SELECT * FROM VEHICULOS', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realziar la consulta a la base de datos');
        }else{
            res.send(results);
        }
    });
}

controller.getCustomers = (req, res) => {
    connection.query('SELECT * FROM CLIENTES', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
            throw error;
        }else{
            res.send(results);
        }
    });
}

controller.getUsers = (req, res) => {
    connection.query('SELECT * FROM EMPLEADO', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.send(results);
        }
    });
}

controller.postVehicles = (req, res) => {
    let data = {marca:req.body.brand, modelo:req.body.model, año:req.body.year, descripcion:req.body.description, tipo:req.body.type, imagen_url:req.body.image, unidades_stock:req.body.unit, valor_unitario:req.body.value};
    let sql = "INSERT INTO VEHICULOS SET ?";
    
    connection.query(sql, data, function (error, results) {
        res.render('registerVehicle');
        if(error){
            alert('Ups! Tuvimos problemas al realizar el registro del vehículo, revisa los campos ingresados, seguramente algunos ya están en uso y si el problema persiste contácte con el personal de soporte técnico');
        }else{
            alert('Registro realizado exitosamente!');
        }
    });
}

controller.postCustomers = (req, res) => {
    const patternEmail = new RegExp(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
    const email = req.body.email;

    if (patternEmail.test(email)){
        let data = {cedula_nit:req.body.identification, nombres:req.body.name, correo_electronico:req.body.email, contacto:req.body.contact, direccion:req.body.address};
        let sql = "INSERT INTO CLIENTES SET ?";

        connection.query(sql, data, function (error, results) {
            res.render('registerCustomer');
            if(error){
                alert('Ups! Tuvimos problemas al realizar el registro del cliente, revisa los campos ingresados, seguramente algunos ya están en uso y si el problema persiste contácte con el personal de soporte técnico');
            }else{
                alert('Registro realizado exitosamente!');
            }
        });
    }else{
        alert("La dirección de correo electrónico ingresada no es válida!");
    }
}

controller.postUsers = (req, res) => {
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
                    
                    res.render('registerUser');
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
}

module.exports = controller;