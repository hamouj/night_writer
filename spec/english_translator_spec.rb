require './spec/spec_helper'
require './lib/content_reader'
require './lib/english_translator'

describe EnglishTranslator do
  english_text_1 = File.open('english_text_1.txt', "r")
  braille_text_1 = File.open('braille_text_1.txt', "w+")

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

  describe '#lowercase_english_to_braille_dictionary' do
    it 'returns a hash with lowercase letters(keys) and braille translations(values)' do
      expect(english_translator.lowercase_english_to_braille_dictionary["a"]).to eq(["0.", "..", ".."])
      expect(english_translator.lowercase_english_to_braille_dictionary["m"]).to eq(["00", "..", "0."])
      expect(english_translator.lowercase_english_to_braille_dictionary[" "]).to eq(["..", "..", ".."])
    end
  end

  describe '#number_english_to_braille_dictionary' do
    it 'returns a hash with numbers(keys) and braille translations(values)' do
      expect(english_translator.number_english_to_braille_dictionary["1"]).to eq(["0.", "..", ".."])
    end
  end

  describe '#uppercase_english_to_braille_dictionary' do
    it 'returns a hash with uppercase letters(keys) and braille translations(values)' do
      expect(english_translator.uppercase_english_to_braille_dictionary["B"]).to eq(["0.", "0.", ".."])
      expect(english_translator.uppercase_english_to_braille_dictionary["Z"]).to eq(["0.", ".0", "00"])
    end
  end

  describe '#translate_entire_text' do
    it 'translates the entire english text' do
      english_translator.translate_entire_text

      expect(english_translator.line_1.size).to eq(43)
    end
  end

  describe '#translate()' do
    it 'translates english text to braille and makes a new line after 40 english characters (80 braille characters)' do
      english_translator.translate

      expect(content_reader.braille_text_content.first.chomp.size).to eq(80)
    end

    it 'translates english text with numbers to braille' do
      allow(english_translator).to receive(:english_text_content).and_return("text with the number 3")

      expect(english_translator.translate).to eq(".00.00.0...0.0.00....00.0...000.000.0.0....000\n00.0..00..000.0000..0000.0...0....0..000...0..\n0...000....0..0.....0.......0.000.....0...00..\n")
    end

    it 'translates english text with multiple numbers to braille' do
      allow(english_translator).to receive(:english_text_content).and_return("a 24 b")

      expect(english_translator.translate).to eq("0....00.00..0.\n.....00..0..0.\n....00........\n")
    end

    it 'translates english text with capital letters to braille' do
      allow(english_translator).to receive(:english_text_content).and_return("z Yx")

      expect(english_translator.translate).to eq("0.....0000\n.0.....0..\n00...00000\n")
    end

    it 'ignores unknown characters' do
      allow(english_translator).to receive(:english_text_content).and_return("hi!")

      expect(english_translator.translate).to eq("0..0\n000.\n....\n")
    end
  end
end