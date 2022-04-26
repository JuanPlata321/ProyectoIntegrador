const connection = require('../database/database.js');
const alert = require('alert');
const { NULL } = require('mysql/lib/protocol/constants/types');
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
                    res.render('DashboardAdmin');
                }else{
                    res.render('DashboardUser');
                }
            }else{
                res.render('login');
                alert('Tu cuenta se encuentra actualmente actualmente en mantenimiento o dada de baja en el sistema, por favor contáctate el personal de soporte técnico!');
            }
        }else{
            res.render('login');
            alert('Usuario y/o contraseña incorrecta!');
        }
    });
};

controller.goSearchCustomerQuestions = (req, res) => {
    connection.query('SELECT * FROM FORMULARIO', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchCustomerQuestions', {
                data: results
            });
        }
    });
}

controller.goSearchCustomer = (req, res) => {
    connection.query('SELECT * FROM CLIENTES', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchCustomer', {
                data: results
            });
        }
    });
}

controller.goSearchInvoice = (req, res) => {
    connection.query('SELECT * FROM FACTURAS', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchInvoice', {
                data: results
            });
        }
    });
}

controller.goSearchWarranty = (req, res) => {
    connection.query('SELECT * FROM GARANTIAS', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchWarranty', {
                data: results
            });
        }
    });
}

controller.goSearchPurchaseOrder = (req, res) => {
    connection.query('SELECT ID_ORDEN_COMPRA, FECHA_EMISION_ORDEN, NOMBRE_RESPONSABLE, PORCENTAJE_DESCUENTOS, IMPUESTOS, IMPUESTOS, SUBTOTAL, VALOR_TOTAL, CLIENTE_ID_CLIENTE, EMPLEADOS_ID_EMPLEADO, VEHICULOS_ID_VEHICULOS FROM ORDEN_COMPRA, ORDEN_COMPRA_has_VEHICULOS WHERE ID_ORDEN_COMPRA = ORDEN_COMPRA_ID_ORDEN_COMPRA ORDER BY ID_ORDEN_COMPRA', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchPurchaseOrder', {
                data: results
            });
        }
    });
}

controller.goSearchUser = (req, res) => {
    connection.query('SELECT * FROM EMPLEADOS', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchUser', {
                data: results
            });
        }
    });
}

controller.goSearchVehicle = (req, res) => {
    connection.query('SELECT * FROM VEHICULOS', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchVehicle', {
                data: results
            });
        }
    });
}

controller.goSearchVehicleRegister = (req, res) => {
    connection.query('SELECT * FROM REGISTRO_MOVIMIENTO_VEHICULOS ORDER BY ID_REGISTRO_MOVIMIENTO_VEHICULOS DESC', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchVehicleRegister', {
                data: results
            });
        }
    });
}

controller.goSearchPriceHistory = (req, res) => {
    connection.query('SELECT * FROM HISTORICO_PRECIO', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchPriceHistory', {
                data: results
            });
        }
    });
}

controller.goSearchAcounttingReport = (req, res) => {
    connection.query('SELECT COUNT(ID_ORDEN_COMPRA) \'ORDENES_COMPRA\', SUM(VALOR_TOTAL) \'ORDENES_COMPRA_TOTAL\' FROM ORDEN_COMPRA UNION ALL SELECT COUNT(ID_FACTURA) \'FACTURAS\', SUM(VALOR_TOTAL) \'FACTURAS_COMPRA_TOTAL\' FROM ORDEN_COMPRA, FACTURAS WHERE ID_ORDEN_COMPRA = ORDEN_COMPRA_ID_ORDEN_COMPRA', (error, results) => {
        if (error){
            alert('Ups! Algo ha salido mal al realizar la consulta a la base de datos');
        }else{
            res.render('searchAcounttingReport', {
                data: results
            });
        }
    });
}

controller.goRegisterPurchaseOrderVehicle = (req, res) => {
    res.render('registerPurchaseOrderVehicle');
}

controller.goSearchDataPolicy = (req, res) => {
    res.render('searchDataPolicy');
}

controller.goRegisterCustomer = (req, res) => {
    res.render('registerCustomer');
}

controller.goRegisterInvoice = (req, res) => {
    res.render('registerInvoice');
}

controller.goRegisterPurchaseOrder = (req, res) => {
    res.render('registerPurchaseOrder');
}

controller.goRegisterUser = (req, res) => {
    res.render('registerUser');
}

controller.goRegisterVehicle = (req, res) => {
    res.render('registerVehicle');
}

controller.postPurchaseOrderVehicle = (req, res) => {
    let data = {ORDEN_COMPRA_ID_ORDEN_COMPRA: req.body.idPurchaseOrder, VEHICULOS_ID_VEHICULOS:req.body.idVehicle};
    let sql = "INSERT INTO ORDEN_COMPRA_has_VEHICULOS SET ?";
    
    connection.query(sql, data, function (error, results) {
        res.render('registerPurchaseOrderVehicle');
        if(error){
            alert('Ups! Tuvimos problemas al asociar el vehículo con la orden de compra, revisa los campos ingresados, seguramente algunos ya están en uso o el vehículo u orden de compra ingresada no existe, si el problema persiste contácte con el personal de soporte técnico');
        }else{
            alert('Registro realizado exitosamente!');
        }
    });
}

controller.postInvoice = (req, res) => {
    let data = {FECHA_EMISION_FACTURA: '', DATOS_EMPRESA: '', ORDEN_COMPRA_ID_ORDEN_COMPRA:req.body.date};
    let sql = "INSERT INTO FACTURAS SET ?";
    
    connection.query(sql, data, function (error, results) {
        res.render('registerInvoice');
        if(error){
            alert('Ups! Tuvimos problemas al realizar el registro del vehículo, revisa los campos ingresados, seguramente algunos ya están en uso y si el problema persiste contácte con el personal de soporte técnico');
        }else{
            alert('Registro realizado exitosamente!');
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

controller.postPurchaseOrder = (req, res) => {
    let data = {nombre_responsable:req.body.name, porcentaje_descuentos:req.body.discount, impuestos:req.body.tax, cliente_id_cliente:req.body.idCustomer, empleados_id_empleado:req.body.idEmployee};
    let sql = "INSERT INTO ORDEN_COMPRA SET ?";
    
    connection.query(sql, data, function (error, results) {
        res.render('registerPurchaseOrder');
        if(error){
            alert('Ups! Tuvimos problemas al realizar el registro de la orden de compra, revisa los campos ingresados, si el problema persiste contácte con el personal de soporte técnico');
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