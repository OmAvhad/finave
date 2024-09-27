const express = require('express')
const dotenv = require('dotenv')
dotenv.config()
const cors = require('cors')
const db = require('./db/db')
const userRoutes = require('./routes/userRoutes')
const transactionRoutes = require('./routes/transactionRoutes')

const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`App listening on port ${port}`)
})

app.use(express.json())

app.use(cors())

app.use('/user', userRoutes)
app.use('/transaction', transactionRoutes)

module.exports = app