require 'capybara/rspec'
require 'rails_helper'
require "spec_helper"

feature 'User can sign up and login' do

    scenario 'New user is created' do  

      visit new_user_registration_path

      def create_user
        fill_in "user_email",    with: "sameera@test.com"
        fill_in "user_name",    with: "sameera"
        fill_in "user_password", with: "123aaabbb"
        fill_in "user_password_confirmation",    with: "123aaabbb"
        click_button "Sign up"
      end

      create_user 

      expect(page).to have_css '.welcome', 'sameera'
  end

  scenario 'User can log into account' do  

      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)

      visit new_user_session_path
      
      expect(page).to have_css '.welcome', 'sameera'
  end

  scenario 'User can sign out of account' do  

      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)

      visit new_user_session_path

      click_link "Sign out"
      
      expect(page).to have_text "Signed out successfully."
  end

end

