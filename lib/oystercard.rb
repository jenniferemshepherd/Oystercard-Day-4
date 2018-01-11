
require_relative 'station.rb'
require_relative 'journey.rb'

class Oystercard
  attr_reader :balance, :journey_history

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey)
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
    @current_journey = @journey.new
    @current_journey.set_entry(station)
  end

  def touch_out(station)
    @current_journey = @journey.new  if @current_journey == nil
    @current_journey.set_exit(station)
    deduct(MINIMUM_FARE)
    add_journey_to_history
  end

  def add_journey_to_history
    @journey_history << @current_journey.combine
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
