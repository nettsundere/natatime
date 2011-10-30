module Natatime
  class Lyrics
    def initialize(storage)
      @storage = storage
    end
    
    # Compose lyrics for the required format.
    # Format should be an array.
    # Example: [:at, :ata, :at, :ata]
    def compose(*format)
      need_ats = format.select {|x| x == :at}.size
      need_atas = format.select {|x| x == :ata}.size
      
      # If there is some line format, not :ata or :at, then we should raise
      # an exception, because we don't know how to create such line.
      raise StyleIsNotSupportedError if need_ats + need_atas != format.size
      
      ats_data = [
        @storage.load_nouns(need_ats).shuffle.each, 
        @storage.load_ats(need_ats).shuffle.each
      ]
      
      atas_data = [
        @storage.load_adjectives(need_atas).shuffle.each, 
        @storage.load_atas(need_atas).shuffle.each
      ]
      
      format.map do |line_format|
        if line_format == :at
          "#{ats_data[0].next} #{ats_data[1].next}"
        else
          "#{atas_data[0].next} #{atas_data[1].next}"
        end
      end  
    end
    
    # Error: we can't require negative number of lines.
    class RequiredNegativeLinesCountError < StandardError
    end
    
    # Error: required line style isn't supported.
    class StyleIsNotSupportedError < StandardError
    end
  end 
end
