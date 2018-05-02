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
#scheduler = Rufus::Scheduler.new
#scheduler.every '1m' do
#  splat2_data = update_splat2_data(Config[:splatnet2_cookie])
#end

Thread.new do
  begin
    scheduler = Rufus::Scheduler.new
    scheduler.cron '59 * * * *' do
      $splat2_data = update_splat2_data(Config[:splatnet2_cookie])
    end
  rescue StandardError => e
    $stderr << e.message
    $stderr << e.backtrace.join("\n")
  end
end


# Update our data for our first start-up
$splat2_data = update_splat2_data(Config[:splatnet2_cookie])

get '/' do
  # Frontend
  'WIP'
end

get '/api/schedules/?' do
  $splat2_data[:schedules].to_json
end

get '/api/salmon_run/?' do
  $splat2_data[:salmon_run].to_json
end

get '/api/store/?' do
  $splat2_data[:store].to_json
end

get '/images/*/:file' do
  send_file("./public/images/#{params['splat'].first}/" + params[:file])
end
