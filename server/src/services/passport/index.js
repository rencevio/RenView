const passport = require('passport')
const {
  Schema
} = require('bodymen')
const {
  BasicStrategy
} = require('passport-http')
const {
  Strategy: BearerStrategy
} = require('passport-http-bearer')
const {
  Strategy: JwtStrategy,
  ExtractJwt
} = require('passport-jwt')
const {
  jwtSecret,
} = require('../../config')
const User = require('../../api/users/model')

exports.password = () => (req, res, next) =>
  passport.authenticate('password', {
    session: false
  }, (err, user, info) => {
    if (err && err.param) {
      return res.status(400).json(err)
    } else if (err || !user) {
      return res.status(401).end()
    }
    req.logIn(user, {
      session: false
    }, (err) => {
      if (err) return res.status(401).end()
      next()
    })
  })(req, res, next)

exports.token = ({
    required,
    roles = User.roles
  } = {}) => (req, res, next) =>
  passport.authenticate('token', {
    session: false
  }, (err, user, info) => {
    if (err || (required && !user) || (required && !~roles.indexOf(user.role))) {
      return res.status(401).end()
    }
    req.logIn(user, {
      session: false
    }, (err) => {
      if (err) return res.status(401).end()
      next()
    })
  })(req, res, next)

passport.use('password', new BasicStrategy((email, password, done) => {
  const userSchema = new Schema({
    email: User.schema.tree.email,
    password: User.schema.tree.password
  })

  userSchema.validate({
    email,
    password
  }, (err) => {
    if (err) done(err)
  })

  User.findOne({
    email
  }).then((user) => {
    if (!user) {
      done(true)
      return null
    }
    return user.authenticate(password, user.password).then((user) => {
      done(null, user)
      return null
    }).catch(done)
  })
}))

passport.use('token', new JwtStrategy({
  secretOrKey: jwtSecret,
  jwtFromRequest: ExtractJwt.fromExtractors([
    ExtractJwt.fromUrlQueryParameter('access_token'),
    ExtractJwt.fromBodyField('access_token'),
    ExtractJwt.fromAuthHeaderWithScheme('Bearer')
  ])
}, ({
  id
}, done) => {
  User.findById(id).then((user) => {
    done(null, user)
    return null
  }).catch(done)
}))
