const express = require('express');
const router = express.Router();

const customerController = require('../controllers/customerController');

router.get('/', customerController.init);
router.post('/login', customerController.login);

router.get('/goSearchCustomer', customerController.goSearchCustomer);
router.get('/goSearchInvoice', customerController.goSearchInvoice);
router.get('/goSearchWarranty', customerController.goSearchWarranty);
router.get('/goSearchPurchaseOrder', customerController.goSearchPurchaseOrder);
router.get('/goSearchUser', customerController.goSearchUser);
router.get('/goSearchVehicle', customerController.goSearchVehicle);
router.get('/goSearchVehicleRegister', customerController.goSearchVehicleRegister);
router.get('/goSearchPriceHistory', customerController.goSearchPriceHistory);
router.get('/goSearchAcounttingReport', customerController.goSearchAcounttingReport);
router.get('/goSearchDataPolicy', customerController.goSearchDataPolicy);

router.get('/goRegisterPurchaseOrderVehicle', customerController.goRegisterPurchaseOrderVehicle);
router.get('/goRegisterCustomer', customerController.goRegisterCustomer);
router.get('/goRegisterInvoice', customerController.goRegisterInvoice);
router.get('/goRegisterPurchaseOrder', customerController.goRegisterPurchaseOrder);
router.get('/goRegisterUser', customerController.goRegisterUser);
router.get('/goRegisterVehicle', customerController.goRegisterVehicle);

router.post('/postPurchaseOrderVehicle', customerController.postPurchaseOrderVehicle);
router.post('/postInvoice', customerController.postInvoice);
router.post('/postVehicles', customerController.postVehicles);
router.post('/postPurchaseOrder', customerController.postPurchaseOrder);
router.post('/postCustomers', customerController.postCustomers);
router.post('/postUsers', customerController.postUsers);

module.exports = router;