require './lib/content_reader'

class BrailleTranslator < ContentReader

  def initialize(locations)
    super(locations)
  end

  def dictionary
    b1 = ".."
    b2 = "0."
    b3 = ".0"
    b4 = "00"

    dictionary = {
      [b2, b1, b1].join => "a",
      [b2, b2, b1].join => "b",
      [b4, b1, b1].join => "c",
      [b4, b3, b1].join => "d",
      [b2, b3, b1].join => "e",
      [b4, b2, b1].join => "f",
      [b4, b4, b1].join => "g",
      [b2, b4, b1].join => "h",
      [b3, b2, b1].join => "i",
      [b3, b4, b1].join => "j",
      [b2, b1, b2].join => "k",
      [b2, b2, b2].join => "l",
      [b4, b1, b2].join => "m",
      [b4, b3, b2].join => "n",
      [b2, b3, b2].join => "o",
      [b4, b2, b2].join => "p",
      [b4, b4, b2].join => "q",
      [b2, b4, b2].join => "r",
      [b3, b2, b2].join => "s",
      [b3, b4, b2].join => "t",
      [b2, b1, b4].join => "u",
      [b2, b2, b4].join => "v",
      [b3, b4, b3].join => "w",
      [b4, b1, b4].join => "x",
      [b4, b3, b4].join => "y",
      [b2, b3, b4].join => "z",
      [b1, b1, b1].join => " "
    }
  end
end