'use strict';

var express = require('express');
var mongoose = require('mongoose');
var bodyParser = require('body-parser')
var Customer = require('./models/customer');

var port = process.env.PORT || 3000;
var mongoConnection = process.env.MONGO || 'mongodb://mongo:27017/api-test';

console.log(mongoConnection);

mongoose.connect(mongoConnection);
mongoose.Promise = global.Promise;

var app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));

var router = express.Router();

router.get('/health', function (req, res) {
    res.json({ serviceName: 'api-test', version: "1.0.0.1", isOK: true });
});

router.get('/customer:customerid', function (req, res) {
    Customer.findById(req.params.customerid, function (err, customer) {
        if (err)
            res.status(424).send(err);

        res.json(customer);
    });
});

router.post('/customer', function (req, res) {

    var customer = new Customer();

    customer.customerId = req.body.customerId;
    customer.name = req.body.name;

    console.log("request body = " + JSON.stringify(req.body));

    console.log("customer id = " + customer.customerId + ', customer name = ' + customer.name);
    if (customer.name){
        customer.save(function (err) {
            if (err)
                res.status(424).send(err);

            res.status(201).json({ message: 'Customer usage saved', data: customer });
            return;
        });
    }
    res.status(400).send();
});

app.use('/', router);

app.listen(port);

console.log('Running on http://localhost:' + port);
