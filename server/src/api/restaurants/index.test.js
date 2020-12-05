const request = require('supertest')
const {
  signSync
} = require('../../services/jwt')
const express = require('../../services/express')
const User = require('../users/model')
const routes = require('.')
const Restaurant = require('./model')

const app = () => express(routes)

let userSession, anotherSession, restaurants

beforeEach(async () => {
  const user = await User.create({
    email: 'a@a.com',
    name: 'user',
    password: '123456'
  })
  const anotherUser = await User.create({
    email: 'b@b.com',
    name: 'another user',
    password: '123456'
  })
  userSession = signSync(user.id)
  anotherSession = signSync(anotherUser.id)
  restaurants = await Restaurants.create({
    owner: user,
    name: 'first',
    address: 'first'
  })
})

test('POST /restaurants 201 (user)', async () => {
  const {
    status,
    body
  } = await request(app())
    .post('')
    .send({
      access_token: userSession,
      name: 'test',
      address: 'test'
    })
  expect(status).toBe(201)
  expect(typeof body).toEqual('object')
  expect(body.name).toEqual('test')
  expect(body.address).toEqual('test')
  expect(typeof body.owner).toEqual('object')
})

test('POST /restaurants 401', async () => {
  const {
    status
  } = await request(app())
    .post('')
  expect(status).toBe(401)
})

test('GET /restaurants 200', async () => {
  const {
    status,
    body
  } = await request(app())
    .get('')
  expect(status).toBe(200)
  expect(Array.isArray(body)).toBe(true)
})

test('GET /restaurants/:id 200', async () => {
  const {
    status,
    body
  } = await request(app())
    .get(`/${restaurants.id}`)
  expect(status).toBe(200)
  expect(typeof body).toEqual('object')
  expect(body.id).toEqual(restaurants.id)
})

test('GET /restaurants/:id 404', async () => {
  const {
    status
  } = await request(app())
    .get('/123456789098765432123456')
  expect(status).toBe(404)
})

test('PUT /restaurants/:id 200 (user)', async () => {
  const {
    status,
    body
  } = await request(app())
    .put(`/${restaurants.id}`)
    .send({
      access_token: userSession,
      name: 'test',
      address: 'test'
    })
  expect(status).toBe(200)
  expect(typeof body).toEqual('object')
  expect(body.id).toEqual(restaurants.id)
  expect(body.name).toEqual('test')
  expect(body.address).toEqual('test')
  expect(typeof body.owner).toEqual('object')
})

test('PUT /restaurants/:id 401 (user) - another user', async () => {
  const {
    status
  } = await request(app())
    .put(`/${restaurants.id}`)
    .send({
      access_token: anotherSession,
      name: 'test',
      address: 'test'
    })
  expect(status).toBe(401)
})

test('PUT /restaurants/:id 401', async () => {
  const {
    status
  } = await request(app())
    .put(`/${restaurants.id}`)
  expect(status).toBe(401)
})

test('PUT /restaurants/:id 404 (user)', async () => {
  const {
    status
  } = await request(app())
    .put('/123456789098765432123456')
    .send({
      access_token: anotherSession,
      name: 'test',
      address: 'test'
    })
  expect(status).toBe(404)
})

test('DELETE /restaurants/:id 204 (user)', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${restaurants.id}`)
    .query({
      access_token: userSession
    })
  expect(status).toBe(204)
})

test('DELETE /restaurants/:id 401 (user) - another user', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${restaurants.id}`)
    .send({
      access_token: anotherSession
    })
  expect(status).toBe(401)
})

test('DELETE /restaurants/:id 401', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${restaurants.id}`)
  expect(status).toBe(401)
})

test('DELETE /restaurants/:id 404 (user)', async () => {
  const {
    status
  } = await request(app())
    .delete('/123456789098765432123456')
    .query({
      access_token: anotherSession
    })
  expect(status).toBe(404)
})
