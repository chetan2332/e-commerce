const Razorpay = require('razorpay')
require('dotenv').config()

const KEY_ID = process.env.KEY_ID
const KEY_SECRET = process.env.KEY_SECRET

var instance = new Razorpay({
    key_id: KEY_ID,
    key_secret: KEY_SECRET,
})

module.exports = instance