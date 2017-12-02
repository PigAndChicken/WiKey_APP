require_relative 'spec_helper'

describe 'Homepage' do
  include PageObject::PageFactory

  before do
    @browser ||= Watir::Browser.new
  end

  after do
    @browser.close
  end

  describe 'Empty Homepage' do
    it '(Happy) should see welcome message' do
      # GIVEN: on the homepage
      visit_page HomePage do |page|
        # THEN: appropriate elements should be visible
        _(page.main_header_element.exists?).must_equal true
        _(page.welcome_element.visible?).must_equal true
        _(page.introduction).include? 'wikipedia'
        _(page.flash_bar_notice).include? 'enter'
      end
    end
  end

  describe 'Search Topic' do
    it 'HAPPY: should get summarized contents of the wiki topic' do
      # GIVEN: on the homepage
      visit_page HomePage do |page|
        # WHEN: user enter a valid topic_name
        page.search_topic 'gogoro'

        # THEN: user should see basic headers, no topics and summarized contents
        _(page.subtitle).must_equal 'Gogoro'
        _(page.summary_element.exists?).must_equal true
        _(page.list_title).must_equal 'Outline'
        _(page.outline_numbers).must_equal 5
      end
    end

    it 'SAD: should go back tp homepage, and show an error_bar' do
      # GIVEN: on the homepage
      visit_page HomePage do |page|
        # WHEN: user enter a unvalid topic_name
        page.search_topic 'dhfdujhf'

        # THEN: user should go back to homepage, and get an error bar
        _(page.flash_bar_error_element.exists?).must_equal true
        _(page.main_header_element.exists?).must_equal true
        _(page.welcome_element.visible?).must_equal true
        _(page.introduction).include? 'wikipedia'
      end
    end
  end
end
