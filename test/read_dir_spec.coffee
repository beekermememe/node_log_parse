assert = require "assert"
Rf = require "#{__dirname}/../src/read_dir"


describe "Dir Reader", ->
  describe "Module RF", ->
    it "should return the files with the extension .txt", ->
      dir_to_tst = "#{__dirname}/../test_support"
      assert.equal(Rf.getFiles("txt",dir_to_tst).length,1)
    it "should return the directories", ->
      dir_to_tst = "#{__dirname}/../test_support"
      dirs = Rf.getDirs dir_to_tst
      assert.equal(dirs.length,2)
