# Get schedules

resp = RestClient.get(
  BASE_URL + '/api/schedules',
  {
    cookies: { iksm_session: @splatnet2_token }
  }
)

schedules = JSON.parse(resp.body)

# Save 3 "waves" of Turf Wars

4.times do |i|
  to_save = {}
  data = schedules['regular'][i]
  to_save[:game_type] = data['rule']['name']
  to_save[:stage_1] = data['stage_a']
  to_save[:stage_2] = data['stage_b']
  to_save[:time_start] = data['start_time']
  to_save[:time_end] = data['end_time']
  $splat2_data[:schedules][:regular][i] = to_save
end
