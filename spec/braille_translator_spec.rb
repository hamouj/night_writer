require './spec/spec_helper'
require './lib/braille_translator'
require './lib/content_reader'

describe BrailleTranslator do 
  File.open('braille_text_2.txt', "w+") {|file| file.write(".00.00000.0...0.0.0..00.0.0....00.00.0\n0.....0.0..0..0.00..0.0.0..0..00.0..00\n0...0.0.0.......0.....0.0.....0...000.\n")}
  braille_text_2 = File.open('braille_text_2.txt', "r")
  english_text_2 = File.open('english_text_2.txt', "w")

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
    it 'translates the braille text to english' do
      expect(braille_translator.translate).to eq("sample braille text")
    end
  end
end