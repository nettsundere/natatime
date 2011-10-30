# Encoding: UTF-8
require 'unicode'

module Natatime

  # Natatime redis-based words storage.
  class Store
    @@generator = Random.new
    
    # Initialization.
    # Redis connection should be passed as parameter.
    def initialize(redis_connection) 
      @redis = redis_connection
    end
    
    # Get the number of words in the storage.
    def words_count
      get_at_words_count + 
      get_ata_words_count +    
      get_noun_words_count + 
      get_adjective_words_count
    end
        
    # Add at' word to the storage.
    def add_at!(word)
      new_word = "#{Unicode.downcase(word)}а"
      @redis.rpush("store:ats", new_word)
    end
    
    # Add ata' word to the storage.
    def add_ata!(word)
      @redis.rpush("store:atas", Unicode.downcase(word))
    end
        
    # Add noun word to the storage.
    def add_noun!(word)
      @redis.rpush("store:nouns", Unicode.downcase(word))
    end
                
    # Add adjective word to the storage.
    def add_adjective!(word)
      new_word = Unicode.downcase(word)
      new_word[-2..-1] = "ая"
      @redis.rpush("store:adjectives", new_word) 
    end
    
    # Load required number (or lower, if required > stored) of random adjective words.
    def load_adjectives(required)
      load_from("store:adjectives", get_adjective_words_count, required)
    end
      
    # Load required number (or lower, if required > stored) of random noun words.
    def load_nouns(required)
      load_from("store:nouns", get_noun_words_count, required)
    end
    
    # Load required number (or lower, if required > stored) of random ata' words.
    def load_atas(required)
      load_from("store:atas", get_ata_words_count, required)
    end
    
    # Load required number (or lower, if required > stored) of random at' words. 
    def load_ats(required)
      load_from("store:ats", get_at_words_count, required)
    end
    
    # Error: we can't require negative number of elements from the storage.
    class RequiredNegativeError < StandardError
    end
    
    # Error: we can't load this number of elements.
    class NotEnoughElementsError < StandardError
    end
    
    private
    
      # Get the number of at' words in the storage.
      def get_at_words_count
        @redis.llen("store:ats").to_i
      end
      
      # Get the number of ata' words in the storage.
      def get_ata_words_count
        @redis.llen("store:atas").to_i
      end
      
      # Get the number of noun words in the storage.
      def get_noun_words_count
        @redis.llen("store:nouns").to_i
      end
      
      # Get the number of adjective words in the storage.
      def get_adjective_words_count
        @redis.llen("store:adjectives").to_i
      end
      
      # Load required items from list with elements_count elements.
      # Maximum sequence size can be passed as parameter.
      def load_from(list_name, elements_count, required, max_sequence_size = 3)
        raise RequiredNegativeError if required < 0
        raise NotEnoughElementsError unless required <= elements_count
        
        req_words = []
        while req_words.size < required
          start = @@generator.rand(0..elements_count)
          sequence_size = [required - req_words.size, max_sequence_size].min
          req_words = req_words | @redis.lrange(list_name, start, start + sequence_size - 1)
        end
        req_words
      end
  end
end
