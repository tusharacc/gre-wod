class WordOfDay < ActiveRecord::Base
    require 'nokogiri'
    require 'open-uri'
    
    attr_reader :word_array,:word_of_day_text, :word_of_day_meaning,:word_of_day_part_of_speech,:word_of_day_pronounciation,:word_of_day_usage_quote,:word_of_day_usage_by
    def fetch_wod
        wod = WordOfDay.where('site = ? and created_at > ? ','easy-speak.org',DateTime.now-1).to_a
        if wod.count == 0
            doc = Nokogiri::HTML(open("http://easy-speak.org/portal.php?page=9"))
            word_of_day_obj = doc.css('.wotd')
            @word_of_day_text = word_of_day_obj.text
            @word_of_day_meaning = doc.css('.wotdbody').text
            @word_of_day_part_of_speech = doc.css('.gen').text.scan(/\s(.*)/)[-1][0].scan(/\((.*)\)\s(.*)/)[0][0]
            @word_of_day_pronounciation = doc.css('.gen').text.scan(/\s(.*)/)[-1][0].scan(/\((.*)\)\s(.*)/)[0][1]
            @word_of_day_usage_quote = doc.css('.quote')[0].text.scan(/(.*)[\r\n\n]+(.*)/)[0][0]
            @word_of_day_usage_by = doc.css('.quote')[0].text.scan(/(.*)[\r\n\n]+(.*)/)[0][1] 
            if WordOfDay.where('word = ? and site = ?',@word_of_day_text,'easy-speak.org').pluck(:word).to_a[0] == @word_of_day_text
                #logger.debug
            else
                WordOfDay.create(word: @word_of_day_text,part_of_speech: @word_of_day_part_of_speech,meaning: @word_of_day_meaning,usage: @word_of_day_usage_quote,site: 'easy-speak.org',spoken_by: @word_of_day_usage_by, pronunciation: @word_of_day_pronounciation)
            end
        end
        # wod = WordOfDay.where('site = ? and created_at > ? ','oxforddictionaries.com',DateTime.now-1).to_a
        # if wod.count == 0
        #     temp = Nokogiri::HTML(open("https://en.oxforddictionaries.com/"))
        #     href = temp.css('.daywordmain').css('.callToAction')[0][:href]
        #     doc = Nokogiri::HTML(open("https://en.oxforddictionaries.com"+href))
        #     @word_of_day_text = doc.css('.pageTitle').text
        #     @word_of_day_meaning = doc.css('.definition').text
        #     @word_of_day_part_of_speech = doc.css('.partOfSpeechTitle').text
        #     @word_of_day_pronounciation = doc.css('.headpron').text.scan(/Pronunciation:\s(.*)\s.*/)[0][0]
        #     @word_of_day_usage_quote = doc.css('.sentence')[0].text
        #     @word_of_day_usage_by = "Oxford"
        #     if WordOfDay.where('word = ? and site = ?',@word_of_day_text,'oxforddictionaries.com').pluck(:word).to_a[0] == @word_of_day_text
        #         #logger.debug
        #     else
        #         WordOfDay.create(word: @word_of_day_text,part_of_speech: @word_of_day_part_of_speech,meaning: @word_of_day_meaning,usage: @word_of_day_usage_quote,site: 'oxforddictionaries.com',spoken_by: @word_of_day_usage_by,pronunciation: @word_of_day_pronounciation)
        #     end
        # end
        wod = WordOfDay.where('site = ? and created_at > ? ','wordthink.com',DateTime.now-1).to_a
        if wod.count == 0
             doc = Nokogiri::HTML(open("http://www.wordthink.com/"))
            @word_of_day_text = doc.css('p')[0].text.scan(/(.+)/)[0][0].scan(/(\S+)\s*(\S+)\s+(.+\.)\s(.+)/)[0][0]
            @word_of_day_meaning = doc.css('p')[0].text.scan(/(.+)/)[0][0].scan(/(\S+)\s*(\S+)\s+(.+\.)\s(.+)/)[0][2]
            @word_of_day_part_of_speech = doc.css('p')[0].text.scan(/(.+)/)[0][0].scan(/(\S+)\s*(\S+)\s+(.+\.)\s(.+)/)[0][1]
            @word_of_day_pronounciation = "Not Available"
            @word_of_day_usage_quote = doc.css('p')[0].text.scan(/(.+)/)[0][0].scan(/(\S+)\s*(\S+)\s+(.+\.)\s(.+)/)[0][3]
            @word_of_day_usage_by = "Not Available"
            if WordOfDay.where('word = ? and site = ?',@word_of_day_text,'wordthink.com').pluck(:word).to_a[0] == @word_of_day_text
                #logger.debug
            else
                WordOfDay.create(word: @word_of_day_text,part_of_speech: @word_of_day_part_of_speech,meaning: @word_of_day_meaning,usage: @word_of_day_usage_quote,site: 'wordthink.com',spoken_by: @word_of_day_usage_by,pronunciation: @word_of_day_pronounciation)
            end
        end
        wod = WordOfDay.where('site = ? and created_at > ? ','merriam-webster.com',DateTime.now-1).to_a
        if wod.count == 0
             doc = Nokogiri::HTML(open("https://www.merriam-webster.com/word-of-the-day"))
            @word_of_day_text = doc.css('.word-and-pronunciation').css('h1').text
            @word_of_day_meaning = doc.css('.wod-definition-container').css('p')[0].text
            @word_of_day_part_of_speech = doc.css('.main-attr').text
            @word_of_day_pronounciation = doc.css('.word-syllables').text
            @word_of_day_usage_quote = doc.css('.wod-definition-container').css('p')[1].text
            @word_of_day_usage_by = "Not Available"
            if WordOfDay.where('word = ? and site = ?',@word_of_day_text,'merriam-webster.com').pluck(:word).to_a[0] == @word_of_day_text
                #logger.debug
            else
                WordOfDay.create(word: @word_of_day_text,part_of_speech: @word_of_day_part_of_speech,meaning: @word_of_day_meaning,usage: @word_of_day_usage_quote,site: 'merriam-webster.com',spoken_by: @word_of_day_usage_by, pronunciation: @word_of_day_pronounciation)
            end
        end
        wod = WordOfDay.where('site = ? and created_at > ? ','wordsmith.org',DateTime.now-1).to_a
        if wod.count == 0
            doc = Nokogiri::HTML(open("https://wordsmith.org/words/today.html"))
            @word_of_day_text = doc.css('h3').text
            @word_of_day_meaning = doc.css('div')[9].text.scan(/\n([a-z]+):\s(.+)/)[0][1]
            @word_of_day_part_of_speech = doc.css('div')[9].text.scan(/\n([a-z]+):\s(.+)/)[0][0]
            @word_of_day_pronounciation = doc.css('div')[7].text
            @word_of_day_usage_quote = doc.css('div')[15].text.gsub(/\n/,' ').scan(/(.+);\s(.+);\s(.+)/)[0][0]
            @word_of_day_usage_by = doc.css('div')[15].text.gsub(/\n/,' ').scan(/(.+);\s(.+);\s(.+)/)[0][1]
            if WordOfDay.where('word = ? and site = ?',@word_of_day_text,'wordsmith.org').pluck(:word).to_a[0] == @word_of_day_text
                #logger.debug
            else
                WordOfDay.create(word: @word_of_day_text,part_of_speech: @word_of_day_part_of_speech,meaning: @word_of_day_meaning,usage: @word_of_day_usage_quote,site: 'wordsmith.org',spoken_by: @word_of_day_usage_by, pronunciation: @word_of_day_pronounciation)
            end
        end
        wod = WordOfDay.where('site = ? and created_at > ? ','dictionary.com',DateTime.now-1).to_a
        if wod.count == 0
            doc = Nokogiri::HTML(open("http://www.dictionary.com/wordoftheday/"))
            @word_of_day_text = doc.css('.definition-header').css('strong').text
            @word_of_day_meaning = doc.css('.first').text
            @word_of_day_part_of_speech = 'Not Available'
            @word_of_day_pronounciation = 'Not Available'
            @word_of_day_usage_quote = doc.css('blockquote')[0].css('span')[0].text
            @word_of_day_usage_by = doc.css('blockquote')[0].css('span')[1].text
            if WordOfDay.where('word = ? and site = ?',@word_of_day_text,'dictionary.com').pluck(:word).to_a[0] == @word_of_day_text
                #logger.debug
            else
                WordOfDay.create(word: @word_of_day_text,part_of_speech: @word_of_day_part_of_speech,meaning: @word_of_day_meaning,usage: @word_of_day_usage_quote,site: 'dictionary.com',spoken_by: @word_of_day_usage_by, pronunciation: @word_of_day_pronounciation)
            end
        end        
    end
end
