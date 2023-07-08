const CartModel = require("../models/cart_model")

const CartController = {

    getCartForUser: async function (req, res) {
        try {
            const user = req.params.user
            const foundCart = await CartModel.findOne({ user })
            if (!foundCart) {
                return res.json({ success: true, data: [] })
            }
            return res.json({ success: true, data: foundCart })
        } catch (ex) {
            return res.json({ success: false, message: ex })
        }
    },

    addToCart: async function (req, res) {
        try {
            const { product, user, quantity } = req.body
            const foundCart = await CartModel.findOne({ user })
            if (!foundCart) {
                const newCart = new CartModel({ user })
                newCart.items.push({ product, quantity })
                await newCart.save()
                return res.json({ success: true, data: newCart, message: "Product added to cart" })
            }
            const newCart = await CartModel.findOneAndUpdate(
                { user },
                { $push: { items: { product, quantity } } },
                { new: true }
            )
            return res.json({ success: true, data: newCart, message: "Product added to cart" })
        } catch (ex) {
            return res.json({ success: true, message: ex })
        }
    },

    removeFromCart: async function (req, res) {
        try {
            const { product, user } = req.body
            const newCart = await CartModel.findOneAndUpdate(
                { user },
                { $pull: { items: { product } } },
                { new: true },
            )
            return res.json({ success: true, data: newCart, message: "Product added to cart" })
        } catch (ex) {
            return res.json({ success: true, message: ex })
        }
    },

}

module.exports = CartController