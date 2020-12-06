const request = require('supertest')
const {
  signSync
} = require('../../services/jwt')
const express = require('../../services/express')
const User = require('../users/model')
const routes = require('.')
const Review = require('./model')
const Restaurant = require('../restaurants/model')

const app = () => express(routes)

let userSession, anotherSession, reviews, restaurant

beforeEach(async () => {
  const user = await User.create({
    email: 'a@a.com',
    name: 'test',
    password: '123456'
  })
  const anotherUser = await User.create({
    email: 'b@b.com',
    name: 'test1',
    password: '123456'
  })
  const owner = await User.create({
    email: 'c@c.com',
    name: 'test2',
    password: '123456',
    role: 'owner'
  })
  restaurant = await Restaurant.create({
    owner: owner,
    name: 'resta',
    address: 'resta'
  })
  userSession = signSync(user.id)
  anotherSession = signSync(anotherUser.id)
  reviews = await Review.create({
    user,
    rating: 3,
    restaurant: restaurant
  })
})

test('POST /reviews 201 (user)', async () => {
  const {
    status,
    body
  } = await request(app())
    .post('')
    .send({
      access_token: userSession,
      restaurant: restaurant.id,
      rating: 1,
      comment: 'test'
    })
  expect(status).toBe(201)
  expect(typeof body).toEqual('object')
  expect(body.restaurant).toEqual(restaurant.id)
  expect(body.rating).toEqual(1)
  expect(body.comment).toEqual('test')
  expect(typeof body.user).toEqual('object')
})

test('POST /reviews 401', async () => {
  const {
    status
  } = await request(app())
    .post('')
  expect(status).toBe(401)
})

test('GET /reviews 200', async () => {
  const {
    status,
    body
  } = await request(app())
    .get('')
  expect(status).toBe(200)
  expect(Array.isArray(body)).toBe(true)
})

test('GET /reviews/:id 200', async () => {
  const {
    status,
    body
  } = await request(app())
    .get(`/${reviews.id}`)
  expect(status).toBe(200)
  expect(typeof body).toEqual('object')
  expect(body.id).toEqual(reviews.id)
})

test('GET /reviews/:id 404', async () => {
  const {
    status
  } = await request(app())
    .get('/123456789098765432123456')
  expect(status).toBe(404)
})

test('PUT /reviews/:id 200 (user)', async () => {
  const {
    status,
    body
  } = await request(app())
    .put(`/${reviews.id}`)
    .send({
      access_token: userSession,
      restaurant: restaurant,
      rating: 1,
      comment: 'test'
    })
  expect(status).toBe(200)
  expect(typeof body).toEqual('object')
  expect(body.id).toEqual(reviews.id)
  expect(body.restaurant).toEqual(restaurant.id)
  expect(body.rating).toEqual(1)
  expect(body.comment).toEqual('test')
  expect(typeof body.user).toEqual('object')
})

test('PUT /reviews/:id 401 (user) - another user', async () => {
  const {
    status
  } = await request(app())
    .put(`/${reviews.id}`)
    .send({
      access_token: anotherSession,
      restaurant: restaurant,
      rating: 1,
      comment: 'test'
    })
  expect(status).toBe(401)
})

test('PUT /reviews/:id 401', async () => {
  const {
    status
  } = await request(app())
    .put(`/${reviews.id}`)
  expect(status).toBe(401)
})

test('PUT /reviews/:id 404 (user)', async () => {
  const {
    status
  } = await request(app())
    .put('/123456789098765432123456')
    .send({
      access_token: anotherSession,
      restaurant: restaurant,
      rating: 1,
      comment: 'test'
    })
  expect(status).toBe(404)
})

test('DELETE /reviews/:id 204 (user)', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${reviews.id}`)
    .query({
      access_token: userSession
    })
  expect(status).toBe(204)
})

test('DELETE /reviews/:id 401 (user) - another user', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${reviews.id}`)
    .send({
      access_token: anotherSession
    })
  expect(status).toBe(401)
})

test('DELETE /reviews/:id 401', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${reviews.id}`)
  expect(status).toBe(401)
})

test('DELETE /reviews/:id 404 (user)', async () => {
  const {
    status
  } = await request(app())
    .delete('/123456789098765432123456')
    .query({
      access_token: anotherSession
    })
  expect(status).toBe(404)
})
