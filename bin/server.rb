require 'sinatra'
require 'haml'
require 'rufus-scheduler'
require 'json'
require_relative('splat2_data/grab_splat2_data.rb')

abort('Config file missing!?! Please run bin/key_gen.rb') unless File.exists?(Dir.pwd + '/config.yaml')
Config = YAML.load(File.read(Dir.pwd + '/config.yaml'))

set :bind, Config[:ip]
set :port, Config[:port]
set :views, 'views'
set :environment, :development # Change this to :production when ready

# Update our data every hour
scheduler = Rufus::Scheduler.new
scheduler.every '1h' do
  splat2_data = update_splat2_data(Config[:splatnet2_cookie])
end

# Update our data for our first start-up
splat2_data = update_splat2_data(Config[:splatnet2_cookie])

get '/' do
  # Frontend
  splat2_data.to_json
end

get '/api/schedules/?' do
  # output $splat2_data[:schedules]
  ''
end

get '/api/salmon_run/?' do
  # output $splat2_data[:salmon_run]
  ''
end

get '/api/store/?' do
  # output $splat2_data[:store]
  ''
end