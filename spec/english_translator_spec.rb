require './spec/spec_helper'
require './lib/content_reader'
require './lib/english_translator'

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
    it 'translates english text to braille and makes a new line after 40 english characters (80 braille characters)' do
      english_translator.translate
      braille_text_1.rewind

      expect(content_reader.braille_text_content.first.chomp.size).to eq(80)
    end

    it 'translate the english text to braille' do
      allow(english_translator).to receive(:english_text_content).and_return(["a"])

      expect(english_translator.translate).to eq("0.\n..\n..\n")
    end

    it 'ignores unknown characters' do
      allow(english_translator).to receive(:english_text_content).and_return(["!"])

      expect(english_translator.translate).to eq("\n\n\n")
    end
  end
end