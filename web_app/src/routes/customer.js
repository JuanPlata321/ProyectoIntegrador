const express = require('express');
const router = express.Router();

const customerController = require('../controllers/customerController');

router.get('/', customerController.init);
router.post('/login', customerController.login);

router.get('/goSearchCustomer', customerController.goSearchCustomer);
router.get('/goSearchVehicle', customerController.goSearchVehicle);
router.get('/goSearchUser', customerController.goSearchUser);
router.get('/goAcounttingReport', customerController.goAcounttingReport);
router.get('/goPurchaseOrder', customerController.goPurchaseOrder);
router.get('/goDataPolicy', customerController.goDataPolicy);
router.get('/goRegisterCustomer', customerController.goRegisterCustomer);
router.get('/goRegisterVehicle', customerController.goRegisterVehicle);
router.get('/goRegisterUser', customerController.goRegisterUser);

router.get('/getVehicles', customerController.getVehicles);
router.get('/getCustomers', customerController.getCustomers);
router.get('/getUsers', customerController.getUsers);

router.post('/postVehicles', customerController.postVehicles);
router.post('/postCustomers', customerController.postCustomers);
router.post('/postUsers', customerController.postUsers);

module.exports = router;