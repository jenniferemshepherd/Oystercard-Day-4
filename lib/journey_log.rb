require_relative 'journey.rb'

class JourneyLog

  attr_reader :current_journey, :history

  def initialize
    @journey_class = Journey
    @history = []
  end

  def start(entry)
    create_journey(entry)
  end

  def finish(exit)
    create_journey unless @current_journey
    close_journey(exit)
  end

  private

    def create_journey(entry = nil)
      @current_journey = @journey_class.new(entry)
    end

    def log(current_journey)
      @history << current_journey
    end

    def clear_journey
      @current_journey = nil
    end

    def close_journey(station = nil)
      @current_journey.set_exit(station)
      log(@current_journey)
      clear_journey
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
