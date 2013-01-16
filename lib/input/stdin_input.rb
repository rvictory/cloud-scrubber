# stdin_input.rb - provides a data source of stdin, expects one record per line

def read_record
  ARGF.gets().chomp()
end