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