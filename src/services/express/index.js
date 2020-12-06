const express = require('express')
const compression = require('compression')
const morgan = require('morgan')
const bodyParser = require('body-parser')
const {
  errorHandler: queryErrorHandler
} = require('querymen')
const {
  errorHandler: bodyErrorHandler
} = require('bodymen')
const {
  env
} = require('../../config')

module.exports = (routes) => {
  const app = express()

  /* istanbul ignore next */
  if (env === 'production' || env === 'development') {
    app.use(compression())
    app.use(morgan('dev'))
  }

  app.use(bodyParser.urlencoded({
    extended: false
  }))
  app.use(bodyParser.json())
  app.use(routes)
  app.use(queryErrorHandler())
  app.use(bodyErrorHandler())

  return app
}
