require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'


class Oystercard
  attr_reader :balance, :current_journey, :journey_log

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    # (journey = Journey.new)
    @balance = 0
    # @journey_history = []
    # @journey = journey
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    raise "There is a limit of #{CARD_LIMIT}" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "you dont have enough money" if insufficient_balance?
    if @journey_log.current_journey != nil
      @journey_log.end_journey(station)
      deduct(@journey_log.history.last.fare)
    end
    @journey_log.start_journey(station)
  end

  def touch_out(station)
    @journey_log.start_journey(nil) if @journey_log.current_journey == nil
    @journey_log.end_journey(station)
    deduct(@journey_log.history.last.fare)
  end

  private

  # def add_journey_to_history
  #   @journey_history << @current_journey
  #   @current_journey = nil
  # end

  def insufficient_balance?
    @balance < MINIMUM_FARE
  end

  def limit_exceeded?(amount)
    amount > CARD_LIMIT
  end

  # def start_journey(station)
  #   @current_journey = @journey
  #   @current_journey.set_entry(station)
  # end

  def deduct(amount)
    @balance -= amount
  end

  # def complete_journey
  #   deduct(@journey.fare)
  #   add_journey_to_history
  # end

end
