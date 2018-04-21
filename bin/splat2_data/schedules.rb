# Get schedules

resp = RestClient.get(
  BASE_URL + '/api/schedules',
  cookies: { iksm_session: @splatnet2_token }
)

schedules = JSON.parse(resp.body)

# Save 4 "waves" of each mode
%w[regular gachi league].each do |x|
  4.times do |i|
    to_save = {}
    data = schedules[x][i]
    to_save[:game_type] = data['rule']['name']
    to_save[:stage_1] = data['stage_a']
    to_save[:stage_2] = data['stage_b']
    to_save[:time_start] = data['start_time']
    to_save[:time_end] = data['end_time']
    $splat2_data[:schedules][x.to_sym][i] = to_save
  end
end

$splat2_data[:schedules][:ranked] = $splat2_data[:schedules].delete(:gachi) # Rename :gachi to :ranked
