library(Rfacebook)
library(httr)

setwd('C://Users//Clemence.Burnichon//Documents//code_repo//facebookapp')

#app_id  = 
#app_secret = 


auth <- fbOAuth(app_id, app_secret  ) #, extended_permissions = T, legacy_permissions = T)
save(auth, file = 'auth')
load('auth')

# get page with specific word in it -- here cardianls -- 
page <- searchPages('cardinals', token = auth,n = 100)
