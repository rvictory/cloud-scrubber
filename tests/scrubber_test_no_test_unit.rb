# scrubber_test_no_test_unit.rb - scrubber test without test unit

require_relative '../lib/scrubber'

@scrubber = Scrubber.new()
@scrubber.load_extension(Scrubber.extensions[:stdin_input])
puts @scrubber.methods.include? :read_record