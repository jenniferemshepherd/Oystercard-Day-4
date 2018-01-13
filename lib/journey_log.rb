require_relative 'journey.rb'

class JourneyLog

  attr_reader :current_journey, :history

  def initialize
    @journey_class = Journey
    @history = []
  end

  def start(station)
    create_journey(station)
    @current_journey.set_entry(station)
  end

  def finish(station)
    @current_journey.set_exit(station)
    log(@current_journey)
  end

  private

    def create_journey(station)
      @current_journey = @journey_class.new(station)
    end

    def log(current_journey)
      @history << current_journey
      clear_journey
    end

    def clear_journey
      @current_journey = nil
    end

    # def current_journey
    #   @current_journey if @current_journey != nil
    #   @current_journey = @journey_class.new
    # end


    # def check_touch_in
    #   if @current_journey != nil
    #     finish(station)
    #     # deduct(@journey_log.history.last.fare)
    #   end



end
