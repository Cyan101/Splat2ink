require 'rest-client'
require 'yaml'
require 'json'
require 'open-uri'
require_relative('schedules.rb')
# TODO: - Splatnet2 Gear (/api/onlineshop/merchandises)
# TODO - Salmon Run (/api/timeline)

BASE_URL = 'https://app.splatoon2.nintendo.net'.freeze

# Check if cookie works and we can access Splat2
def cookie_check(splatnet2_cookie)
  resp = RestClient.get(
    BASE_URL,
    cookies: { iksm_session: splatnet2_cookie }
  )
rescue RestClient::ExceptionWithResponse => e
  puts 'Error - ' + e.response
  abort('Please read the above error and try deleting config.yaml then run key_gen.rb again')
end

def update_splat2_data(splatnet2_cookie)
  cookie_check(splatnet2_cookie)
  splat2_data = {} # Empty Hash that will be filled by the functions

  splat2_data[:schedules] = get_schedules(splatnet2_cookie)

  # Grab info from splatoon2
  splat2_data
end
