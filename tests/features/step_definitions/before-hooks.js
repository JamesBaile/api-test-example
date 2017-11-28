'use strict';

const apickli = require('apickli');

module.exports = function () {
  this.Before(function (scenario, callback) {
    const host = process.env.SERVICE_UNDER_TEST_HOSTNAME || "localhost:8081";
    this.apickli = new apickli.Apickli('http', host);
    callback();
  });
};