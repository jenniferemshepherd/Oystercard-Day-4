require_relative 'journey.rb'

class JourneyLog

  attr_reader :current_journey, :history

  def initialize
    @journey_class = Journey
    @history = []
    @current_journey
  end

  def start(station)
    create_journey
    @current_journey.set_entry(station)
  end

  def finish(station)
    @current_journey.set_exit(station)
    log(@current_journey)
  end

  private

    def create_journey
      @current_journey = @journey_class.new
    end

    def log(current_journey)
      @history << current_journey
      @current_journey = nil
    end

end
