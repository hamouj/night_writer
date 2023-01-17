require './spec/spec_helper'
require './lib/content_reader'

describe ContentReader do
  File.open('english_text_1.txt', "w+") {|file| file.write("the quick brown fox jumps over the lazy dog")}
  english_text_1 = File.open('english_text_1.txt', "r")
  braille_text_1 = File.open('braille_text_1.txt', "w")

  File.open('braille_text_2.txt', "w+") {|file| file.write("0...0...00\n", "....0.....\n", "..........")}
  braille_text_2 = File.open('braille_text_2.txt', "r")
  english_text_2 = File.open('english_text_2.txt', "w")

  let(:content_reader1) {ContentReader.new({
    :english_text => english_text_1,
    :braille_text => braille_text_1
  })}

  let(:content_reader2) {ContentReader.new({
    :english_text => english_text_2,
    :braille_text => braille_text_2
  })}

  describe '#initialize' do
    it 'exists' do
      expect(content_reader1).to be_a(ContentReader)
      expect(content_reader2).to be_a(ContentReader)
    end

    it 'has attributes' do
      expect(content_reader1.english_text).to be_a(File)
      expect(content_reader1.braille_text).to be_a(File)
      expect(content_reader2.english_text).to be_a(File)
      expect(content_reader2.braille_text).to be_a(File)
    end
  end

  describe '#night_writer_confirmation_message' do
    it 'returns a confirmation message' do
      expect(content_reader1.night_writer_confirmation_message).to eq('Created braille_text_1.txt containing 43 characters')
    end
  end

  describe '#english_text_content' do
    it 'returns the content of the #english_text file' do
      expect(content_reader1.english_text_content).to eq("the quick brown fox jumps over the lazy dog")
    end
  end

  describe '#split_english_text_content' do
    it 'splits text into characters' do
      allow(content_reader1).to receive(:english_text_content).and_return("a b c")

      expect(content_reader1.split_english_text_content).to eq(["a", " ", "b", " ", "c"])
    end
  end

  describe '#night_reader_confirmation_message' do
    it 'returns a confirmation message' do
      expect(content_reader2.night_reader_confirmation_message).to eq('Created english_text_2.txt containing 5 characters')
    end
  end

  describe '#braille_text_content' do
    it 'returns the content of the #braille_text file' do
      expect(content_reader2.braille_text_content).to eq(["0...0...00\n", "....0.....\n", ".........."])
    end
  end

  describe '#split_braille_letters' do
    it 'splits braille text into individual letter arrays' do
      expect(content_reader2.split_braille_letters).to eq([[["0.", "..",".."], ["..", "..", ".."], ["0.","0.",".."], ["..", "..", ".."], ["00", "..", ".."]]])
    end
  end

  describe '#split_braille_text_content' do
    it 'splits text into characters' do
      expect(content_reader2.split_braille_text_content).to eq([["0.....", "......", "0.0...", "......", "00...."]])
    end

    it 'splits long texts(over 40 English characters) into lines' do
      # The incoming text is 52 english characters long
      allow(content_reader2).to receive(:braille_text_content).and_return([".00..0.0...0.0..0....00.00000.0...0.00..0...0.0.0000...00.00.0...00....00.0..0..",
        "\n", "00000.0...0.0.......0.....0.0..0...00.......0..0.000..00.0..00..00.0..0.00.000..",
        "\n", "0.....0.....0.......0...0.0.0.....0.........0.0.0.....0...000...0.0...0...0..0..",
        "\n","0...0..0000...0.0.0.0.0.\n", "....0.0..0.0..0.00.0....\n", "....0...0.......0.....0.\n"])

      expect(content_reader2.split_braille_text_content.size).to eq(2)
    end
  end
end