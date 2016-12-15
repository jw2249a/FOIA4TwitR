# begin with a big thank you to dawran liou for posting about selenium
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options

options = webdriver.ChromeOptions()
options.add_argument("user-data-dir=C:/Users/jw224/AppData/Local/Google/Chrome/User Data") #Path to your chrome profile
browser = webdriver.Chrome(executable_path="/Users/jw224/Documents/GitHub/TwitRsucks/TwitRsucks/drivers/chromedriver.exe", chrome_options=options)

base_url = u'https://twitter.com/realDonaldTrump' # Test this code on our Good ol' pres-elect
query = u'' # 4 l8ter
url = base_url + query

browser.get(url)
time.sleep(1)
body = browser.find_element_by_tag_name('body')


for _ in range(500):
    body.send_keys(Keys.PAGE_DOWN)
    time.sleep(0.2)

tweets = browser.find_elements_by_class_name('tweet-text')

for tweet in tweets:
    print(tweet.text.encode("utf-8"))
