const mongoose = require('mongoose')

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
    const view = {
      id: this.id,
      owner: this.owner.view(full),
      name: this.name,
      address: this.address
    }

    return full ? {
      ...view
    } : view
  }
}

module.exports = Restaurants = mongoose.model('Restaurants', restaurantsSchema)
