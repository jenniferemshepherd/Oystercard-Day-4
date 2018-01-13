require 'journey_log'

describe JourneyLog do

  subject(:log) { described_class.new }
  let(:station) { double :station }
  let(:journey) { double :journey }

  describe 'starts journey' do
    it 'creates a new journey' do
      log.start(station)
      expect(log.current_journey).not_to be nil
    end
  end

  describe 'ends journey' do
    it 'ends the journey' do
      log.start(station)
      log.finish(station)
      expect(log.current_journey).to be nil
    end

    it 'stores journey' do
      log.start(station)
      log.finish(station)
      expect(log.history).not_to be_empty
    end

    # it 'receives set_exit' do
    #   log.start(station)
    #   log.finish(station)
    #   expect(log.current_journey).to respond_to(:set_exit).with(1).argument
    # end
  end


end



# describe 'journey_log' do
  # have an array (state)
# end

#  describe 'store journey' do
#   put journey into array
# end
