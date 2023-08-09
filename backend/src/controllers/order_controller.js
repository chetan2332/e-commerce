const CartModel = require("../models/cart_model")
const OrderModel = require("../models/order_model")
const razorpay = require("../services/razorpay")

const OrderController = {

    createOrder: async function (req, res) {
        try {
            const { user, items, status, totalAmount } = req.body

            // create order in razorpay
            const razorPayOrder = await razorpay.orders.create({
                amount: totalAmount * 100,
                currency: "INR",
            })

            const newOrder = new OrderModel({ user, items, status, razorPayOrderId: razorPayOrder.id, totalAmount })
            await newOrder.save()

            // UPDATE THE CART  
            await CartModel.findOneAndUpdate(
                { user: user._id },
                { items: [] },
            )

            return res.json({ success: true, data: newOrder, message: "order created" })
        } catch (ex) {
            return res.json({ success: false, message: ex })
        }
    },

    fetchOrderForUser: async function (req, res) {
        try {
            const userId = req.params.userId
            const foundOrder = await OrderModel.find({ "user.id": userId })
            if (!foundOrder) {
                return res.json({ success: true, data: [] })
            }
            return res.json({ success: true, data: foundOrder })
        } catch (ex) {
            return res.json({ success: false, message: ex })
        }
    },

    updateOrderStatus: async function (req, res) {
        try {
            const { orderId, status, razorPayPaymentId, razorPaySignature } = req.body
            const updatedOrder = await OrderModel.findOneAndUpdate(
                { _id: orderId },
                { status, razorPayPaymentId, razorPaySignature },
                { new: true }
            )
            return res.json({ success: true, data: updatedOrder })
        } catch (ex) {
            return res.json({ success: false, message: ex })
        }
    },

}

module.exports = OrderController