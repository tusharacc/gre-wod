class QuoteOfDay < ActiveRecord::Base
    require 'httparty'
    
    @url = 'http://quotes.rest/qod.json?category=inspire'
    
    
    def self.InsertQuote

        @quote_of_day_arr = QuoteOfDay.where('created_at > ?',DateTime.now - 1).to_a 
        if @quote_of_day_arr.count == 0
            response = HTTParty.get(@url)
            quote = response.parsed_response["contents"]["quotes"][0]["quote"]
            author = response.parsed_response["contents"]["quotes"][0]["author"]
            link = "https://theysaidso.com/"                   
            QuoteOfDay.create(quote: quote, author: author, link: link)
        end
    end

end
