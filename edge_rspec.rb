require 'selenium-webdriver'
require "rspec"

# Edgeドライバーパスを指定
Selenium::WebDriver::Edge::Service.driver_path = 'msedgedriver.exe'
# 起動時のページURL指定
url= "https://www.google.com/"

# 検索文字列
query = "test"
# 検索結果ページタイトル
page_title = "test - Google 検索"

# describe(テスト概要)
describe "edge_test" do

  # テスト事前処理
  before(:each) do
    # ブラウザ起動(describeクラス内で使うため、インスタンス変数として定義)
    @driver = setting_driver()
	# 暗黙的待機時間の設定
	@driver.manage.timeouts.implicit_wait = 5
  end
  
  # テスト事後処理
  after(:each) do
    # ブラウザ終了
    @driver.quit  
  end

  # テスト対象処理
  it "google_search" do
  
	# Googleホームページを開く  
    @driver.get(url)

	# 検索欄にキーワードを入力して検索実行
	el = @driver.find_element(:name, "q")
	el.send_keys query
	el.send_keys(:enter)
	
	# 明示的待機時間の設定
	wait = Selenium::WebDriver::Wait.new(:timeout => 10)
	# 検索結果ページタイトルが表示されるまで待機
	wait.until {@driver.title == page_title}
	
	# 検索結果トップに現れる文字列を取得
	el = @driver.find_element(:id, "tw-source-text-ta")
	wait.until {el.displayed?}
	res = el.attribute("value").to_s
	
	# 文字列が「test」かを検証
	expect(res).to eq query
	#expect(res).to eq "test_error"
	
  end

  # Edgeドライバー設定
  def setting_driver()
    # ブラウザ動作のオプションを定義
    options = Selenium::WebDriver::Edge::Options.new
	#options.add_argument('--headless')
	options.add_argument('--inprivate')
	options.add_argument('--lang=ja')
	options.add_argument('--window-size=1000,1000')

	# ブラウザ起動
	Selenium::WebDriver.for :edge, capabilities: options
  end
  
end