require 'capybara/rspec'
require 'rails_helper'
require "spec_helper"

feature 'New project can be created' do

    scenario 'Visit form to create new project' do  

      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)

      visit new_project_path 

      fill_in 'project_title', with: 'New Project'
      find('.form-control').set('app/views/layouts/Drawing.png')
      click_button 'Create Project'

      expect(page).to have_text 'New Project'
  end
end

feature 'Project can be updated' do

    scenario 'Visit form to updated project' do  

      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)

      visit new_project_path 

      fill_in 'project_title', with: 'New Project'
      find('.form-control').set('app/views/layouts/Drawing.png')
      click_button 'Create Project'

      click_link "Edit project"
      fill_in 'project_title', with: 'Updated Project'
      click_button 'Update Project'

      expect(page).to have_text 'Updated Project'
  end
end

feature 'Project can be deleted' do

    scenario 'Visit form to edit project' do  

      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)

      visit new_project_path 

      fill_in 'project_title', with: 'New Project'
      find('.form-control').set('app/views/layouts/Drawing.png')
      click_button 'Create Project'

      click_link "Delete project"

      expect(page).to have_text "Project successfully deleted." 
  end
end