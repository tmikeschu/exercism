class TwelveDays
  VERSES_DATA = [
    { day: "first",    gift: "a Partridge in a Pear Tree", suffix: "." },
    { day: "second",   gift: "two Turtle Doves",           suffix: ", and " },
    { day: "third",    gift: "three French Hens" },
    { day: "fourth",   gift: "four Calling Birds" },
    { day: "fifth",    gift: "five Gold Rings" },
    { day: "sixth",    gift: "six Geese-a-Laying" },
    { day: "seventh",  gift: "seven Swans-a-Swimming" },
    { day: "eighth",   gift: "eight Maids-a-Milking" },
    { day: "ninth",    gift: "nine Ladies Dancing" },
    { day: "tenth",    gift: "ten Lords-a-Leaping" },
    { day: "eleventh", gift: "eleven Pipers Piping" },
    { day: "twelfth",  gift: "twelve Drummers Drumming" },
  ]

  def self.song
    new.send(:song)
  end
  
  private

  def song
    VERSES_DATA.
      map.with_index(&to_verse_s).
      map { |verse| verse + "\n\n" }.
      join("").
      strip + "\n"
  end

  def to_verse_s
    -> data, index do
      [ "On the ",
        data.fetch(:day),
        " day of Christmas my true love gave to me: ",
        gift_chain("", index)
      ].join("")
    end
  end

  def gift_chain(chain, day)
    # day + data = dayta 🤣
    VERSES_DATA.
      take(day + 1).
      reverse.
      map(&to_gift_s).
      join("")
  end

  def to_gift_s
    @gift_props ||=  
    -> dayta do 
      [[:gift], [:suffix, ", "]].
        reduce("") { |acc, prop| acc + dayta.fetch(*prop) }
    end
  end
end
