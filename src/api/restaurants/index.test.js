const request = require('supertest')
const {
  signSync
} = require('../../services/jwt')
const express = require('../../services/express')
const User = require('../users/model')
const routes = require('.')
const Restaurant = require('./model')

const app = () => express(routes)

let userSession, anotherSession, ownerSession, restaurants

beforeEach(async () => {
  const user = await User.create({
    email: 'a@a.com',
    name: 'user',
    password: '123456'
  })
  const owner = await User.create({
    email: 'c@c.com',
    name: 'owner',
    password: '123456',
    role: 'owner'
  })
  userSession = signSync(user.id)
  ownerSession = signSync(owner.id)
  restaurants = await Restaurant.create({
    owner: owner,
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
  expect(status).toBe(401)
})

test('POST /restaurants 201 (owner)', async () => {
  const {
    status,
    body
  } = await request(app())
    .post('')
    .send({
      access_token: ownerSession,
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

test('PUT /restaurants/:id 401 (user)', async () => {
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
  expect(status).toBe(401)
})

test('PUT /restaurants/:id 200 (owner)', async () => {
  const {
    status,
    body
  } = await request(app())
    .put(`/${restaurants.id}`)
    .send({
      access_token: ownerSession,
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

test('PUT /restaurants/:id 401', async () => {
  const {
    status
  } = await request(app())
    .put(`/${restaurants.id}`)
  expect(status).toBe(401)
})

test('DELETE /restaurants/:id 401 (user)', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${restaurants.id}`)
    .query({
      access_token: userSession
    })
  expect(status).toBe(401)
})

test('DELETE /restaurants/:id 204 (owner)', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${restaurants.id}`)
    .query({
      access_token: ownerSession
    })
  expect(status).toBe(204)
})

test('DELETE /restaurants/:id 401', async () => {
  const {
    status
  } = await request(app())
    .delete(`/${restaurants.id}`)
  expect(status).toBe(401)
})
