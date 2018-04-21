# Get schedules

resp = RestClient.get(
  BASE_URL + '/api/schedules',
  cookies: { iksm_session: @splatnet2_token }
)

schedules = JSON.parse(resp.body)

# Save 4 "waves" of each mode
%w[regular gachi league].each do |x|
  4.times do |i|
    to_save = { game_type: '', stage_1: {}, stage_2: {}, time_start: '', time_end: '' }
    data = schedules[x][i]
    to_save[:game_type] = data['rule']['name']
    %w[image name].each do |p|
      to_save[:stage_1][p.to_sym] = data['stage_a'][p]
      to_save[:stage_2][p.to_sym] = data['stage_b'][p]
    end
    to_save[:time_start] = data['start_time']
    to_save[:time_end] = data['end_time']
    $splat2_data[:schedules][x.to_sym][i] = to_save
    %i[stage_1 stage_2].each do |p| # Save the images for the maps locally
      image_url = to_save[p][:image]
      File.write '../../public/' + image_url, open(BASE_URL + image_url).read unless File.exist?('../../public/' + image_url)
    end
  end
end

$splat2_data[:schedules][:ranked] = $splat2_data[:schedules].delete(:gachi) # Rename :gachi to :ranked
