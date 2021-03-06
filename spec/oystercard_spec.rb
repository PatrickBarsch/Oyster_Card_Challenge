require 'oystercard'

describe Oystercard do 

  it 'has a balance' do
    expect(subject.balance).to eq (0)
  end  

  describe '#top_up' do

    it 'allows us, to increase our balance' do 
      expect { subject.top_up(20) }.to change { subject.balance }.by 20 
    end

    it 'throws error if balance exceeds maximum limit of £90' do
      balance_limit = Oystercard::BALANCE_LIMIT
      error_message = "Maximum Balance Exceeded: £#{balance_limit}"
      expect { subject.top_up(balance_limit+1) }.to raise_error error_message
    end 

  end

  describe '#deduct' do 
    
      it 'can deduct a fare from the balance' do 
        subject.top_up(20)
        expect { subject.deduct(15) }.to change { subject.balance }.by -15
      end

  end

  describe '#in_journey?, #touch_in, #touch_out' do 

    it 'confirms a new card is not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'confirms when a card is in journey' do
      subject.touch_in
      expect(subject).to be_in_journey
    end 

    it 'confirms when a card is touched out' do 
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey 
    end 

  end 

end 
