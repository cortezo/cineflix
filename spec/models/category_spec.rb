require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "Adventure")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    adventure = Category.create(name: "Adventure")

    terminator = Video.create(title: "Terminator", description: "Robot from the future!", large_cover_url: "terminator_large.jpg", small_cover_url: "terminator_small.jpg", category: adventure)
    predator = Video.create(title: "Predator", description: "Jungle!", large_cover_url: "predator_large.jpg", small_cover_url: "predator_small.jpg", category: adventure)

    expect(adventure.videos).to eq([predator, terminator])
  end

  it "does not save a category without a name" do
    category = Category.create
    expect(Category.count).to eq(0)
  end
end