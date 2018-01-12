
require_relative 'station.rb'
require_relative 'journey.rb'

class Oystercard
  attr_reader :balance, :journey_history, :current_journey

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey.new)
    @balance = 0
    @journey_history = []
    @journey = journey_class
    @current_journey
  end

  # def active?
  #   !!entry_station
  # end

  def top_up(amount)
    raise "There is a limit of #{CARD_LIMIT}" if amount > CARD_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "you dont have enough money" if @balance < MINIMUM_FARE
    if @current_journey != nil
      add_journey_to_history
      deduct(MINIMUM_FARE)
    end
    @current_journey = @journey
    @current_journey.set_entry(station)
  end

  def touch_out(station)
    @current_journey = @journey if @current_journey == nil
    @current_journey.set_exit(station)
    @balance -= @journey.fare
    add_journey_to_history
  end

  def add_journey_to_history
    @journey_history << @current_journey.combine
    @current_journey = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
