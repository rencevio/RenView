const Restaurant = require('./model')
const User = require('../users/model')

let user, restaurants

beforeEach(async () => {
  user = await User.create({
    email: 'a@a.com',
    name: 'user',
    password: '123456'
  })
  restaurants = await Restaurant.create({
    owner: user,
    name: 'test',
    address: 'test'
  })
})

describe('view', () => {
  it('returns simple view', async () => {
    const view = await restaurants.view()
    expect(typeof view).toBe('object')
    expect(view.id).toBe(restaurants.id)
    expect(typeof view.owner).toBe('object')
    expect(view.owner.id).toBe(user.id)
    expect(view.name).toBe(restaurants.name)
    expect(view.address).toBe(restaurants.address)
  })

  it('returns full view', async () => {
    const view = await restaurants.view(true)
    expect(typeof view).toBe('object')
    expect(view.id).toBe(restaurants.id)
    expect(typeof view.owner).toBe('object')
    expect(view.owner.id).toBe(user.id)
    expect(view.name).toBe(restaurants.name)
    expect(view.address).toBe(restaurants.address)
  })
})
