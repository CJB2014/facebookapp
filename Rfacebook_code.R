library(Rfacebook)
library(httr)

setwd('C://Users//Clemence.Burnichon//Documents//code_repo//facebookapp')

#app_id  = 
#app_secret = 

#create a connection to a facebook app created from a facebook dev account 
auth <- fbOAuth(app_id, app_secret  ) 
save(auth, file = 'auth')
load('auth')

# SEARCH page with specific string in its name -- here airlines

search_page_with_string <- searchPages('airlines', token = auth , n = 100)


#get reaction and share and feed from a specific page using page name or page id -- here 273795515772 = KLM
get_page_with_string <- getPage(273795515772, token = auth, feed = T,reactions = T)


#get info on 1 particular post with id -- here KLM post from previous data frame 
get_info_on_post <- getPost(get_page_with_string[1,1],token = auth) 


#get shares info for a specific post -- here for buzzfeed post with a lot of shares -- only for public sharing might not work
buzzfeed <- getPage('BuzzFeed', token = auth, feed = T, reactions = T)
share_info <- getShares('21898300328_10155268300130329', token = auth)



