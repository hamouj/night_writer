require './lib/content_reader'

class BrailleTranslator < ContentReader

  def initialize(locations)
    super(locations)
  end

  def dictionary_letters
    b1 = ".."
    b2 = "0."
    b3 = ".0"
    b4 = "00"

    letters = {
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
      [b1, b1, b1].join => " ",
    }
  end

  def dictionary_numbers
    b1 = ".."
    b2 = "0."
    b3 = ".0"
    b4 = "00"

    numbers = {
      [b2, b1, b1].join => "1",
      [b2, b2, b1].join => "2",
      [b4, b1, b1].join => "3",
      [b4, b3, b1].join => "4",
      [b2, b3, b1].join => "5",
      [b4, b2, b1].join => "6",
      [b4, b4, b1].join => "7",
      [b2, b4, b1].join => "8",
      [b3, b2, b1].join => "9",
      [b3, b4, b1].join => "0"
    }
  end

  def translate_a_line(line)
    line_translation = []
    index_condition = [nil, "......"]
   
    index = 0
    line.each do |character|
      if character == ".0.000"
        index += 1
        while !index_condition.include?(line[index])
          line_translation << dictionary_numbers[line[index]]
          line[index].clear
          index += 1
        end
      elsif dictionary_letters.include?(character)
        line_translation << dictionary_letters[character]
      else
        next
      end
    index += 1
    end
    line_translation.join
  end

  def translate
    split_content = split_braille_text_content

    # index=0
    # while index != split_content.size
    #   message = translate_a_line(index)
    #   @english_text.write("#{message}\n")
    #   translate_a_line(index).clear
    #   index+=1
    # end

    message = ""
    split_content.each do |line|
      message = translate_a_line(line)
      @english_text.write("#{message}\n")
    end
    message
  end
end