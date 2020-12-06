const mongoose = require('mongoose')
const Review = require('../reviews/model')

const restaurantsSchema = new mongoose.Schema({
  owner: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    required: true
  },
  name: {
    type: String,
    required: true
  },
  address: {
    type: String,
    required: true
  }
}, {
  timestamps: true,
  toJSON: {
    virtuals: true,
    transform: (obj, ret) => {
      delete ret._id
    }
  }
})

restaurantsSchema.methods = {
  view(full) {
    return Review.find({
      restaurant: {
        $eq: this.id
      }
    }).then((reviews) => {
      const averageRating = reviews.map((r) => r.rating).reduce((r1, r2) => r1 + r2, 0) / reviews.length || 0

      const view = {
        id: this.id,
        owner: this.owner.view(full),
        name: this.name,
        address: this.address,
        averageRating: averageRating
      }

      return full ? {
        ...view
      } : view
    })
  }
}

module.exports = Restaurant = mongoose.model('Restaurants', restaurantsSchema)
