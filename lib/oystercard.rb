require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'


class Oystercard
  attr_reader :balance, :journey_history, :current_journey

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journey_history = []
    @journey = journey
  end

  def top_up(amount)
    raise "There is a limit of #{CARD_LIMIT}" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "you dont have enough money" if insufficient_balance?
    complete_journey unless @current_journey == nil
    start_journey(station)
  end

  def touch_out(station)
    @current_journey = @journey if @current_journey == nil
    @current_journey.set_exit(station)
    complete_journey
  end

  private

  def add_journey_to_history
    @journey_history << @current_journey
    @current_journey = nil
  end

  def insufficient_balance?
    @balance < MINIMUM_FARE
  end

  def limit_exceeded?(amount)
    amount > CARD_LIMIT
  end

  def start_journey(station)
    @current_journey = @journey
    @current_journey.set_entry(station)
  end

  def deduct(amount)
    @balance -= amount
  end

  def complete_journey
    deduct(@journey.fare)
    add_journey_to_history
  end

end
