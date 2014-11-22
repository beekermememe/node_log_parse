fs = require('fs')

DirReader = {}

DirReader.getFiles = (extension,path) ->
  list_of_files = fs.readdirSync(path)

  files = []
  i = 0
  while i < list_of_files.length
    extRe = RegExp("\\." + extension + "$")
    has_extension = extRe.exec(list_of_files[i])
    if has_extension
      files.push(path + "/" + list_of_files[i])
    i += 1
  files

module.exports = DirReader
