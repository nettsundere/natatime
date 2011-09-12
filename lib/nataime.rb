# We require every .rb file in /nataime
lib_files_pattern = "#{File.dirname __FILE__}/nataime/*.rb"
Dir[lib_files_pattern].each {|lib| require lib }
