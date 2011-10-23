lib_files_pattern = "#{File.dirname __FILE__}/natatime/*.rb"
Dir[lib_files_pattern].each {|lib| require lib }
