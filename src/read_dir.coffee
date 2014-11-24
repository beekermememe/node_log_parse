fs = require('fs')

DirReader = {}

DirReader.allFiles = []
DirReader.getFiles = (extension,path) ->
  list_of_files = fs.readdirSync(path)

  i = 0
  while i < list_of_files.length
    extRe = RegExp("\\." + extension + "$")
    has_extension = extRe.exec(list_of_files[i])
    if has_extension
      DirReader.allFiles.push(path + "/" + list_of_files[i])
    i += 1
  DirReader.allFiles

DirReader.getDirs = (path) ->
  list_of_files = fs.readdirSync(path)
  i = 0
  list_of_dirs = []
  while i < list_of_files.length
    stat = fs.statSync(path + "/" +list_of_files[i])
    if stat.isDirectory()
      list_of_dirs.push(path + "/" + list_of_files[i])
    i += 1
  list_of_dirs 

DirReader.getAllFilesToRead = (extension,path) ->
  dirs_to_scan = DirReader.getDirs(path)
  i = 0
  allFiles = []
  while i < dirs_to_scan.length
    allFiles = allFiles.concat DirReader.getFiles(extension,dirs_to_scan[i])
    i += 1
  allFiles

module.exports = DirReader
