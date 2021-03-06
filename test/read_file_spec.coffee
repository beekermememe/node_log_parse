assert = require "assert"
Rf = require "#{__dirname}/../src/read_file"


describe "File Reader", ->
  describe "Module RF", ->
    it "should return the number of lines", ->
      file_to_tst = "#{__dirname}/../test_support/testfile1.txt"
      assert.equal(Rf.filereader(file_to_tst),9)

    it "should determine the correct buckets for dish_live and android", ->
      line_to_test = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/dish_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "da-android-tablet/4.1.22"'

      line_to_not_count = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/dish_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "da-web-tablet/4.1.22"'

      if Rf.buckets.dany_mobile_dish_live == undefined
        previous_count =  0
      else
        previous_count = Rf.buckets.dany_mobile_dish_live
      
      Rf.bucketer(line_to_test)
      assert.equal(Rf.buckets.dany_mobile_dish_live, (previous_count+1))
      
      Rf.bucketer(line_to_not_count)
      assert.equal(Rf.buckets.dany_mobile_dish_live, (previous_count+1))

    it "should determine the correct buckets for dish_live and iphone", ->
      line_to_test = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/dish_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "sg-iphone/4.1.22"'

      line_to_not_count = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/dish_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "da-web-tablet/4.1.22"'

      if Rf.buckets.dany_mobile_dish_live == undefined
        previous_count =  0
      else
        previous_count = Rf.buckets.dany_mobile_dish_live
      
      Rf.bucketer(line_to_test)
      assert.equal(Rf.buckets.dany_mobile_dish_live, (previous_count+1))
      
      Rf.bucketer(line_to_not_count)
      assert.equal(Rf.buckets.dany_mobile_dish_live, (previous_count+1))

    it "should determine the correct buckets for dish_live and iphone", ->
      line_to_test = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/dish_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "sg-ipad/4.1.22"'

      line_to_not_count = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/dish_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "da-web-tablet/4.1.22"'

      if Rf.buckets.dany_mobile_dish_live == undefined
        previous_count =  0
      else
        previous_count = Rf.buckets.dany_mobile_dish_live
      
      Rf.bucketer(line_to_test)
      assert.equal(Rf.buckets.dany_mobile_dish_live, (previous_count+1))
      
      Rf.bucketer(line_to_not_count)
      assert.equal(Rf.buckets.dany_mobile_dish_live, (previous_count+1))

    it "should determine the correct buckets for media and iphone", ->
      line_to_test = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/media_live/select/?q=((tmsid:(MV000592850000+MV001451930000+MV003387320000+MV003654150000+MV003752590000+MV000254520000+MV000427990000+MV002240100000+EP017516880020+MV003978370000+MV002186020000+MV000203700000+MV004006340000+MV003687200000+MV000113970000+MV001170260000+EP015864390003+MV000734400000+MV003685570000+MV001095540000+SH019194510000+MV001469830000+MV001419090000+MV005296590000+EP018636030070+MV005641360000+MV000054450000+MV001580630000+MV002465230000+MV001923770000+SH002191530000+EP015864390002+MV002139650000+MV003681120000+MV001412490000+MV002366380000+EP019059960013+EP018636030068+EP018636030069+MV004446040000+SH018636030000+MV002806070000+MV003471740000+MV005345110000+MV002464230000+EP003077660300+MV000890510000+MV001440540000+MV001491400000+EP019059960004+MV004507700000+MV001818990000+MV003796850000+MV003986850000+MV003619870000+SH019254500000+MV003457520000+MV001483120000+EP019059960005+SH015039910000+MV001556560000+MV001190790000+MV000317690000+MV003752340000+MV004219390000+MV004509820000+MV001584020000+EP017516880023+MV002527890000+MV005724360000+MV004597220000+MV003858640000+MV004781960000+MV004006300000+MV004407360000+MV003858540000+MV004446060000+MV003879820000+MV002559490000+MV003773570000+MV004441100000+MV004613680000+MV004141460000+MV003998430000+MV002134860000+MV001563440000+MV004058160000+MV003858680000+MV004357300000+MV003819940000+MV000000430000+MV000426860000+MV003707210000+MV002467390000+MV003878200000+MV001728630000+MV004084190000+MV004267570000+MV004121440000+MV004440640000+MV004440640000+MV000343000000+EP011750960028+EP010092340369+MV003515170000+EP004249980104+EP006335350041+EP018932320095+SH017397650000+MV001760450000+EP012647370090+EP018932320085+MV001622730000+EP019059960036+EP018932320112+MV001575970000+MV003497450000+MV000828300000+EP009556790045+EP015864390001+EP013701810032+EP019059960037+MV001621000000+EP013602140072+MV000182330000+MV001479960000+MV003408300000+EP010323830016+EP006747690039+EP012647370092+MV005430450000+MV002273060000+EP009488470456+MV003421450000+EP019059960038+EP017516880025+EP013602140073+MV001321260000+EP010939580001+MV002000690000+EP010939580005+EP010939580007+EP019534220001+EP014194440092+MV002464230000+MV000365980000+MV001789080000+MV002084110000+EP010323830023+EP006747690040+EP012647370093+MV001476290000+EP014122490020+EP019633580001+MV005987500000+MV005987500000+EP014122490021+MV001140600000+EP014194440080+SH000193170000+EP013602140074+MV003487130000+EP017403750012+MV000000000000+MV000325310000+MV000025480000+EP010323830024+EP006747690041+EP012647370094+EP009556790092+MV003986860000+SH014784160000+SH006716110000+EP014122490038+EP013602140075+EP008466780060+MV000428760000+EP008884030023+EP008884030025+EP005086070023+EP005086070024)+AND+(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "sg-ipad/4.1.22"'

      line_to_not_count = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/media_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "da-web-tablet/4.1.22"'

      if Rf.buckets.dany_mobile_media_live == undefined
        previous_count =  0
      else
        previous_count = Rf.buckets.dany_mobile_media_live


      Rf.bucketer(line_to_test)
      assert.equal(Rf.buckets.dany_mobile_media_live, (previous_count+1))
      
      Rf.bucketer(line_to_not_count)
      assert.equal(Rf.buckets.dany_mobile_media_live, (previous_count+1))

    it "should determine the correct buckets for media and iphone", ->
      line_to_test = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/media_live/select/?q=((tmsid:(MV000592850000+MV001451930000+MV003387320000+MV003654150000+MV003752590000+MV000254520000+MV000427990000+MV002240100000+EP017516880020+MV003978370000+MV002186020000+MV000203700000+MV004006340000+MV003687200000+MV000113970000+MV001170260000+EP015864390003+MV000734400000+MV003685570000+MV001095540000+SH019194510000+MV001469830000+MV001419090000+MV005296590000+EP018636030070+MV005641360000+MV000054450000+MV001580630000+MV002465230000+MV001923770000+SH002191530000+EP015864390002+MV002139650000+MV003681120000+MV001412490000+MV002366380000+EP019059960013+EP018636030068+EP018636030069+MV004446040000+SH018636030000+MV002806070000+MV003471740000+MV005345110000+MV002464230000+EP003077660300+MV000890510000+MV001440540000+MV001491400000+EP019059960004+MV004507700000+MV001818990000+MV003796850000+MV003986850000+MV003619870000+SH019254500000+MV003457520000+MV001483120000+EP019059960005+SH015039910000+MV001556560000+MV001190790000+MV000317690000+MV003752340000+MV004219390000+MV004509820000+MV001584020000+EP017516880023+MV002527890000+MV005724360000+MV004597220000+MV003858640000+MV004781960000+MV004006300000+MV004407360000+MV003858540000+MV004446060000+MV003879820000+MV002559490000+MV003773570000+MV004441100000+MV004613680000+MV004141460000+MV003998430000+MV002134860000+MV001563440000+MV004058160000+MV003858680000+MV004357300000+MV003819940000+MV000000430000+MV000426860000+MV003707210000+MV002467390000+MV003878200000+MV001728630000+MV004084190000+MV004267570000+MV004121440000+MV004440640000+MV004440640000+MV000343000000+EP011750960028+EP010092340369+MV003515170000+EP004249980104+EP006335350041+EP018932320095+SH017397650000+MV001760450000+EP012647370090+EP018932320085+MV001622730000+EP019059960036+EP018932320112+MV001575970000+MV003497450000+MV000828300000+EP009556790045+EP015864390001+EP013701810032+EP019059960037+MV001621000000+EP013602140072+MV000182330000+MV001479960000+MV003408300000+EP010323830016+EP006747690039+EP012647370092+MV005430450000+MV002273060000+EP009488470456+MV003421450000+EP019059960038+EP017516880025+EP013602140073+MV001321260000+EP010939580001+MV002000690000+EP010939580005+EP010939580007+EP019534220001+EP014194440092+MV002464230000+MV000365980000+MV001789080000+MV002084110000+EP010323830023+EP006747690040+EP012647370093+MV001476290000+EP014122490020+EP019633580001+MV005987500000+MV005987500000+EP014122490021+MV001140600000+EP014194440080+SH000193170000+EP013602140074+MV003487130000+EP017403750012+MV000000000000+MV000325310000+MV000025480000+EP010323830024+EP006747690041+EP012647370094+EP009556790092+MV003986860000+SH014784160000+SH006716110000+EP014122490038+EP013602140075+EP008466780060+MV000428760000+EP008884030023+EP008884030025+EP005086070023+EP005086070024)+AND+(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "sg-ipad/4.1.22"'

      line_to_not_count = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/media_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "da-web-tablet/4.1.22"'

      if Rf.buckets.dany_mobile_media_live == undefined
        previous_count =  0
      else
        previous_count = Rf.buckets.dany_mobile_media_live
      Rf.bucketer(line_to_test)

      assert.equal(Rf.buckets.dany_mobile_media_live, (previous_count+1))
      
      Rf.bucketer(line_to_not_count)
      assert.equal(Rf.buckets.dany_mobile_media_live, (previous_count+1))

    it "should determine the correct buckets for media and iphone", ->
      line_to_test = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/media_live/select/?q=((tmsid:(MV000592850000+MV001451930000+MV003387320000+MV003654150000+MV003752590000+MV000254520000+MV000427990000+MV002240100000+EP017516880020+MV003978370000+MV002186020000+MV000203700000+MV004006340000+MV003687200000+MV000113970000+MV001170260000+EP015864390003+MV000734400000+MV003685570000+MV001095540000+SH019194510000+MV001469830000+MV001419090000+MV005296590000+EP018636030070+MV005641360000+MV000054450000+MV001580630000+MV002465230000+MV001923770000+SH002191530000+EP015864390002+MV002139650000+MV003681120000+MV001412490000+MV002366380000+EP019059960013+EP018636030068+EP018636030069+MV004446040000+SH018636030000+MV002806070000+MV003471740000+MV005345110000+MV002464230000+EP003077660300+MV000890510000+MV001440540000+MV001491400000+EP019059960004+MV004507700000+MV001818990000+MV003796850000+MV003986850000+MV003619870000+SH019254500000+MV003457520000+MV001483120000+EP019059960005+SH015039910000+MV001556560000+MV001190790000+MV000317690000+MV003752340000+MV004219390000+MV004509820000+MV001584020000+EP017516880023+MV002527890000+MV005724360000+MV004597220000+MV003858640000+MV004781960000+MV004006300000+MV004407360000+MV003858540000+MV004446060000+MV003879820000+MV002559490000+MV003773570000+MV004441100000+MV004613680000+MV004141460000+MV003998430000+MV002134860000+MV001563440000+MV004058160000+MV003858680000+MV004357300000+MV003819940000+MV000000430000+MV000426860000+MV003707210000+MV002467390000+MV003878200000+MV001728630000+MV004084190000+MV004267570000+MV004121440000+MV004440640000+MV004440640000+MV000343000000+EP011750960028+EP010092340369+MV003515170000+EP004249980104+EP006335350041+EP018932320095+SH017397650000+MV001760450000+EP012647370090+EP018932320085+MV001622730000+EP019059960036+EP018932320112+MV001575970000+MV003497450000+MV000828300000+EP009556790045+EP015864390001+EP013701810032+EP019059960037+MV001621000000+EP013602140072+MV000182330000+MV001479960000+MV003408300000+EP010323830016+EP006747690039+EP012647370092+MV005430450000+MV002273060000+EP009488470456+MV003421450000+EP019059960038+EP017516880025+EP013602140073+MV001321260000+EP010939580001+MV002000690000+EP010939580005+EP010939580007+EP019534220001+EP014194440092+MV002464230000+MV000365980000+MV001789080000+MV002084110000+EP010323830023+EP006747690040+EP012647370093+MV001476290000+EP014122490020+EP019633580001+MV005987500000+MV005987500000+EP014122490021+MV001140600000+EP014194440080+SH000193170000+EP013602140074+MV003487130000+EP017403750012+MV000000000000+MV000325310000+MV000025480000+EP010323830024+EP006747690041+EP012647370094+EP009556790092+MV003986860000+SH014784160000+SH006716110000+EP014122490038+EP013602140075+EP008466780060+MV000428760000+EP008884030023+EP008884030025+EP005086070023+EP005086070024)+AND+(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "sg-ipad/4.1.22"'

      line_to_not_count = '69.31.28.238 0.003 [14/Nov/2014:00:00:03 -0700] 200 39758 "GET /solr/media_live/select/?q=(usid:(9489+184+17533+185+9429+186+9444+187+188+16343))&fq=(start_date_time:[*+TO+2014-11-18T04:00:00Z]+AND+end_date_time:[2014-11-18T00:00:00Z+TO+*])&fl=start_date_time,end_date_time,usid,schedule_id,program_id,program_title,episode_id,episode_theme,is_hd,is_new,egid,episode_description,program_image,callsign,tv_rating,mpaa_rating,channel_image,duration,channel_padded,season_num,episode_num,tms_series_id,mv_tmsid,episode_title,upid&sort=start_date_time+asc&wt=json&rows=1000 HTTP/1.1" "gzip" "gzip" "da-web-tablet/4.1.22"'

      if Rf.buckets.dany_mobile_media_live == undefined
        previous_count =  0
      else
        previous_count = Rf.buckets.dany_mobile_media_live

      Rf.bucketer(line_to_test)
      assert.equal(Rf.buckets.dany_mobile_media_live, (previous_count+1))
      
      Rf.bucketer(line_to_not_count)
      assert.equal(Rf.buckets.dany_mobile_media_live, (previous_count+1))
