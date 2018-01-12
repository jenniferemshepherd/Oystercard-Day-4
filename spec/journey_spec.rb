require 'journey'

describe Journey do

  subject(:journey) {described_class.new}

  context '#active?' do
    it 'knows it is in a journey' do
      journey.set_entry("Barking")
      expect(journey).to be_active
    end
  end

  context "#set_entry" do
    it "starts journey on touch in" do
      journey.set_entry("Barking")
      expect(journey.entry).to eq "Barking"
    end
  end

  context "#set_exit" do
    it "finishes journey on touch out" do
      journey.set_exit("Brixton")
      expect(journey.exit).to eq "Brixton"
    end
  end

  context 'full journey' do
    before do
      journey.set_entry("Barking")
      journey.set_exit("Brixton")
    end

  end

  describe '#fare' do
    before do
      journey.set_entry("Barking")
      journey.set_exit("Brixton")
    end

    it 'returns the minimum fare' do
      expect(journey.fare).to eq Oystercard::MINIMUM_FARE
    end
  end

  describe 'penalty fare' do
    it 'returns penalty fare if no touch in' do
      journey.set_exit("Brixton")
      expect(journey.fare).to eq 6
    end

    it 'returns penalty fare if no touch out' do
      journey.set_entry("Barking")
      expect(journey.fare).to eq 6
    end
  end
end
