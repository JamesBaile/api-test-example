'use strict';

const apickli = require('apickli');
const {defineSupportCode} = require('cucumber');

defineSupportCode(function({Before}) {
    Before(function() {
        const host = process.env.SERVICE_UNDER_TEST_HOSTNAME || "localhost:3000";
        this.apickli = new apickli.Apickli('http', host);
    });
});