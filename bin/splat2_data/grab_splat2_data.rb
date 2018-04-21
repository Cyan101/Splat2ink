require 'rest-client'
require 'yaml'
require 'json'

@splatnet2_token = YAML.load(File.read('../../config.yaml'))[:splatnet2_cookie]
BASE_URL = 'https://app.splatoon2.nintendo.net'

$splat2_data = {
  schedules: {
    regular: {},
    gachi: {}, # This is deleted and renamed to :ranked
    league: {}
  }
}

# Grab info from splatoon2
require_relative('schedules.rb')

puts $splat2_data.to_json
