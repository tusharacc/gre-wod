class WordsController < ApplicationController
  def show
    wod = WordOfDay.new
    wod.fetch_wod
    
    @wod_array = []
    easy_speak_arr = WordOfDay.where('site = ?','easy-speak.org').order(created_at: :desc).limit(1).pluck(:word,:part_of_speech,:pronunciation,:meaning,:usage,:spoken_by)
    @wod_array.push(easy_speak_arr[0])
    oxford_arr = WordOfDay.where('site = ?','oxforddictionaries.com').order(created_at: :desc).limit(1).pluck(:word,:part_of_speech,:pronunciation,:meaning,:usage,:spoken_by)
    @wod_array.push(oxford_arr[0])
    wordthink_arr = WordOfDay.where('site = ?','wordthink.com').order(created_at: :desc).limit(1).pluck(:word,:part_of_speech,:pronunciation,:meaning,:usage,:spoken_by)
    @wod_array.push(wordthink_arr[0])
    merriam_arr = WordOfDay.where('site = ?','merriam-webster.com').order(created_at: :desc).limit(1).pluck(:word,:part_of_speech,:pronunciation,:meaning,:usage,:spoken_by)
    @wod_array.push(merriam_arr[0])
    wordsmith_arr = WordOfDay.where('site = ?','wordsmith.org').order(created_at: :desc).limit(1).pluck(:word,:part_of_speech,:pronunciation,:meaning,:usage,:spoken_by)
    @wod_array.push(wordsmith_arr[0])
    dictionary_arr = WordOfDay.where('site = ?','dictionary.com').order(created_at: :desc).limit(1).pluck(:word,:part_of_speech,:pronunciation,:meaning,:usage,:spoken_by)
    @wod_array.push(dictionary_arr[0])
    logger.debug "I am in controller #{@wod_array.to_s}"
    
    QuoteOfDay.InsertQuote
    @quote_of_day_arr = QuoteOfDay.order(created_at: :desc).limit(1).to_a
            
    # @wod = wod.word_array[0][0]
    # @pos = wod.word_array[0][1]
    # @pronounciation = wod.word_array[0][2]
    # @meaning = wod.word_array[0][3]
    # @quote = wod.word_array[0][4]
    # @by = wod.word_array[0][5]
    # @wod = wod.word_of_day_text
    # @meaning = wod.word_of_day_meaning
    # @pos = wod.word_of_day_part_of_speech
    # @pronounciation = wod.word_of_day_pronounciation
    # @quote = wod.word_of_day_usage_quote
    # @by = wod.word_of_day_usage_by
    
    logger.debug "Word of the day:  #{@quote_of_day_arr}"
  end
end
