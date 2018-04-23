require 'base64'
require 'rest-client'
require 'json'
require 'yaml'

# All steps are from https://github.com/ZekeSnider/NintendoSwitchRESTAPI#authentication-steps

# Step 0 - Creating the login URL
auth_state = Base64.urlsafe_encode64(SecureRandom.random_bytes(36))

auth_code_verifier = Base64.urlsafe_encode64(SecureRandom.random_bytes(32))
auth_cv_hash = Digest::SHA256.digest(auth_code_verifier.delete('='))
auth_code_challenge = Base64.urlsafe_encode64(auth_cv_hash)

resp = RestClient.get(
  'https://accounts.nintendo.com/connect/1.0.0/authorize',
  params: {
    state: auth_state,
    redirect_uri: 'npf71b963c1b7b6d119://auth',
    client_id: '71b963c1b7b6d119', # Stays the same
    scope: 'openid user user.birthday user.mii user.screenName',
    response_type: 'session_token_code',
    session_token_code_challenge: auth_code_challenge.delete('='),
    session_token_code_challenge_method: 'S256',
    theme: 'login_form'
  }
)

puts "url: #{resp.request.url}"
puts "~~~~~~~~~~~~~~~~~~~~~~~~"
puts 'Please right-click + copy link on the "use this account" button and paste in here:'
input_url = gets.chomp
session_token_code = /de=(.*)\&/.match(input_url)[1]

# Step 1 - Get a session token
resp = RestClient.post(
  'https://accounts.nintendo.com/connect/1.0.0/api/session_token',
  {
    client_id: '71b963c1b7b6d119', # Stays the same
    session_token_code_verifier: auth_code_verifier.delete('='),
    session_token_code: session_token_code
  },
  {
    content_type: 'application/x-www-form-urlencoded'
  }
)

session_token = JSON.parse(resp.body)["session_token"]

# Step 2 - Get id/service token
resp = RestClient.post(
  'https://accounts.nintendo.com/connect/1.0.0/api/token',
  {
    session_token: session_token,
    grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer-session-token',
    client_id: '71b963c1b7b6d119'
  },
  {
    host: 'accounts.nintendo.com',
    content_type: 'application/x-www-form-urlencoded',
    charset: 'utf-8',
    connection: 'keep-alive',
    user_agent: 'OnlineLounge/1.0.4 NASDKAPI iOS',
    accept: 'application/json',
    accept_language: 'en-US',
    accept_encoding: 'gzip, deflate'
  }
)

id_token = JSON.parse(resp.body)["id_token"]

# Step 3 - Login to account
puts "Please enter the accounts birthday in the format 'yyyy-mm-dd':"
na_birthday = gets.chomp

resp = RestClient.post(
  'https://elifessler.com/s2s/api/gen',
  {
    naIdToken: id_token
  },
  {
    content_type: 'application/x-www-form-urlencoded',
    user_agent: 'splat2ink/0.1'
  }
)

f = JSON.parse(resp.body)['f'] # HMAC code gen from https://github.com/frozenpandaman/splatnet2statink/wiki/api-docs

payload = { "parameter": { "language": "en-US", "naBirthday": na_birthday, "naCountry": "US", "naIdToken": id_token, "f": f } }

resp = RestClient.post(
  'https://api-lp1.znc.srv.nintendo.net/v1/Account/Login',
  payload.to_json,
  {
    host: 'api-lp1.znc.srv.nintendo.net',
    accept_language: 'en-US',
    user_agent: 'com.nintendo.znca/1.1.2 (Android/7.1.2)',
    accept: 'application/json',
    x_productversion: '1.1.2',
    content_type: 'application/json; charset=utf-8',
    connection: 'keep-alive',
    authorization: 'Bearer',
    content_length: '987',
    x_platform: 'Android',
    accept_encoding: 'gzip'
  }

)

webapi_creds = JSON.parse(resp.body)['result']['webApiServerCredential']['accessToken']

# Step 4 - Get web API access token
payload = { "parameter": { "id": "5741031244955648" } }

resp = RestClient.post(
  'https://api-lp1.znc.srv.nintendo.net/v1/Game/GetWebServiceToken',
  payload.to_json,
  {
    host: 'api-lp1.znc.srv.nintendo.net',
    accept_language: 'en-US',
    user_agent: 'com.nintendo.znca/1.1.2 (Android/7.1.2)',
    accept: 'application/json',
    x_productversion: '1.1.2',
    content_type: 'application/json; charset=utf-8',
    connection: 'keep-alive',
    authorization: 'Bearer ' + webapi_creds,
    content_length: '987',
    x_platform: 'Android',
    accept_encoding: 'gzip'
  }
)

web_token = JSON.parse(resp.body)['result']['accessToken']

# Step 5 - Create a Splat2 API Cookie
resp = RestClient.get(
  'https://app.splatoon2.nintendo.net/',
  {
    x_gamewebtoken: web_token,
    user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60'
  }
)

splat2_cookie = resp.cookies['iksm_session']

puts "Please edit config.yaml and modify the ip/port if you need"

config = { splatnet2_cookie: splatnet2_cookie, ip: 'localhost', port: 8080 }
File.open('../config.yaml', 'w') { |f| f.write(config.to_yaml) }
