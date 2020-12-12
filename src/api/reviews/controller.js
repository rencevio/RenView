const {
  success,
  notFound,
  authorOrAdmin
} = require('../../services/response/')
const Reviews = require('./model')
const Restaurants = require('../restaurants/model')
const {
  clean
} = require('../../services/utils')

exports.create = ({
  user,
  bodymen: {
    body
  }
}, res, next) => {
  if (user.role !== 'user') {
    return res.status(401).json({
      valid: false,
      message: 'Only users can create reviews'
    })
  }

  Reviews.create({
      ...body,
      user
    })
    .then((reviews) => reviews.view(true))
    .then(success(res, 201))
    .catch(next)
}

exports.createReply = async ({
  user,
  bodymen: {
    body
  },
  params
}, res, next) => {
  if (user.role !== 'owner') {
    return res.status(401).json({
      valid: false,
      message: 'Only owners can create replies'
    })
  }

  let restaurant = await Restaurants.findOne({
    id: {
      $eq: params.restaurant
    }
  })

  if (restaurant == null || restaurant.owner != user.id) {
    return res.status(401).json({
      valid: false,
      message: 'Only owners of this restaurants can create replies'
    })
  }

  Reviews.findById(params.id)
    .then(notFound(res))
    .then((reviews) => reviews ? Object.assign(reviews, body).save() : null)
    .then((reviews) => reviews ? reviews.view(true) : null)
    .then(success(res))
    .catch(next)
}

exports.index = ({
    querymen: {
      query,
      select,
      cursor
    }
  }, res, next) =>
  Reviews.find(query, select, cursor)
  .populate('user')
  .then((reviews) => reviews.map((reviews) => reviews.view()))
  .then(success(res))
  .catch(next)

exports.indexPending = async ({
  user,
}, res, next) => {
  let ownedRestaurants = await Restaurants.find({
    owner: {
      $eq: user.id
    }
  })

  Reviews.find({
      restaurant: {
        $in: ownedRestaurants
      },
      reply: {
        $exists: false
      }
    })
    .populate('user')
    .then((reviews) => reviews.map((reviews) => reviews.view()))
    .then(success(res))
    .catch(next)
}

exports.show = ({
    params
  }, res, next) =>
  Reviews.findById(params.id)
  .populate('user')
  .then(notFound(res))
  .then((reviews) => reviews ? reviews.view() : null)
  .then(success(res))
  .catch(next)

exports.update = ({
    user,
    bodymen: {
      body
    },
    params
  }, res, next) =>
  Reviews.findById(params.id)
  .populate('user')
  .then(notFound(res))
  .then(authorOrAdmin(res, user, 'user'))
  .then((reviews) => reviews ? Object.assign(reviews, clean(body)).save() : null)
  .then((reviews) => reviews ? reviews.view(true) : null)
  .then(success(res))
  .catch(next)

exports.destroy = ({
    user,
    params
  }, res, next) =>
  Reviews.findById(params.id)
  .then(notFound(res))
  .then(authorOrAdmin(res, user, 'user'))
  .then((reviews) => reviews ? reviews.remove() : null)
  .then(success(res, 204))
  .catch(next)
