require 'journey_log'

describe JourneyLog do

  subject(:log) { described_class.new }
  let(:station) { double :station }
  let(:journey) { double :journey }

  describe 'starts journey' do
    it 'creates a new journey' do
      log.start_journey(station)
      expect(log.current_journey).not_to be nil
    end

    it 'receives set_entry' do
      log.start_journey(station)
      expect(log.current_journey).to respond_to(:set_entry).with(1).argument
    end
  end

  describe 'ends journey' do
    it 'ends the journey' do
      log.start_journey(station)
      log.end_journey(station)
      expect(log.current_journey).to be nil
    end

    it 'stores journey' do
      log.start_journey(station)
      log.end_journey(station)
      expect(log.history).not_to be_empty
    end

    # it 'receives set_exit' do
    #   log.start_journey(station)
    #   log.end_journey(station)
    #   expect(log.current_journey).to respond_to(:set_exit).with(1).argument
    # end
  end


end



# describe 'journey_log' do
  # have an array (state)
# end


# describe 'ends journey' do
  # end journey
    # set exit (via journey)
    # store journey
#end

#  describe 'store journey' do
#   put journey into array
# end
