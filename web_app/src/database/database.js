// Invoke mysql and dotenv

const mysql = require('mysql');
require('dotenv').config()

// Create mysql connection

const connection = mysql.createConnection({
    host: process.env.DBHOST,
    port: process.env.DBPORT,
    user: process.env.DBUSER,
    password: process.env.DBPASSWORD,
    database: process.env.DBDATABASE
});

// Establish mysql connection

connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to database');
});

module.exports = connection;