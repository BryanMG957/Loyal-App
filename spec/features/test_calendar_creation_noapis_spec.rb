# require 'rails_helper'

# RSpec.feature "TestCalendarCreationNoapis", type: :feature do
#   let!(:calendar) do
#   	Calendar.create(
#   		name: "TestCalendar",
#   		apitype: "none"
#   	)
#   end
#   before(:all) do
#     Capybara.current_driver = :webkit
#   end
#   before do
#   	visit calendar_path(calendar)
# 	 	click_button 'Login'
#     fill_in "a0-signin_easy_email", :with => 'tester'
#     fill_in "a0-signin_easy_password", :with => 'LoyalTest123'
# 	  click_button 'Access'
#     visit calendar_path(calendar)
#   end
#   it "displays the calendar's name", js: true  do
#   	expect(page).to have_content calendar.name
#   end
#   it "displays their api type", js: true  do
#   	expect(page).to have_content calendar.apitype
#   end
# 	after(:all) do
# 	  Capybara.use_default_driver
# 	end
# end
