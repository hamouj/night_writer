require './spec/spec_helper'
require './lib/english_translator'
require './lib/content_reader'

describe EnglishTranslator do
  File.open('english_text_1.txt', "w+") {|file| file.write("the quick brown fox jumps over the lazy dog")}
  english_text_1 = File.open('english_text_1.txt', "r")
  braille_text_1 = File.open('braille_text_1.txt', "w")

  let(:english_translator) {EnglishTranslator.new({
    :english_text => english_text_1,
    :braille_text => braille_text_1
  })}
  let(:content_reader) {ContentReader.new({
    :english_text => english_text_1,
    :braille_text => braille_text_1
  })}

  describe '#initialize' do
    it 'exists' do
      expect(english_translator).to be_a(EnglishTranslator)
    end
  end

  describe '#dictionary' do
    it 'returns a hash with letters(keys) and braille translation (values)' do
      expect(english_translator.dictionary["a"]).to eq(["0.", "..", ".."])
      expect(english_translator.dictionary["m"]).to eq(["00", "..", "0."])
      expect(english_translator.dictionary[" "]).to eq(["..", "..", ".."])
    end
  end

  describe '#translate()' do
    it 'translate the english text to braille' do
      allow(english_translator).to receive(:english_text_content).and_return(["a"])

      expect(english_translator.translate.chomp).to eq("0.\n..\n..")
    end

    it 'ignores unknown characters' do
      allow(english_translator).to receive(:english_text_content).and_return(["!"])

      expect(english_translator.translate.chomp).to eq("\n\n")
    end
  end
end