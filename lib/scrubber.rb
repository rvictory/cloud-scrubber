# scrubber.rb - the top level Scrubber class, will provide the front facing interface
# All extensions will be patched into here to provide the necessary capabilities
class Scrubber

  # The default extensions
  def self.extensions
    {
        :stdin_input => 'input/stdin_input.rb',
        :memory_persistence => 'persistence/memory.rb'
    }
  end

  # Creates a new instance of the scrubber
  def initialize
    @current_key = 0
  end

  # Scrubs the data
  # @param [Hash] data - the data to scrub
  # @param [Array] pii_keys - the keys of the pii data to scrub
  # @return [Object] - the scrubbed data
  def scrub data, pii_keys
    pii_keys = [pii_keys].flatten
    scrubbed = data.dup
    throw "Persistence module not loaded" unless self.methods.include? :store_record
    key = next_key
    store_record(key, data)
    pii_keys.each {|k| scrubbed[k] = key; puts k}
    scrubbed
  end

  def unscrub data, pii_keys
    pii_keys = [pii_keys].flatten
    # we only really need the first pii_key to get the lookup key
    key = data[pii_keys.first]
    throw "Persistence module not loaded" unless self.methods.include? :retrieve_record
    retrieve_record key
  end

  # Loads an extension into this instance by its path
  def load_extension path
    instance_eval(File.read(File.join(File.dirname(__FILE__), path)))
  end

  def next_key
    @current_key = @current_key + 1
  end

end