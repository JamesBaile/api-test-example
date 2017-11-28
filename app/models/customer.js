var mongoose = require('mongoose');

var CustomerSchema   = new mongoose.Schema({
  customerId: String,
  name: String
});

module.exports = mongoose.model('Customer', CustomerSchema);