Accounts.onCreateUser (options, user)->

  if !user.profile
    user['profile'] = {}
#  user.profile['avatar'] = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large"
  requested = ['email', 'gender', 'first_name', 'last_name', 'locale']
#  requested.forEach (name)->
#    user.profile[name] = user.services.facebook[name]
  user.profile['registration'] = {}
  user.profile['tests'] = {}
  user.profile.registration['status'] = 'justRegistered'
  user.profile.registration['step'] = ''
  user.profile.registration['breakOne'] = true
  user.profile.registration['breakTwo'] = true
  user.profile.services = user.services
  user
