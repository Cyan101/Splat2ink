def get_store(splatnet2_cookie)
  resp = RestClient.get(
    BASE_URL + '/api/onlineshop/merchandises',
    cookies: { iksm_session: splatnet2_cookie }
  )

  store = JSON.parse(resp.body)

  edited_store = Array.new(6) do |x|
    data = store['merchandises'][x]
    { name: data['gear']['name'],
      stars: data['gear']['rarity'] + 1,
      price: data['price'],
      image: data['gear']['image'],
      thumbnail: data['gear']['thumbnail'],
      time_end: data['end_time'],
      skill: { name: data['skill']['name'], image: data['skill']['image'] },
      brand: { name: data['gear']['brand']['name'], image: data['gear']['brand']['image'] } }
  end

  edited_store.each do |x|
    4.times do
      image_save(x[:image])
      image_save(x[:thumbnail])
      image_save(x[:skill][:image])
      image_save(x[:brand][:image])
    end
  end

  return {store: edited_store}
end
