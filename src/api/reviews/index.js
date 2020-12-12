const {
  Router
} = require('express')
const {
  middleware: query
} = require('querymen')
const {
  middleware: body
} = require('bodymen')
const {
  token
} = require('../../services/passport')
const {
  create,
  createReply,
  index,
  indexPending,
  show,
  update,
  destroy
} = require('./controller')
const {
  schema
} = require('./model')
const mongoose = require('mongoose')

const router = new Router()
const {
  restaurant,
  rating,
  comment,
  reply,
  visitDate
} = schema.tree

/**
 * @api {post} /reviews Create reviews
 * @apiName CreateReviews
 * @apiGroup Reviews
 * @apiPermission user
 * @apiParam {String} access_token user access token.
 * @apiParam restaurant Reviews's restaurant.
 * @apiParam rating Reviews's rating.
 * @apiParam comment Reviews's comment.
 * @apiParam visitDate Date of visit.
 * @apiSuccess {Object} reviews Reviews's data.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 * @apiError 404 Reviews not found.
 * @apiError 401 user access only.
 */
router.post('/',
  token({
    required: true
  }),
  body({
    restaurant,
    rating,
    comment,
    visitDate
  }),
  create)

/**
 * @api {post} /reviews/:id/reply Create reply
 * @apiName CreateReply
 * @apiGroup Reviews
 * @apiPermission owner
 * @apiParam {String} access_token user access token.
 * @apiParam restaurant Reviews's restaurant.
 * @apiParam rating Reviews's rating.
 * @apiParam comment Reviews's comment.
 * @apiParam reply Reviews's reply.
 * @apiSuccess {Object} reviews Reviews's data.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 * @apiError 404 Reviews not found.
 * @apiError 401 user access only.
 */
router.post('/:id/reply',
  token({
    required: true
  }),
  body({
    reply: {
      ...reply,
      required: true
    }
  }),
  createReply)

/**
 * @api {get} /reviews Retrieve reviews
 * @apiName RetrieveReviews
 * @apiGroup Reviews
 * @apiUse listParams
 * @apiSuccess {Object[]} reviews List of reviews.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 */
router.get('/',
  query({
    restaurant: {
      type: mongoose.Schema.ObjectId,
      paths: ['restaurant'],
      operator: '$eq'
    }
  }),
  index)

/**
 * @api {get} /reviews Retrieve pending reviews
 * @apiName RetrievePendingReviews
 * @apiGroup Reviews
 * @apiPermission owner
 * @apiUse listParams
 * @apiSuccess {Object[]} reviews List of pending reviews.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 */
router.get('/pending',
  token({
    required: true
  }),
  indexPending)

/**
 * @api {get} /reviews/:id Retrieve reviews
 * @apiName RetrieveReviews
 * @apiGroup Reviews
 * @apiSuccess {Object} reviews Reviews's data.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 * @apiError 404 Reviews not found.
 */
router.get('/:id',
  show)

/**
 * @api {put} /reviews/:id Update reviews
 * @apiName UpdateReviews
 * @apiGroup Reviews
 * @apiPermission user
 * @apiParam {String} access_token user access token.
 * @apiParam rating Reviews's rating.
 * @apiParam comment Reviews's comment.
 * @apiSuccess {Object} reviews Reviews's data.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 * @apiError 404 Reviews not found.
 * @apiError 401 user access only.
 */
router.put('/:id',
  token({
    required: true
  }),
  body({
    rating: {
      ...rating,
      required: false
    },
    comment: {
      ...comment,
      required: false
    },
    visitDate: {
      ...visitDate,
      required: false
    },
  }),
  update)

/**
 * @api {delete} /reviews/:id Delete reviews
 * @apiName DeleteReviews
 * @apiGroup Reviews
 * @apiPermission user
 * @apiParam {String} access_token user access token.
 * @apiSuccess (Success 204) 204 No Content.
 * @apiError 404 Reviews not found.
 * @apiError 401 user access only.
 */
router.delete('/:id',
  token({
    required: true
  }),
  destroy)

module.exports = router
