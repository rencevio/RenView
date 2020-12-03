const path = require('path')
const merge = require('lodash/merge')

/* istanbul ignore next */
const requireProcessEnv = (name) => {
  if (!process.env[name]) {
    throw new Error('You must set the ' + name + ' environment variable')
  }
  return process.env[name]
}

/* istanbul ignore next */
if (process.env.NODE_ENV !== 'production') {
  const dotenv = require('dotenv-safe')
  dotenv.config({
    path: path.join(__dirname, '../.env'),
  })
}

const config = {
  all: {
    env: process.env.NODE_ENV || 'development',
    port: process.env.PORT || 9090,
    ip: process.env.IP || '0.0.0.0',
    jwtSecret: requireProcessEnv('JWT_SECRET'),
    mongo: {
      options: {
        useUnifiedTopology: true,
        useNewUrlParser: true,
        useCreateIndex: true
      }
    }
  },
  test: {},
  development: {
    mongo: {
      uri: 'mongodb+srv://Max:TxAUopN2dz5O7YzH@default.qpa77.mongodb.net/RenView?retryWrites=true&w=majority',
      options: {
        debug: true
      }
    }
  },
  production: {
    ip: process.env.IP || undefined,
    port: process.env.PORT || 8080,
    mongo: {
      uri: process.env.MONGODB_URI || 'mongodb://localhost/ren-view'
    }
  }
}

module.exports = merge(config.all, config[config.all.env])
