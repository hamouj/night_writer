require './spec/spec_helper'
require './lib/braille_translator'
require './lib/content_reader'

describe BrailleTranslator do 
  braille_text_2 = File.open('braille_text_2.txt', "r")
  english_text_2 = File.open('english_text_2.txt', "w+")

  let(:braille_translator) {BrailleTranslator.new({
    :english_text => english_text_2,
    :braille_text => braille_text_2
  })}
  let(:content_reader) {ContentReader.new({
    :english_text => english_text_2,
    :braille_text => braille_text_2
  })}

  describe '#initialize' do
    it 'exists' do
      expect(braille_translator).to be_a(BrailleTranslator)
    end
  end

  describe '#lowercase_braille_to_english_dictionary' do
    it 'returns a hash with braille letters(keys) and english translation(values)' do
      expect(braille_translator.lowercase_braille_to_english_dictionary["0....."]).to eq("a")
      expect(braille_translator.lowercase_braille_to_english_dictionary["00..0."]).to eq("m")
      expect(braille_translator.lowercase_braille_to_english_dictionary["......"]).to eq(" ")
    end
  end

  describe '#number_braille_to_english_dictionary' do
    it 'returns a hash with braille numbers(keys) and english translation(values)' do
      expect(braille_translator.number_braille_to_english_dictionary["0..0.."]).to eq("5")
    end
  end

  describe '#uppercase_braille_to_english_dictionary' do
    it 'returns a hash with uppercase letters(keys) and english translation(values)' do
      expect(braille_translator.uppercase_braille_to_english_dictionary["0.0..."]).to eq("B")
      expect(braille_translator.uppercase_braille_to_english_dictionary[".....0"]).to eq("capital")
    end
  end

  describe '#translate_a_line()' do
    it 'translate a single line of braille text to english' do
      allow(braille_translator).to receive(:braille_text_content).and_return(
        [".00..0.0...0.0..0....00.00000.0...0.00..0...0.0.0000...00.00.0...00....00.0..0..\n", 
          "00000.0...0.0.......0.....0.0..0...00.......0..0.000..00.0..00..00.0..0.00.000..\n", 
          "0.....0.....0.......0...0.0.0.....0.........0.0.0.....0...000...0.0...0...0..0..\n",
          "0...0..0000...0.0.0.0.0.\n", "....0.0..0.0..0.00.0....\n", "....0...0.......0.....0.\n"])

      line = ["0.....", "......", "0.0.0.", ".00...", "00.00.", "0..0..", "......", "0.0...", "0.000.", "0..0..", "0.....", "0...0."]

    expect(braille_translator.translate_a_line(line)).to eq(["a", " ", "l", "i", "n", "e", " ", "b", "r", "e", "a", "k"])
    end
  end

  describe '#translate' do
    it 'translates multiple lines of braille text to english, returning 40 alpha characters per line' do
      allow(braille_translator).to receive(:braille_text_content).and_return(
        [".00..0.0...0.0..0....00.00000.0...0.00..0...0.0.0000...00.00.0...00....00.0..0..\n", 
          "00000.0...0.0.......0.....0.0..0...00.......0..0.000..00.0..00..00.0..0.00.000..\n", 
          "0.....0.....0.......0...0.0.0.....0.........0.0.0.....0...000...0.0...0...0..0..\n",
          "0...0..0000...0.0.0.0.0.\n", "....0.0..0.0..0.00.0....\n", "....0...0.......0.....0.\n"])

      braille_translator.translate
      english_text_2.rewind
      # incoming text is 52 alpha characters--translated text contains 40 alpha characters in the first line and 12 in the second.
      expect(File.read(english_text_2)).to eq("this is a sample of a long text to show \na line break\n")
    end

    it 'translates braille text with number symbols to english' do
      allow(braille_translator).to receive(:braille_text_content).and_return(
        [".00.00.0...0.0.00....00.0...000.000.0.0....000\n", 
          "00.0..00..000.0000..0000.0...0....0..000...0..\n", 
          "0...000....0..0.....0.......0.000.....0...00..\n"])

      expect(braille_translator.translate).to eq("text with the number 3")
    end

    it 'translates braille text with multiple numbers to english' do
      allow(braille_translator).to receive(:braille_text_content).and_return(
        ["0....00.00..0.\n", ".....00..0..0.\n", "....00........\n"])

        expect(braille_translator.translate).to eq("a 24 b")
    end

    it 'translates braille text with capital letters to english' do
      allow(braille_translator).to receive(:braille_text_content).and_return(
        ["0.....0000\n", ".0.....0..\n", "00...00000\n"])

        expect(braille_translator.translate).to eq("z Yx")
    end
  end
end

