const {
  sign
} = require('../../services/jwt')
const {
  success
} = require('../../services/response/')

exports.login = ({
    user
  }, res, next) =>
  sign(user.id)
  .then((token) => ({
    token,
    user: user.view(true)
  }))
  .then(success(res, 201))
  .catch(next)
