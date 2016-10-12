Fabricator(:video) do 
  title { "Predator" }
  description { Faker::Lorem.sentence }
  small_cover_url { '/tmp/south_park.jpg' }
  large_cover_url { '/tmp/monk_large.jpg' }
  category
end