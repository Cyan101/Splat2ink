# Get schedule for salmon run
def get_salmon_run(splatnet2_cookie)
  resp = RestClient.get(
    BASE_URL + '/api/coop_schedules',
    cookies: { iksm_session: splatnet2_cookie }
  )

  coop_schedules = JSON.parse(resp.body)

  salmon_run = {
    detailed: [{ stage: {}, weapons: [] }, { stage: {}, weapons: [] }],
    upcoming: [{}, {}, {}]
  }
  alt_weapons = Array.new(4) do |x|
    { 'name' => 'Unknown',
      'image' => '/images/bundled/46415ab807d382141c8b38a790de00f6.png',
      'thumbnail' => '/images/bundled/46415ab807d382141c8b38a790de00f6.png' }
    end
  2.times do |x|
    if (coop_schedules['details'][x]['weapons'].any?{ |e| e == nil })
    coop_schedules['details'][x].delete('weapons')
    coop_schedules['details'][x]['weapons'] = alt_weapons
    end
  end

  # Grab the detailed salmon run data from the response
  2.times do |x|
    data = coop_schedules['details'][x]
    salmon_run[:detailed][x][:time_start] = data['start_time']
    salmon_run[:detailed][x][:time_end] = data['end_time']
    salmon_run[:detailed][x][:stage][:name] = data['stage']['name']
    salmon_run[:detailed][x][:stage][:image] = data['stage']['image']
    image_save(data['stage']['image'])
    # Weapon Stuff
    4.times do |i|
      weapon_data = data['weapons'][i]
      edited_weapon_data = {}
      edited_weapon_data[:name] = weapon_data['name']
      edited_weapon_data[:image] = weapon_data['image']
      edited_weapon_data[:thumbnail] = weapon_data['thumbnail']
      image_save(weapon_data['image'])
      image_save(weapon_data['thumbnail'])
      salmon_run[:detailed][x][:weapons][i] = edited_weapon_data
    end
  end

  # Grab the times for the upcoming salmon runs
  3.times do |x|
    data = coop_schedules['schedules'][x]
    salmon_run[:upcoming][x][:time_start] = data['start_time']
    salmon_run[:upcoming][x][:time_end] = data['end_time']
  end

  return salmon_run
end
