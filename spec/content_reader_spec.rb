require './spec/spec_helper'
require './lib/content_reader'

describe ContentReader do
  File.open('sample.txt', "w+") {|file| file.write("the quick brown fox jumps over the lazy dog")}
  File.open('braille_sample.txt', "w+") {|file| file.write(".00.00000.0...0.0.0..00.0.0....00.00.0\n0.....0.0..0..0.00..0.0.0..0..00.0..00\n0...0.0.0.......0.....0.0.....0...000.\n")}

  let(:content_reader) {ContentReader.new({
    :english_text => 'sample.txt',
    :braille_text => 'braille_sample.txt'
  })}

  describe '#initialize' do
    it 'exists' do
      expect(content_reader).to be_a(ContentReader)
    end

    it 'has attributes' do
      expect(content_reader.english_text).to be_a(File)
      expect(content_reader.braille_text).to be_a(File)
    end
  end

  describe '#night_writer_confirmation_message' do
    it 'returns a confirmation message' do
      expect(content_reader.night_writer_confirmation_message).to eq('Created braille_sample.txt containing 43 characters')
    end
  end

  describe '#english_text_content' do
    it 'returns the content of the #english_text file' do
      expect(content_reader.english_text_content).to eq(["the quick brown fox jumps over the lazy ", "dog"])
    end
  end

  describe '#english_text_split_content' do
    it 'splits lines into characters' do
      allow(content_reader).to receive(:english_text_content).and_return(["a b c"])

      expect(content_reader.split_english_text_content).to eq([["a", " ", "b", " ", "c"]])
    end
  end

  describe '#night_reader_confirmation_message' do
    it 'returns a confirmation message' do
      expect(content_reader.night_reader_confirmation_message).to eq('Created sample.txt containing 19 characters')
    end
  end

  describe '#braille_text_content' do
    it 'returns the content of the #braille_text file' do
      expect(content_reader.braille_text_content).to eq([".00.00000.0...0.0.0..00.0.0....00.00.0\n", "0.....0.0..0..0.00..0.0.0..0..00.0..00\n", "0...0.0.0.......0.....0.0.....0...000.\n"])
    end
  end
end