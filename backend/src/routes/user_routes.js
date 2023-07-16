const UserController = require('../controllers/user_controller');

const UserRoutes = require('express').Router()

UserRoutes.post('/createAccount', UserController.createAccount);
UserRoutes.post('/signIn', UserController.signIn);
UserRoutes.put('/:id', UserController.updateUser);

module.exports = UserRoutes