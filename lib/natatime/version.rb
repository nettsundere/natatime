module Natatime # :nodoc:
  module Version # :nodoc:
    MAJOR = 0
    MINOR = 0
    TINY = 1
    PRE = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')

    SUMMARY = "Natatime #{STRING}"
  end
end