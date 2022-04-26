const express = require('express');
const router = express.Router();

const customerController = require('../controllers/customerController');

router.get('/', customerController.init);
router.get('/index', customerController.index);
router.get('/about', customerController.about);
router.get('/products', customerController.products);
router.get('/contact', customerController.contact);
router.get('/dataPolicy', customerController.dataPolicy);

router.get('/goSearchVehicle', customerController.goSearchVehicle);

router.post('/postForm', customerController.postForm);

module.exports = router;