require 'spec_helper'

describe Video do
  it "saves itself" do
    # Typically 3 phases.  1, setup the data.  2, perform an action.  3, verify the result.

    # Setup data
    video = Video.new(title: "Adventures in Rails", description: "A movie about cross-country travel.", large_cover_url: "large_cover.jpg", small_cover_url: "small_cover.jpg")

    # Perform action
    video.save

    # Verify result
    expect(Video.first).to eq(video)

    # Alternate syntax for verifying result:
    # Video.first.should eq(video)
    # Video.first.should == video
  end

  it "belongs to category" do
    adventure = Category.create(name: "Adventure")
    terminator = Video.create(title: "Terminator", description: "Robot from the future!", large_cover_url: "terminator_large.jpg", small_cover_url: "terminator_small.jpg", category: adventure)

    expect(terminator.category).to eq(adventure)
  end

  it "does not save a video without a description" do
    video = Video.create(title: "Terminator")
    expect(Video.count).to eq(0)
  end

  it "does not save a video without a title" do
    video = Video.create(description: "Robot from the future!")
    expect(Video.count).to eq(0)
  end
end