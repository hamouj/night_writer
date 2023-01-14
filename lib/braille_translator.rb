require './lib/content_reader'

class BrailleTranslator < ContentReader

  def initialize(locations)
    super(locations)
  end
end