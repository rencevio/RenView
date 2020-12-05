const {
  success,
  notFound,
  authorOrAdmin
} = require('../../services/response/')
const Restaurants = require('./model')
const {
  clean
} = require('../../services/utils')

exports.create = ({
  user,
  bodymen: {
    body
  }
}, res, next) => {
  if (user.role !== 'owner') {
    return res.status(401).json({
      valid: false,
      message: 'Only owners can create restaurants'
    })
  }

  Restaurants.create({
      ...body,
      owner: user
    })
    .then((restaurants) => restaurants.view(true))
    .then(success(res, 201))
    .catch(next)
}

exports.index = ({
    querymen: {
      query,
      select,
      cursor
    }
  }, res, next) =>
  Restaurants.find(query, select, cursor)
  .populate('owner')
  .then((restaurants) => restaurants.map((restaurants) => restaurants.view()))
  .then(success(res))
  .catch(next)

exports.show = ({
    params
  }, res, next) =>
  Restaurants.findById(params.id)
  .populate('owner')
  .then(notFound(res))
  .then((restaurants) => restaurants ? restaurants.view() : null)
  .then(success(res))
  .catch(next)

exports.update = ({
    user,
    bodymen: {
      body
    },
    params
  }, res, next) =>
  Restaurants.findById(params.id)
  .populate('owner')
  .then(notFound(res))
  .then(authorOrAdmin(res, user, 'owner'))
  .then((restaurants) => restaurants ? Object.assign(restaurants, clean(body)).save() : null)
  .then((restaurants) => restaurants ? restaurants.view(true) : null)
  .then(success(res))
  .catch(next)

exports.destroy = ({
    user,
    params
  }, res, next) =>
  Restaurants.findById(params.id)
  .then(notFound(res))
  .then(authorOrAdmin(res, user, 'owner'))
  .then((restaurants) => restaurants ? restaurants.remove() : null)
  .then(success(res, 204))
  .catch(next)
