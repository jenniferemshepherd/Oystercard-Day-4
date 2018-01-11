
require_relative 'station.rb'
require_relative 'journey.rb'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @journey_history = []
    @journey = journey_class
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
    @journey = Journey.new
    raise "you have already touched in" if @journey.active?
    @journey.set_entry(station)
    @entry_station = station
  end

  def touch_out(station)
    @journey = Journey.new if @journey == nil
    # @journey.set_entry(nil) if @journey.entry != nil
    raise "you are not touched in" unless @journey.active?
    deduct(MINIMUM_FARE)
    @exit_station = station
    add_journey_to_history
  end

  def add_journey_to_history
    @journey_history << @journey.combine
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
