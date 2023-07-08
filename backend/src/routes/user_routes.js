const UserController = require('../controllers/user_controller');

const UserRoutes = require('express').Router()

UserRoutes.post('/createAccount', UserController.createAccount);
UserRoutes.post('/signIn', UserController.signIn);

module.exports = UserRoutes