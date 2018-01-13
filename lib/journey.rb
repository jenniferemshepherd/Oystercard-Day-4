require_relative 'oystercard.rb'

class Journey

  attr_reader :entry, :exit

  def initialize(entry = nil)
    @entry = entry
  end

  def active?
    @entry != nil
  end

  def set_exit(station)
    @exit = station
  end

  def fare
    return 6 if incomplete?
    Oystercard::MINIMUM_FARE
  end

  def incomplete?
    @entry == nil || @exit == nil
  end

end
