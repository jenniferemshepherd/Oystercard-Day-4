require_relative 'oystercard.rb'

class Journey

  attr_reader :entry, :exit
  #
  # def initialize
  #
  # end

  def active?
    @entry != nil
  end

  def set_entry(station)
    @entry = station
  end

  def set_exit(station)
    @exit = station
  end

  def combine
    {entry_station: @entry, exit_station: @exit}
  end

  def fare
    Oystercard::MINIMUM_FARE
  end

end
