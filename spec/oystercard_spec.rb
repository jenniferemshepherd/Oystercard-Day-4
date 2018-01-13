require 'oystercard'

CARD_LIMIT = 90

describe Oystercard do
  subject(:card) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  describe 'Balance' do
    it "has a balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it "tops up oystercard" do
      expect(card.top_up(10)).to eq 10
    end

    it "raises error if top up limit exceeded" do
      expect {card.top_up(100)}.to raise_error "There is a limit of #{CARD_LIMIT}"
    end
  end

  describe '#touch_in' do
    context 'sufficient balance' do
      it 'alters balance on double touch in' do
        card.top_up(30)
        card.touch_in(entry_station)
        expect {card.touch_in(entry_station)}.to change {card.balance}
      end

      it 'has started journey' do
        card.top_up(30)
        card.touch_in(entry_station)
        expect(card.journey_log.current_journey).not_to be nil
      end
    end

    context 'insufficient balance' do
      it 'wont touch in if balance < min fare' do
        expect {card.touch_in(entry_station)}.to raise_error "you dont have enough money"
      end
    end
  end

  describe '#touch_out' do
    context 'sufficient balance' do
      it 'deducts fare when touching out' do
        card.top_up(30)
        card.touch_in(entry_station)
        expect { card.touch_out(exit_station) }.to change { card.balance }.by (-Oystercard::MINIMUM_FARE)
      end

      it 'applies penalty fare on double touch out' do
        card.top_up(30)
        expect { card.touch_out(exit_station) }.to change { card.balance }.by -6
      end
    end
  end
end
