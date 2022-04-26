const connection = require('../database/database.js');
const alert = require('alert');
const { NULL } = require('mysql/lib/protocol/constants/types');
const controller = {}

controller.init = (req, res) => {
    res.render('index');
};

controller.index = (req, res) => {
    res.render('index');
};

controller.about = (req, res) => {
    res.render('about');
};

controller.products = (req, res) => {
    res.render('products');
};

controller.contact = (req, res) => {
    res.render('contact');
};

controller.dataPolicy = (req, res) => {
    res.render('dataPolicy');
};

controller.goSearchVehicle = (req, res) => {
    connection.query('SELECT MARCA, MODELO, AÑO, DESCRIPCION, TIPO, VALOR_UNITARIO FROM VEHICULOS ORDER BY AÑO DESC', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('products', {
                data: results
            });
        }
    });
}

controller.postForm = (req, res) => {
    let data = {CORREO_ELECTRONICO:req.body.email, ASUNTO:req.body.subject, COMENTARIO:req.body.comment};
    let sql = "INSERT INTO FORMULARIO SET ?";
    
    connection.query(sql, data, function (error, results) {
        res.render('contact');
        if(error){
            alert('Ups! Tuvimos problemas al realizar el registro del vehículo, revisa los campos ingresados, seguramente algunos ya están en uso y si el problema persiste contácte con el personal de soporte técnico');
        }else{
            alert('Registro realizado exitosamente!');
        }
    });
}

module.exports = controller;