const {
  env,
  mongo,
  port,
  ip,
} = require('./config')
const express = require('./services/express')
const mongoose = require('./services/mongoose')
const api = require('./api')

const app = express(api)

mongoose.connect(
  mongo.uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: false
  });

app.listen(port, ip, () => {
  console.log('Express server listening on http://%s:%d, in %s mode', ip, port, env);
})
