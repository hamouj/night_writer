require './spec/spec_helper'
require './lib/braille_translator'
require './lib/content_reader'

describe BrailleTranslator do 
  File.open('braille_text_2.txt', "w+") {|file| file.write(".00.00000.0...0.0.0..00.0.0....00.00.0\n0.....0.0..0..0.00..0.0.0..0..00.0..00\n0...0.0.0.......0.....0.0.....0...000.\n")}
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

  describe '#dictionary' do
    it 'returns a hash with braille letters(keys) and english translation(values)' do
      expect(braille_translator.dictionary["0....."]).to eq("a")
      expect(braille_translator.dictionary["00..0."]).to eq("m")
      expect(braille_translator.dictionary["......"]).to eq(" ")
    end
  end

  describe '#translate' do
    it 'translates multiple lines of braille text to english' do
      allow(braille_translator).to receive(:braille_text_content).and_return([".00..0.0...0.0..0....00.00000.0...0.00..0...0.0.0000...00.00.0...00....00.0..0..",
        "\n", "00000.0...0.0.......0.....0.0..0...00.......0..0.000..00.0..00..00.0..0.00.000..",
        "\n", "0.....0.....0.......0...0.0.0.....0.........0.0.0.....0...000...0.0...0...0..0..",
        "\n","0...0..0000...0.0.0.0.0.\n", "....0.0..0.0..0.00.0....\n", "....0...0.......0.....0.\n"])

      braille_translator.translate
      english_text_2.rewind
      expect(File.read(english_text_2)).to eq("this is a sample of a long text to show \na line break\n")
    end

    it 'translates the braille text to english' do
      expect(braille_translator.translate).to eq("sample braille text")
    end
  end
end