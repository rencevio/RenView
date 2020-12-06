const Review = require('./model')
const User = require('../users/model')
const Restaurant = require('../restaurants/model')

let user, restaurant, reviews, owner

beforeEach(async () => {
  user = await User.create({
    email: 'a@a.com',
    name: 'test',
    password: '123456'
  })
  owner = await User.create({
    email: 'a1@a1.com',
    name: 'test1',
    password: '123456',
    role: 'owner'
  })
  restaurant = await Restaurant.create({
    owner: owner,
    name: 'resta',
    address: 'resta'
  })
  reviews = await Review.create({
    user,
    restaurant: restaurant,
    rating: 3,
    comment: 'test',
    reply: 'test'
  })
})

describe('view', () => {
  it('returns simple view', () => {
    const view = reviews.view()
    expect(typeof view).toBe('object')
    expect(view.id).toBe(reviews.id)
    expect(typeof view.user).toBe('object')
    expect(view.user.id).toBe(user.id)
    expect(view.restaurant).toBe(reviews.restaurant)
    expect(view.rating).toBe(reviews.rating)
    expect(view.comment).toBe(reviews.comment)
    expect(view.reply).toBe(reviews.reply)
    expect(view.createdAt).toBeTruthy()
    expect(view.updatedAt).toBeTruthy()
  })

  it('returns full view', () => {
    const view = reviews.view(true)
    expect(typeof view).toBe('object')
    expect(view.id).toBe(reviews.id)
    expect(typeof view.user).toBe('object')
    expect(view.user.id).toBe(user.id)
    expect(view.restaurant).toBe(reviews.restaurant)
    expect(view.rating).toBe(reviews.rating)
    expect(view.comment).toBe(reviews.comment)
    expect(view.reply).toBe(reviews.reply)
    expect(view.createdAt).toBeTruthy()
    expect(view.updatedAt).toBeTruthy()
  })
})
