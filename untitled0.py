# -*- coding: utf-8 -*-
"""
Created on Sat Sep 24 12:31:53 2016

@author: clemenceburnichon
"""

import urllib 
import json
import datetime
import csv
import time

app_id = '1745326245707206'
app_secret = 'b7c19579b1047f980a0d49b72c767cf6'



access_token = app_id + "|" + app_secret

page_id = 'nytimes'

def testFacebookPageData(page_id, access_token):
    
    # construct the URL string
    base = "https://graph.facebook.com/v2.4"
    node = "/" + page_id
    parameters = "/?access_token=%s" % access_token
    url = base + node + parameters
    
    # retrieve data
    
    response = urllib.request.urlopen(url)
    data = json.loads(response.read())
    
    print (json.dumps(data, indent=4, sort_keys=True))
    

testFacebookPageData(page_id, access_token)


def request_until_succeed(url):
    req = urllib.request(url)
    success = False
    while success is False:
        try: 
            response = urllib.request.urlopen(req)
            if response.getcode() == 200:
                success = True
        except Exception, e:
            print e
            time.sleep(5)
            
            print ("Error for URL %s: %s" % (url, datetime.datetime.now()))

    return response.read()
    


def testFacebookPageFeedData(page_id, access_token):
    
    # construct the URL string
    base = "https://graph.facebook.com/v2.4"
    node = "/" + page_id + "/feed" # changed
    parameters = "/?access_token=%s" % access_token
    url = base + node + parameters
    
    # retrieve data
    data = json.loads(request_until_succeed(url))
    
    print json.dumps(data, indent=4, sort_keys=True)
    

testFacebookPageFeedData(page_id, access_token)


def scrapeFacebookPageFeedStatus(page_id, access_token):
    with open('%s_facebook_statuses.csv' % page_id, 'wb') as file:
        w = csv.writer(file)
        w.writerow(["status_id", "status_message", "link_name", "status_type", "status_link",
           "status_published", "num_likes", "num_comments", "num_shares"])
        
        has_next_page = True
        num_processed = 0   # keep a count on how many we've processed
        scrape_starttime = datetime.datetime.now()
        
        print( "Scraping %s Facebook Page: %s\n" % (page_id, scrape_starttime))
        
        statuses = getFacebookPageFeedData(page_id, access_token, 100)
        
        while has_next_page:
            for status in statuses['data']:
                w.writerow(processFacebookPageFeedStatus(status))
                
                # output progress occasionally to make sure code is not stalling
                num_processed += 1
                if num_processed % 1000 == 0:
                    print ("%s Statuses Processed: %s" % (num_processed, datetime.datetime.now()))
                    
            # if there is no next page, we're done.
            if 'paging' in statuses.keys():
                statuses = json.loads(request_until_succeed(statuses['paging']['next']))
            else:
                has_next_page = False
                
        
        print ("\nDone!\n%s Statuses Processed in %s" % (num_processed, datetime.datetime.now() - scrape_starttime))


scrapeFacebookPageFeedStatus(page_id, access_token)
