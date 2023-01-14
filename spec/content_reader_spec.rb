require './spec/spec_helper'
require './lib/content_reader'

describe ContentReader do
  File.open('sample.txt', "w+") {|file| file.write("the quick brown fox jumps over the lazy dog")}

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
      ARGV = ["message.txt", "braille.txt"]

      expect(content_reader.night_writer_confirmation_message).to eq('Created braille.txt containing 43 characters')
    end
  end

  describe '#content' do
    it 'returns the content of the #english_text file' do
      expect(content_reader.content).to eq(["the quick brown fox jumps over the lazy ", "dog"])
    end
  end

  describe '#split_content' do
    it 'splits lines into characters' do
      allow(content_reader).to receive(:content).and_return(["a b c"])

      expect(content_reader.split_content).to eq([["a", " ", "b", " ", "c"]])
    end
  end
end