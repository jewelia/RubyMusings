#!/Users/jewelia/.rvm/rubies/ruby-1.9.3-p0/bin/ruby
require 'twitter'

#Fetches all the members of a publically available Twitter list, prints their Twitter URL and Webpage
#Uses the Twitter Ruby Gem available at http://twitter.rubyforge.org/
#I loosely based this on http://stackoverflow.com/questions/8297036/get-more-than-20-members-of-a-list-with-ruby-twitter-gem
#but found the code in that solution was inadequate.

listmembers = Twitter.list_members(TWITTER_USERNAME,LIST_NAME)
#List has < 20 members
if (listmembers.next_cursor == 0)
  listmembers.users.each do |lmname|
   #nil check
   if (lmname.to_s != '' && lmname.screen_name.to_s != '' && lmname.url.to_s != '')
    p 'http://twitter.com/'+lmname.screen_name+','+lmname.url
   end
  end
else
 #List has > 20 members, so move the cursor every time we fetch a list 
 while (listmembers.next_cursor != 0)
  listmembers.users.each do |lmname| 
   #nil check 
   if (lmname.to_s != '' && lmname.screen_name.to_s != '' && lmname.url.to_s != '')
     p 'http://twitter.com/'+lmname.screen_name+','+lmname.url
    end
   end
  pagevalue = listmembers.next_cursor
  listmembers = Twitter.list_members(TWITTER_USERNAME, LIST_NAME, :cursor => pagevalue)
  if (listmembers.next_cursor == 0)
    listmembers.users.each do |lmname|
     #nil check
     if (lmname.to_s != '' && lmname.screen_name.to_s != '' && lmname.url.to_s != '')
      p 'http://twitter.com/'+lmname.screen_name+','+lmname.url
     end
   end
  end
 end
end
