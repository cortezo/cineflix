require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe '.search_by_title' do
    it 'returns an empty array if there is no match' do 
      expect(Video.search_by_title("blahlkajf;alkjef;al")).to eq([])
    end
    
    it 'returns an array of one Video for an exact match' do
      predator = Video.create(title: "Predator", description: "Aliens in the jungle!")
      expect(Video.search_by_title("Predator")).to eq([predator])
    end

    it 'returns an array of one Video for a partial match' do 
      ghostbusters = Video.create(title: "Ghost Busters", description: "There's something strange in your neighborhood.")
      expect(Video.search_by_title("sters")).to eq([ghostbusters])
    end

    it 'should return an array with all matched Videos ordered by created_at' do
      ghostbusters = Video.create(title: "Ghost Busters", description: "There's something strange in your neighborhood.", created_at: 2.day.ago)
      ghostbusters_2 = Video.create(title: "Ghost Busters 2", description: "There are more strange things in your neighborhood.", created_at: 1.day.ago)

      expect(Video.search_by_title("Busters")).to eq([ghostbusters, ghostbusters_2])
    end

    it 'should return an empty array when search is an empty string' do
      expect(Video.search_by_title("")).to eq([])
    end
  end
end

