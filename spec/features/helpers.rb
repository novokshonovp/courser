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

def fill_admin_form(rate, lag_in_seconds)
  fill_in('course_rate', :with => rate)
  fill_in('course_uptodate', :with => Time.now + lag_in_seconds.seconds)
  click_on('Submit')
end
