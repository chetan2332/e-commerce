const express = require('express')
const helmet = require('helmet')
const morgan = require('morgan')
const cors = require('cors')
const mongoose = require('mongoose')
const UserRoutes = require('./routes/user_routes')
const CategoryRoutes = require('./routes/category_routes')
const ProductRoutes = require('./routes/product_routes')
const CartRoutes = require('./routes/cart_routes')
const OrderRoutes = require('./routes/order_routes')
const app = express()

// configurations
require('dotenv').config()
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(helmet())
app.use(morgan('dev'))
app.use(cors())

// Routes
app.use("/api/user", UserRoutes)
app.use("/api/category", CategoryRoutes)
app.use('/api/product', ProductRoutes)
app.use('/api/cart', CartRoutes)
app.use('/api/order', OrderRoutes)


// Initial Connections  
const URL = process.env.MONGO_DB
try {
    mongoose.connect(URL).catch((ex) => console.log(ex))
} catch (ex) {
    console.log(ex)
}

const PORT = process.env.PORT
app.listen(PORT, () => console.log(`Server started at PORT : ${PORT}`))
