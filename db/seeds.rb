# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create seed categories to be used in seed videos
category_names = %w{Action Adventure Drama Comedy Documentary Anime}

category_names.each do |name|
	Category.create(name: name)
end

categories = Category.all

# Create seed videos with categories
description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dictum feugiat vestibulum. Aliquam suscipit 
quam eget dui scelerisque, viverra efficitur lorem hendrerit. Maecenas hendrerit mi sit amet nibh rutrum dapibus."

small_cover_urls = ["/tmp/family_guy.jpg", "/tmp/futurama.jpg", "/tmp/monk.jpg", "/tmp/south_park.jpg"]

["Family Guy", "Family Dude", "Family Bro", "Family Dwarf", "Family Elf", "Family Dark Elf", "Family Girl", "Family Babe", "Family Toddler"].each do |title|

  Video.create(title: title, description: description, small_cover_url: small_cover_urls.shuffle.first, large_cover_url: "/tmp/monk_large.jpg", category: categories.sample)
end

