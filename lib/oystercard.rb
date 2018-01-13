require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'


class Oystercard
  attr_reader :balance, :current_journey, :journey_log

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    raise "There is a limit of #{CARD_LIMIT}" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(entry)
    raise "you dont have enough money" if insufficient_balance?
    deduct(@journey_log.history.last.fare) if @journey_log.current_journey != nil
    @journey_log.start(entry)
  end

  def touch_out(exit)
    @journey_log.start(nil) if @journey_log.current_journey == nil
    @journey_log.finish(exit)
    deduct(@journey_log.history.last.fare)
  end

  private

    def insufficient_balance?
      @balance < MINIMUM_FARE
    end

    def limit_exceeded?(amount)
      @balance + amount > CARD_LIMIT
    end

    def deduct(amount)
      @balance -= amount
    end

end
