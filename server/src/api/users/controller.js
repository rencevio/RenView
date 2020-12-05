const {
  success,
  notFound
} = require('../../services/response')
const User = require('./model')
const {
  clean
} = require('../../services/utils')

exports.index = ({
    querymen: {
      query,
      select,
      cursor
    }
  }, res, next) =>
  User.find(query, select, cursor)
  .then((users) => users.map((user) => user.view()))
  .then(success(res))
  .catch(next)

exports.show = ({
    params
  }, res, next) =>
  User.findById(params.id)
  .then(notFound(res))
  .then((user) => user ? user.view() : null)
  .then(success(res))
  .catch(next)

exports.showMe = ({
    user
  }, res) =>
  res.json(user.view(true))

exports.create = ({
  bodymen: {
    body
  },
  params,
  user
}, res, next) => {
  const isAdmin = !user ? false : user.role === 'admin'

  if (!isAdmin && body.role == 'admin') {
    return res.status(401).json({
      valid: false,
      message: 'Only admin role can create other admin users'
    })
  }

  User.create(body)
    .then((user) => user.view(true))
    .then(success(res, 201))
    .catch((err) => {
      /* istanbul ignore else */
      if (err.name === 'MongoError' && err.code === 11000) {
        res.status(409).json({
          valid: false,
          param: 'email',
          message: 'email already registered'
        })
      } else {
        next(err)
      }
    })
}

exports.update = ({
    bodymen: {
      body
    },
    params,
    user
  }, res, next) =>
  User.findById(params.id === 'me' ? user.id : params.id)
  .then(notFound(res))
  .then((result) => {
    if (!result) return null
    const isAdmin = user.role === 'admin'
    const isSelfUpdate = user.id === result.id
    if (!isSelfUpdate && !isAdmin) {
      res.status(401).json({
        valid: false,
        message: 'You can\'t change other user\'s data'
      })
      return null
    }

    return result
  })
  .then((user) => user ? Object.assign(user, clean(body)).save() : null)
  .then((user) => user ? user.view(true) : null)
  .then(success(res))
  .catch(next)

exports.updatePassword = ({
    bodymen: {
      body
    },
    params,
    user
  }, res, next) =>
  User.findById(params.id === 'me' ? user.id : params.id)
  .then(notFound(res))
  .then((result) => {
    if (!result) return null
    const isSelfUpdate = user.id === result.id
    if (!isSelfUpdate) {
      res.status(401).json({
        valid: false,
        param: 'password',
        message: 'You can\'t change other user\'s password'
      })
      return null
    }
    return result
  })
  .then((user) => user ? user.set({
    password: body.password
  }).save() : null)
  .then((user) => user ? user.view(true) : null)
  .then(success(res))
  .catch(next)

exports.destroy = ({
    params
  }, res, next) =>
  User.findById(params.id)
  .then(notFound(res))
  .then((user) => user ? user.remove() : null)
  .then(success(res, 204))
  .catch(next)
