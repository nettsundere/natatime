module Natatime
  class Lyrics
    def initialize(store)
      
    end
  
    # Compose required count of lines of lyrics.
    # Required number of lines should be passed as parameter.      
    def compose(number)
      raise RequiredNegativeLinesCountError if number < 0
      
      #number.times do
      #      
      #end
    end      
    
    # Error: we can't require negative number of lines.
    class RequiredNegativeLinesCountError < StandardError
    end
  end 
end