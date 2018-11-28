'use strict';

var express = require('express');
var bodyParser = require('body-parser')

var request = require('request');

var port = process.env.PORT || 3000;

var app = express();

var customers = {};

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));

var router = express.Router();

router.get('/health', function (req, res) {

    var options = {
        url: 'https://www.comparethemarket.com',
        headers: {
          'User-Agent': 'request'}
      };

    request(options, function (error, response, body) {
        res.json({ serviceName: 'api-test', version: "1.0.0.4", isOK: true , responseStatus: response.statusCode, cookies : response.headers['set-cookie']});
  //console.log('error:', error); // Print the error if one occurred
    //  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
      //console.log('body:', body); // Print the HTML for the Google homepage.
    });

    
});

router.get('/customer:customerid', function (req, res) {
    res.json(customers[eq.params.customerid])
});

router.post('/customer', function (req, res) {
    if (req.body == {}){
        res.status(400).send();
    }
    customers[req.body.customerId] = req.body;

    res.status(201).json({ message: 'Customer usage saved', data: req.body });
});

app.use('/', router);

app.listen(port);

console.log('Running on http://localhost:' + port);
