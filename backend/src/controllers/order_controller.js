const OrderModel = require("../models/order_model")

const OrderController = {

    createOrder: async function (req, res) {
        try {
            const { user, items, status } = req.body
            const newOrder = new OrderModel({ user, items, status })
            await newOrder.save()
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
            const { orderId, status } = req.body
            const updatedOrder = await OrderModel.findOneAndUpdate(
                { _id: orderId },
                { status },
                { new: true }
            )
            return res.json({ success: true, data: updatedOrder })
        } catch (ex) {
            return res.json({ success: false, message: ex })
        }
    },

}

module.exports = OrderController