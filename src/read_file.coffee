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
      count = Reader.breakdownUsids "WebDishLive",lineToAnalyze
      Reader.bucketstat("WebDishLive",count)
    else if mobileRe.exec lineToAnalyze
      Reader.buckets.dany_mobile_dish_live = 0 if Reader.buckets.dany_mobile_dish_live == undefined
      Reader.buckets.dany_mobile_dish_live += 1 
      count = Reader.breakdownUsids "MobileDishLive",lineToAnalyze
      Reader.bucketstat("MobileDishLive",count)
    else
      Reader.buckets.dany_unknown_dish_live = 0 if Reader.buckets.dany_unknown_dish_live == undefined
      Reader.buckets.dany_unknown_dish_live += 1
  else if mliveRe.exec lineToAnalyze
    debugger
    if danyRe.exec lineToAnalyze
      Reader.buckets.dany_web_media_live = 0 if Reader.buckets.dany_web_media_live == undefined
      Reader.buckets.dany_web_media_live += 1
      count = Reader.breakdownTmsids "WebMediaLive",lineToAnalyze
      Reader.bucketstat("WebMediaLive",count)

    else if mobileRe.exec lineToAnalyze
      Reader.buckets.dany_mobile_media_live = 0 if Reader.buckets.dany_mobile_media_live == undefined
      Reader.buckets.dany_mobile_media_live += 1
      count = Reader.breakdownTmsids "MobileMediaLive",lineToAnalyze
      Reader.bucketstat("MobileMediaLive",count)

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
  loggroups = ["WebMediaLive","MobileMediaLive","WebDishLive","MobileDishLive"]
  buckets = ["under_20","under_100","under_200","over_20"]
  i = 0
  while i < loggroups.length
    v = 0
    while v < buckets.length
      if Reader.stats[loggroups[i]][buckets[v]]
        console.log(loggroups[i] + "." + buckets[v] + " = " + Reader.stats[loggroups[i]][buckets[v]])
      v += 1
    i += 1

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
  if result
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

