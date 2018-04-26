# Get schedules for regular, ranked and league mode
def get_schedules(splatnet2_cookie)
  resp = RestClient.get(
    BASE_URL + '/api/schedules',
    cookies: { iksm_session: splatnet2_cookie }
  )

  schedules = JSON.parse(resp.body)

  edited_schedules = {
    regular: [],
    gachi: [], # This is deleted and renamed to :ranked
    league: []
  }

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
      edited_schedules[x.to_sym][i] = to_save
      %i[stage_1 stage_2].each do |p| # Save the images for the maps locally
        image_save(to_save[p][:image])
      end
    end
  end

  edited_schedules[:ranked] = edited_schedules.delete(:gachi) # Rename :gachi to :ranked
  return edited_schedules
end
