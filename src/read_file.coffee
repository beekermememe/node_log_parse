fs = require('fs')

Reader = {}
Reader.filename = "testfiles/cpegi05/localhost_access_log.2014-11-14.00.txt"
Reader.buckets = {}
Reader.stats = {}
Reader.filereader = (name_of_file) ->
  data = fs.readFileSync(name_of_file)
  number_of_lines = data.toString().split("\n").length
  number_of_lines


Reader.bucketer = (lineToAnalyze) ->
  egiRe = new RegExp "\/solr\/dish_live\/select\/"
  mliveRe = new RegExp "\/solr\/media_live\/select"
  imagesRe = new RegExp "\/program_images\/"
  danyRe = new RegExp "dishonline-client|Explorer|Mozilla"
  mobileRe = new RegExp "da-android|sg-iphone|sg-ipad"
  if egiRe.exec lineToAnalyze
    if danyRe.exec lineToAnalyze
      Reader.buckets.dany_web_dish_live = 0 if Reader.buckets.dany_web_dish_live == undefined
      Reader.buckets.dany_web_dish_live += 1
      Reader.breakdownUsids "WebDishLive",lineToAnalyze
    else if mobileRe.exec lineToAnalyze
      Reader.buckets.dany_mobile_dish_live = 0 if Reader.buckets.dany_mobile_dish_live == undefined
      Reader.buckets.dany_mobile_dish_live += 1 
      Reader.breakdownUsids "MobileDishLive",lineToAnalyze
    else
      Reader.buckets.dany_unknown_dish_live = 0 if Reader.buckets.dany_unknown_dish_live == undefined
      Reader.buckets.dany_unknown_dish_live += 1
  else if mliveRe.exec lineToAnalyze
    debugger
    if danyRe.exec lineToAnalyze
      Reader.buckets.dany_web_media_live = 0 if Reader.buckets.dany_web_media_live == undefined
      Reader.buckets.dany_web_media_live += 1
      Reader.breakdownTmsids "WebMediaLive",lineToAnalyze

    else if mobileRe.exec lineToAnalyze
      Reader.buckets.dany_mobile_media_live = 0 if Reader.buckets.dany_mobile_media_live == undefined
      Reader.buckets.dany_mobile_media_live += 1
      Reader.breakdownTmsids "MobileMediaLive",lineToAnalyze       
    else
      Reader.buckets.dany_unknown_media_live = 0 if Reader.buckets.dany_unknown_media_live == undefined
      Reader.buckets.dany_unknown_media_live += 1


Reader.analyzeFile = (name_of_file) ->
  console.log("Processing - " + name_of_file + " | " + Reader.filereader(name_of_file) + " lines")
  data = fs.readFileSync(name_of_file).toString().split("\n")
  i = 0
  while i < data.length
    Reader.bucketer data[i]
    i++
  console.log("dish live calls by web " + Reader.buckets.dany_web_dish_live)
  console.log("dish live calls by mobile " + Reader.buckets.dany_mobile_dish_live)
  console.log("media live calls by web " + Reader.buckets.dany_web_media_live)
  console.log("media live calls by mobile " + Reader.buckets.dany_mobile_media_live)

Reader.breakdownUsids = (call_type,lineToAnalyze) ->
  tmsidRe = new RegExp "usid:\\(([0123456789\+]+)"
  result = tmsidRe.exec lineToAnalyze
  idcount = 0
  if result
    idcount = result[1].split("+").length
  idcount  

Reader.breakdownTmsids = (call_type,lineToAnalyze) ->
  tmsidRe = new RegExp "tmsid:\\(([MVEPSH0123456789\+]+)"
  result = tmsidRe.exec lineToAnalyze
  idcount = 0
  if result[1]
    idcount = result[1].split("+").length
  idcount

Reader.bucketstat = (call_type,count) ->
  if Reader.stats[call_type] == undefined
    Reader.stats[call_type] = {}
  if count <= 20
    if Reader.stats[call_type].under_20 == undefined
      Reader.stats[call_type].under_20 = 0
    Reader.stats[call_type].under_20 += 1
  else if count <= 100
    if Reader.stats[call_type].under_100 == undefined
      Reader.stats[call_type].under_100 = 0
    Reader.stats[call_type].under_100 += 1
  else if count <= 200
    if Reader.stats[call_type].under_200 == undefined
      Reader.stats[call_type].under_200 = 0
    Reader.stats[call_type].under_200 += 1
  else
    if Reader.stats[call_type].over_200 == undefined
      Reader.stats[call_type].over_200 = 0
    Reader.stats[call_type].over_200 += 1
  Reader.stats

module.exports = Reader

