require './lib/content_reader'

describe ContentReader do
  let(:content_reader) {ContentReader.new({
    :english_text => 'message.txt',
    :braille_text => 'braille.txt'})}

  describe '#initialize' do
    it 'exists' do
      expect(content_reader).to be_a(ContentReader)
    end

    it 'has attributes' do
      expect(content_reader.english_text).to be_a(File)
      expect(content_reader.braille_text).to be_a(File)
    end
  end
end