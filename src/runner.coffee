FileReader = require "#{__dirname}/../src/read_file"

DirReader = require "#{__dirname}/../src/read_dir"

path_to_read = "#{__dirname}/../testfiles/cpegi09"

FileReader.runFiles DirReader.getFiles("txt",path_to_read)
