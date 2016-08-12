require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe '.search_by_title' do
    let(:ghostbusters) { Video.create(title: "Ghost Busters", description: "There's something strange in your neighborhood.") }

    it 'returns an empty array if there is no match' do 
      expect(Video.search_by_title("blahlkajf;alkjef;al")).to eq([])
    end
    
    it 'returns an array of one Video for an exact match' do
      expect(Video.search_by_title("Ghost Busters")).to eq([ghostbusters])
    end

    it 'returns an array of one Video for a partial match' do 
      expect(Video.search_by_title("sters")).to eq([ghostbusters])
    end

    it 'should return an array with all matched Videos ordered by created_at' do
      ghostbusters_2 = Video.create(title: "Ghost Busters 2", description: "There are more strange things in your neighborhood.", created_at: 1.day.ago)

      # ghostbusters_2 comes first because we're using "let" above.  If ghostbusters was evaluated in this block, it would come first in the array. 
      expect(Video.search_by_title("Busters")).to eq([ghostbusters_2, ghostbusters])
    end

    it 'should return an empty array when search is an empty string' do
      expect(Video.search_by_title("")).to eq([])
    end
  end
end

