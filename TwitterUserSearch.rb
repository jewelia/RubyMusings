#!/Users/jewelia/.rvm/rubies/ruby-1.9.3-p0/bin/ruby
require 'twitter'

#Fetches all the Twitter users with the search criteria (fetching the max of 20 per API call), 
#then makes subsequent API calls to fetch more results. Prints user's Twitter URL, webpage & description.
#Uses the Twitter Ruby Gem available at http://twitter.rubyforge.org/

Twitter.configure do |config|
  config.consumer_key = YOUR_CONSUMER_KEY
  config.consumer_secret = YOUR_CONSUMER_SECRET
  config.oauth_token = YOUR_OAUTH_TOKEN
  config.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
end

pagevalue = 0;
#number of time to execute your search; if numberofqueries = 5 then you'll get back 20*5=100 results
numberofqueries = 5
begin 
 listmembers = Twitter.user_search(SEARCH_TERM), :page => pagevalue)
 listmembers.each do |lmname|
  #nil check
   if (lmname.to_s != '' && lmname.screen_name.to_s != '' && lmname.url.to_s != '')
    #can't use a comma as a delimiter b/c users have commas in their description
    p 'http://twitter.com/'+lmname.screen_name+'&&&'+lmname.url+'&&&'+lmname.description
   end
  end
  pagevalue = pagevalue + 1
end while (pagevalue < numberofqueries)
