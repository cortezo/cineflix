require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe '#recent_videos' do
    it 'returns an array of all videos if less than 6 are present' do
      cat = Category.create(name: "Action")
      video_1 = Video.create(title: "Predator", description: "Aliens in the jungle!", category: cat)
      video_2 = Video.create(title: "Terminator", description: "Future robots!", category: cat)
      video_3 = Video.create(title: "Predator 2", description: "Aliens in the jungle again!", category: cat)
      video_4 = Video.create(title: "Terminator 2", description: "Future robots again!", category: cat)

      expect(cat.recent_videos.count).to eq(4)
    end

    it 'orders videos by newest first' do
      cat = Category.create(name: "Action")
      video_1 = Video.create(title: "Predator", description: "Aliens in the jungle!", created_at: 4.day.ago, category: cat)
      video_2 = Video.create(title: "Terminator", description: "Future robots!", created_at: 3.day.ago, created_at: 4.day.ago, category: cat)
      video_3 = Video.create(title: "Predator 2", description: "Aliens in the jungle again!", created_at: 2.day.ago, category: cat)
      video_4 = Video.create(title: "Terminator 2", description: "Future robots again!", created_at: 1.day.ago, category: cat)

      expect(cat.recent_videos).to eq([video_4, video_3, video_2, video_1])
    end

    it 'only returns 6 videos if there are more than 6 videos' do
      cat = Category.create(name: "Action")
      video_titles = %w{Predator Stealth Z Zombieland Ghostbusters Cliffhanger Bloodsport Taken ID4}
      video_titles.each do |title|
        Video.create(title: title, description: "A rambunctious action movie!", category: cat)
      end

      expect(cat.recent_videos.size).to eq(6)
    end

    it 'returns an empty array if there are no videos' do
      cat = Category.create(name: "Action")

      expect(cat.recent_videos).to eq([])
    end
  end
end
