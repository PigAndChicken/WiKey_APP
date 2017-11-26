require_relative 'spec_helper'

describe 'Homepage' do
  before do
    unless @browser
#      caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"binary" => "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"})
#      Selenium::WebDriver.for :chrome, desired_capabilities: caps
      @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end
  
  after do
    @browser.close
    @headless.destroy
  end
  
  describe 'Empty Homepage' do
    it '(Happy) should see welcome message' do
      @browser.goto homepage
      
      # user should see basic headers, no topics and summarized contents
      _(@browser.h1(id: 'main_header').text).must_equal 'WiKey'
      _(@browser.h3(id: 'subtitle').text).must_equal 'Welcome'
      _(@browser.p(id: 'introduction').text).must_include "WiKey is a simple tool for summarize contents of wikipedia"
      _(@browser.text_field(id: 'topic_input').visible?).must_equal true
      _(@browser.button(id: 'topic-form-submit').visible?).must_equal true
      _(@browser.p(id: 'summary').exists?).must_equal false
    end
  end
  
  describe 'Search a topic of wikipedia' do
    it '(HAPPY) should input a valid wiki topic' do
      # GIVEN: user is on the home page
      @browser.goto browser
      
      # WHEN: user enters a valid topic
      @browser.text_field(id: 'topic_input').set('gogoro')
      @browser.button(id: 'topic-form-submit').click
      
      # THEN: user should see outlines and summarized contents of the topic
      _(@browser.div(id: 'list_title').text).must_equal 'Outline'
      _(@browser.div(id: 'outline').exists?).must_equal true
      @browser.link(text: 'Products').click
      _(@browser.p(id: 'summary').exists?).must_equal true
      _(@browser.p(id: 'summary').text).must_include 'Gogoro Smartscooter'
    end
    
    it '(BAD) The input topic not exists' do
      # GIVEN: user is on the home page
      @browser.goto homepage
      
      # WHEN: user enters an invalid topic
      @browser.text_field(id: 'topic_input').set('hsdifhd')
      @browser.button(id: 'topic-form-submit').click
      
      # THEN: user should see an error alert and no contents show
      _(@browser.div(id: 'flash_bar_danger').text).must_include 'Not exists'
      _(@browser.p(id: 'summary').exists?).must_equal false
    end
  end
end
