# memory.rb - persists the lookups in memory. This is FOR DEVELOPMENT ONLY and shouldn't be used in production!
#             If the script fails for whatever reason, you'll lose all the mappings

@records = {}

def store_record key, value
  throw "Key already exists" if @records.has_key? key
  @records[key] = value
end

def retrieve_record key
  throw "Key not found!" unless @records.has_key? key
  @records.delete(key)
end