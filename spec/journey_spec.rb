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


  describe "#combine" do
    it "combines entry and exit" do
      journey.set_entry("Barking")
      journey.set_exit("Brixton")
      expect(journey.combine).to eql({:entry_station => "Barking", :exit_station => "Brixton"})
    end
  end

end
