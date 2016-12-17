# begin with a big thank you to dawran liou for posting about selenium
import time
import csv
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options

options = webdriver.ChromeOptions()
options.add_argument("user-data-dir=C:/Users/jw224/AppData/Local/Google/Chrome/User Data") #Path to your chrome profile
browser = webdriver.Chrome(executable_path="/Users/jw224/Documents/GitHub/TwitRsucks/TwitRsucks/drivers/chromedriver.exe", chrome_options=options)

csvfile = open("congressSocial.csv", "rt", encoding ="utf-8")
congSoc = csv.reader(csvfile)
congTwit = []
for row in congSoc:
    congTwit.append(row[3])
csvfile.close()
x = 336
for _ in congTwit:
    x += 1
    base_url = u'https://twitter.com/'
    while congTwit[x] == "NA":
        x = x+1
    b = congTwit[x]
    query = congTwit[x]
    url = base_url + query

    browser.get(url)
    time.sleep(1)
    body = browser.find_element_by_tag_name('body')


    for _ in range(500):
        body.send_keys(Keys.PAGE_DOWN)
        time.sleep(0.25)

        tweets = browser.find_elements_by_class_name('tweet-text')
    a = "C:/Users/jw224/Documents/Github/TwitRsucks/TwitRsucks/Congress_Got_Tweets/"

    c = ".csv"
    with open("%s %s%s" % (a, b, c), 'w') as csvfile:
        fieldnames = ['number', 'quote']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        numman = 1
        for tweet in tweets:
            writer.writerow({'number': "%s" % numman, 'quote': "%s" % tweet.text.encode("utf-8")})
            numman += 1
    csvfile.close()
