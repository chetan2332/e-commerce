const UserModel = require("../models/user_model")
const bcrypt = require('bcrypt')

const UserController = {
    createAccount: async function (req, res) {
        try {
            const userData = req.body
            const newUser = new UserModel(userData)
            await newUser.save()

            return res.json({ success: true, data: newUser, message: "User Created" })
        } catch (ex) {
            return res.json({ success: false, message: ex, })
        }
    },

    signIn: async function (req, res) {
        try {
            const { email, password } = req.body
            const foundUser = await UserModel.findOne({ email })
            if (!foundUser) {
                return res.json({ success: false, message: "User not found", })
            }

            const passwordMatch = bcrypt.compareSync(password, foundUser.password)
            if (!passwordMatch) {
                return res.json({ success: false, message: "password not matched", })
            } else {
                return res.json({ success: true, data: foundUser })
            }

        } catch (ex) {
            return res.json({ success: false, message: ex, })
        }
    },

    updateUser: async function (req, res) {
        try {
            const userId = req.params.id;
            const updatedData = req.body;

            const updatedUser = await UserModel.findOneAndUpdate(
                { _id: userId },
                updatedData,
                { new: true }
            )

            if (!updatedUser) {
                throw "User not found"
            }

            return res.json({ success: true, data: updatedUser })
        } catch (ex) {
            return res.json({ success: false, message: ex })
        }
    }
}

module.exports = UserController