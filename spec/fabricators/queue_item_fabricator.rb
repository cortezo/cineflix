Fabricator(:queue_item) do
  video { Fabricate(:video) }
  user { Fabricate(:user) }
  position { rand(100) }
end