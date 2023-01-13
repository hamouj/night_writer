require './spec/spec_helper'
require './lib/english_translator'
require './lib/content_reader'

describe EnglishTranslator do
  let(:english_translator) {EnglishTranslator.new}

  describe '#initialize' do
    it 'exists' do
      expect(english_translator).to be_a(EnglishTranslator)
    end
  end
end