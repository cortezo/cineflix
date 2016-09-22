Fabricator(:review) do
  rating { 5 }
  body { Faker::Lorem.sentence(2) }
end