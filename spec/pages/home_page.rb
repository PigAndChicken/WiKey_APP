class HomePage
  include PageObject

  page_url WiKey::App.config.APP_URL

  # Homepage elements
  h1(:main_header, id: 'main_header')
  h3(:welcome, id: 'welcome')
  p(:introduction, id: 'introduction')
  div(:flash_bar_notice, id: 'flash_bar_info') # "Let's enter a topic to try"
  div(:flash_bar_error, id: 'flash_bar_danger') # "Not exists in Wikipedia"

  # Search_topic
  text_field(:topic_input, id: 'topic_input')
  button(:search_button, id: 'topic_submit')
  # result page
  h3(:subtitle, id: 'subtitle')
  p(:summary, id: 'summary')
  div(:list_title, id: 'list_title')
  section(:list, id: 'list')
  div(:outline, id: 'outline')

  # features
  def search_topic(topic_name)
    self.topic_input = topic_name
    search_button
  end

  def outline_numbers
    outline.split(' ').length # [c1,c2,c3...].length
  end
end
