require "test/unit"
require_relative '../lib/scrubber'

class ScrubberTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @scrubber = Scrubber.new()
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Test that we can include the stdin module
  def test_stdin_input
    @scrubber.load_extension(Scrubber.extensions[:stdin_input])
    assert_includes(@scrubber.methods, :read_record, "Scrubber should now include read_record method")
  end

  # Test that we can add the memory persistence, persist and read back a key
  def test_memory_persistence
    @scrubber.load_extension(Scrubber.extensions[:memory_persistence])
    key = "My Key"
    data = "This is my data"
    @scrubber.store_record(key, data)
    assert_equal(@scrubber.retrieve_record(key), data, "Persisted data should match retrieved data")
  end

  def test_scrubbing
    @scrubber.load_extension(Scrubber.extensions[:memory_persistence])
    data = {:id => 'Secret ID', :data => "This is my data"}
    scrubbed = @scrubber.scrub data, :id
    puts scrubbed.inspect
    assert_not_equal(data[:id], scrubbed[:id], "Scrubbed data shouldn't have the ID anymore")
    assert_equal(data, @scrubber.unscrub(scrubbed, :id), "Unscrubbed data should equal original data")
  end

end