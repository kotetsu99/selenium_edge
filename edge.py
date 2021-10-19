from msedge.selenium_tools import Edge, EdgeOptions
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

WEB_DRIVER = 'msedgedriver.exe'
query = 'test'

options = EdgeOptions()
options.use_chromium = True
#options.add_argument('--headless')
options.add_argument('--inprivate')
options.add_argument('--lang=ja')
options.add_argument('--window-size=1000,1000')

# ブラウザ起動
driver = Edge(executable_path=WEB_DRIVER, options=options)
driver.get('https://google.com')

element = driver.find_element(By.NAME, "q")
element.send_keys(query) 
element.send_keys(Keys.ENTER) 

driver.quit()