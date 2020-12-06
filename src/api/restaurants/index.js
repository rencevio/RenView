const {
  Router
} = require("express")
const {
  middleware: query
} = require("querymen")
const {
  middleware: body
} = require("bodymen")
const {
  token
} = require("../../services/passport")
const {
  create,
  index,
  show,
  update,
  destroy
} = require("./controller")
const {
  schema
} = require("./model")
const mongoose = require('mongoose')


const router = new Router()
const {
  name,
  address
} = schema.tree

/**
 * @api {post} /restaurants Create restaurants
 * @apiName CreateRestaurants
 * @apiGroup Restaurants
 * @apiPermission user
 * @apiParam {String} access_token user access token.
 * @apiParam name Restaurants's name.
 * @apiParam address Restaurants's address.
 * @apiSuccess {Object} restaurants Restaurants's data.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 * @apiError 404 Restaurants not found.
 * @apiError 401 user access only.
 */
router.post('/',
  token({
    required: true
  }),
  body({
    name,
    address
  }),
  create)

/**
 * @api {get} /restaurants Retrieve restaurants
 * @apiName RetrieveRestaurants
 * @apiGroup Restaurants
 * @apiUse listParams
 * @apiSuccess {Object[]} restaurants List of restaurants.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 */
router.get('/',
  query({
    owner: {
      type: mongoose.Schema.ObjectId,
      paths: ['owner'],
      operator: '$eq'
    }
  }),
  index)

/**
 * @api {get} /restaurants/:id Retrieve restaurants
 * @apiName RetrieveRestaurants
 * @apiGroup Restaurants
 * @apiSuccess {Object} restaurants Restaurants's data.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 * @apiError 404 Restaurants not found.
 */
router.get('/:id',
  show)

/**
 * @api {put} /restaurants/:id Update restaurants
 * @apiName UpdateRestaurants
 * @apiGroup Restaurants
 * @apiPermission user
 * @apiParam {String} access_token user access token.
 * @apiParam name Restaurants's name.
 * @apiParam address Restaurants's address.
 * @apiSuccess {Object} restaurants Restaurants's data.
 * @apiError {Object} 400 Some parameters may contain invalid values.
 * @apiError 404 Restaurants not found.
 * @apiError 401 user access only.
 */
router.put('/:id',
  token({
    required: true
  }),
  body({
    name: {
      ...name,
      required: false
    },
    address: {
      ...name,
      required: false
    }
  }),
  update)

/**
 * @api {delete} /restaurants/:id Delete restaurants
 * @apiName DeleteRestaurants
 * @apiGroup Restaurants
 * @apiPermission user
 * @apiParam {String} access_token user access token.
 * @apiSuccess (Success 204) 204 No Content.
 * @apiError 404 Restaurants not found.
 * @apiError 401 user access only.
 */
router.delete('/:id',
  token({
    required: true
  }),
  destroy)

module.exports = router
