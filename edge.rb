require 'selenium-webdriver'

Selenium::WebDriver::Edge::Service.driver_path = 'msedgedriver.exe'
query = "test"

options = Selenium::WebDriver::Edge::Options.new
#options.add_argument('--headless')
options.add_argument('--inprivate')
options.add_argument('--lang=ja')
options.add_argument('--window-size=1000,1000')


driver = Selenium::WebDriver.for :edge, capabilities: options
driver.get("https://www.google.com/")
driver.find_element(:name, "q").send_keys query
driver.find_element(:name, "q").send_keys(:enter)
driver.quit