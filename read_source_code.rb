file_name = File.basename(__FILE__)
File.open(file_name) do |line|
  puts line.readlines
end