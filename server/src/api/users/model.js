const crypto = require('crypto')
const bcrypt = require('bcrypt')
const mongoose = require('mongoose')
const mongooseKeywords = require('mongoose-keywords')
const {
  env
} = require('../../config')

const roles = ['user', 'owner', 'admin']

const userSchema = new mongoose.Schema({
  email: {
    type: String,
    match: /^\S+@\S+\.\S+$/,
    required: true,
    unique: true,
    trim: true,
    lowercase: true
  },
  password: {
    type: String,
    required: true,
    minlength: 6
  },
  name: {
    type: String,
    index: true,
    required: true,
    trim: true
  },
  role: {
    type: String,
    enum: roles,
    default: 'user'
  },
  picture: {
    type: String,
    trim: true
  }
}, {
  timestamps: true
})

userSchema.path('email').set(function (email) {
  if (!this.picture || this.picture.indexOf('https://gravatar.com') === 0) {
    const hash = crypto.createHash('md5').update(email).digest('hex')
    this.picture = `https://gravatar.com/avatar/${hash}?d=identicon`
  }

  return email
})

userSchema.pre('save', function (next) {
  if (!this.isModified('password')) return next()

  /* istanbul ignore next */
  const rounds = env === 'test' ? 1 : 9

  bcrypt.hash(this.password, rounds).then((hash) => {
    this.password = hash
    next()
  }).catch(next)
})

userSchema.methods = {
  view(full) {
    const view = {}
    let fields = ['id', 'name', 'picture', 'role']

    if (full) {
      fields = [...fields, 'email']
    }

    fields.forEach((field) => {
      view[field] = this[field]
    })

    return view
  },

  authenticate(password) {
    return bcrypt.compare(password, this.password).then((valid) => valid ? this : false)
  }

}

userSchema.statics = {
  roles
}

userSchema.plugin(mongooseKeywords, {
  paths: ['email', 'name']
})

module.exports = User = mongoose.model('User', userSchema)
