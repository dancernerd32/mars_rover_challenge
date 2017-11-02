require_relative '../mars_rover_challenge'
describe MarsRoverChallenge do
  let(:challenge){ MarsRoverChallenge.new }

  describe '#valid_input?' do
    let(:input){"foo"}
    context 'for plateau coords' do
      it 'returns true when it plateau_input_valid is true' do
        allow(challenge).to receive(:plateau_input_valid?).with(input).and_return(true)
        expect(challenge.valid_input?(:plateau_coords, input)).to be(true)
      end

      it 'returns false when it plateau_input_valid is false' do
        allow(challenge).to receive(:plateau_input_valid?).with(input).and_return(false)
        expect(challenge.valid_input?(:plateau_coords, input)).to be(false)
      end
    end

    context 'for first rover position' do
      it 'returns true when it initial_rover_position_valid is true' do
        allow(challenge).to receive(:initial_rover_position_valid?).with(input)
          .and_return(true)
        expect(challenge.valid_input?(:rover_position_initial, input)).to be(true)
      end

      it 'returns false when it initial_rover_position_valid is false' do
        allow(challenge).to receive(:initial_rover_position_valid?).with(input)
          .and_return(false)
        expect(challenge.valid_input?(:rover_position_initial, input)).to be(false)
      end
    end

    context 'for subsequent rover positions' do
      it 'returns true when it subsequent_rover_position_valid is true' do
        allow(challenge).to receive(:subsequent_rover_position_valid?).with(input)
          .and_return(true)
        expect(challenge.valid_input?(:rover_position_subsequent, input)).to be(true)
      end

      it 'returns false when it subsequent_rover_position_valid is false' do
        allow(challenge).to receive(:subsequent_rover_position_valid?).with(input)
          .and_return(false)
        expect(challenge.valid_input?(:rover_position_subsequent, input)).to be(false)
      end
    end

    context 'for rover directions' do
      it 'returns true when it rover_directions_valid is true' do
        allow(challenge).to receive(:rover_directions_valid?).with(input)
          .and_return(true)
        expect(challenge.valid_input?(:rover_directions, input)).to be(true)
      end
      it 'returns false when it rover_directions_valid is false' do
        allow(challenge).to receive(:rover_directions_valid?).with(input)
          .and_return(false)
        expect(challenge.valid_input?(:rover_directions, input)).to be(false)
      end
    end
  end

  describe '#plateau_input_valid?' do
    it 'returns true when it receives a string of the form <digit digit>' do
      input = "5 5"
      expect(challenge.plateau_input_valid?(input)).to be true
    end

    it 'still returns true if the number has multiple digits' do
      input = "55 54"
      expect(challenge.plateau_input_valid?(input)).to be true
    end

    it 'returns false if a space is missing' do
      input = "55"
      expect(challenge.plateau_input_valid?(input)).to be false
    end

    it 'returns false if it contains a non-digit, non-whitespace character' do
      input = "5 B"
      expect(challenge.plateau_input_valid?(input)).to be false
    end

    it 'returns false if an extra space is added' do
      input = "5  5"
      expect(challenge.plateau_input_valid?(input)).to be false
    end
  end

  describe '#initial_rover_position_valid?' do
    it 'returns true when it receives a string of the form <digit digit direction>' do
      input = "6 5 N"
      expect(challenge.initial_rover_position_valid?(input)).to be(true)
    end

    it 'still returns true if the number has multiple digits' do
      input = "66 54 S"
      expect(challenge.initial_rover_position_valid?(input)).to be(true)
    end

    it 'returns false if a space is left out' do
      input = "65 N"
      expect(challenge.initial_rover_position_valid?(input)).to be(false)
    end

    it 'returns false if there is an extra space' do
      input = "6  5 N"
      expect(challenge.initial_rover_position_valid?(input)).to be(false)
    end

    it 'returns false if the last character is not a direction' do
      input = "6 5 A"
      expect(challenge.initial_rover_position_valid?(input)).to be(false)
    end

    it 'returns false if a number spot is not filled by a number' do
      input = "6 A A"
      expect(challenge.initial_rover_position_valid?(input)).to be(false)
    end

  end

  describe '#subsequent_rover_position_valid?' do
    it 'returns true when it receives an empty string' do
      input = ""
      expect(challenge.subsequent_rover_position_valid?(input)).to be(true)
    end

    it 'returns true when initial_rover_position_valid is true' do
      input = "foo"
      allow(challenge).to receive(:initial_rover_position_valid?).with(input)
        .and_return(true)
      expect(challenge.subsequent_rover_position_valid?(input)).to be(true)
    end

    it 'returns false when it is not an empty string and
      initial_rover_position_valid is false' do
      input = "foo"
      allow(challenge).to receive(:initial_rover_position_valid?).with(input)
        .and_return(false)
      expect(challenge.subsequent_rover_position_valid?(input)).to be(false)
    end
  end

  describe '#rover_directions_valid?' do
    it 'returns true when it receives an empty string' do
      input = ""
      expect(challenge.rover_directions_valid?(input)).to be(true)
    end

    it 'returns true when it receives a single valid character (R,L, or M)' do
      expect(challenge.rover_directions_valid?("R")).to be(true)
      expect(challenge.rover_directions_valid?("L")).to be(true)
      expect(challenge.rover_directions_valid?("M")).to be(true)
    end

    it 'returns true when it receives a short string of valid characters' do
      input = "RMRMLM"
      expect(challenge.rover_directions_valid?(input)).to be(true)
    end

    it 'returns true when it receives a longer string of valid characters' do
      input = "RMRMLMLMMMRMLMRRRMRRRMLMMLMRMLMMRMMLMRM"
      expect(challenge.rover_directions_valid?(input)).to be(true)
    end

    it 'returns false when it receives a string with a space in it' do
      input = "RM RMLM"
      expect(challenge.rover_directions_valid?(input)).to be(false)
    end

    it 'returns false when it receives a string with a letter other than R, L, M' do
      input = "RMRMLA"
      expect(challenge.rover_directions_valid?(input)).to be(false)
    end

    it 'returns false when it receives a string with a lowercase r, l, or m' do
      input = "rmrmlm"
      expect(challenge.rover_directions_valid?(input)).to be(false)
    end
  end
end
