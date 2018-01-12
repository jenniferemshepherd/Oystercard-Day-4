require_relative 'journey.rb'

class JourneyLog

  attr_reader :current_journey, :history

  def initialize
    @journey_class = Journey
    @history = []
    @current_journey
  end

  def start_journey(station)
    @current_journey = @journey_class.new
    @current_journey.set_entry(station)
  end

  def end_journey(station)
    @current_journey.set_exit(station)
    @history << @current_journey
    @current_journey = nil
  end


end
