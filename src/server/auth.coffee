passport = require 'passport'
GoogleStrategy = (require 'passport-google').Strategy

# userLookup = (identifier, profile, callback) ->
exports.setup = (baseUrl, app, findOrCreateUser, serializeUser, deserializeUser) ->
  googleConfig =
    returnURL: baseUrl+'auth/google/return'
    realm: baseUrl
  passport.use new GoogleStrategy googleConfig, (identifier, profile, done) ->
    findOrCreateUser identifier, profile, (err, user) ->
      done err, user

  passport.serializeUser serializeUser
  passport.deserializeUser deserializeUser

  app.use passport.initialize()
  app.use passport.session()

  # Redirect the user to Google for authentication.  When complete, Google
  # will redirect the user back to the application at
  # /auth/google/return
  app.get '/auth/google', passport.authenticate 'google'

  # Google will redirect the user to this URL after authentication.  Finish
  # the process by verifying the assertion.  If valid, the user will be
  # logged in.  Otherwise, authentication has failed.
  app.get '/auth/google/return', (passport.authenticate 'google'
    successRedirect: '/'
    failureRedirect: '/login'
  )

  return passport
