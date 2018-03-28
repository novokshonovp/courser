# spec/features/helpers.rb
def in_browser(name)
  old_session = Capybara.session_name
  Capybara.session_name = name
  yield
  Capybara.session_name = old_session
end

def parse_rate
  find('#rate').text.split(':').last
end
