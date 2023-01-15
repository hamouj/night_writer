require './spec/spec_helper'
require './lib/braille_translator'
require './lib/content_reader'

describe BrailleTranslator do 
  File.open('braille_sample.txt', "w+") {|file| file.write(".00.00000.0...0.0.0..00.0.0....00.00.0\n0.....0.0..0..0.00..0.0.0..0..00.0..00\n0...0.0.0.......0.....0.0.....0...000.\n")}

  let(:braille_translator) {BrailleTranslator.new({
    :english_text => 'sample.txt',
    :braille_text => 'braille_sample.txt'
  })}
  let(:content_reader) {ContentReader.new({
    :english_text => 'sample.txt',
    :braille_text => 'braille_sample.txt'
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