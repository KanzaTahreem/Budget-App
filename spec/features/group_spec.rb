require 'rails_helper'

RSpec.describe 'Groups Page', type: :system do
  describe 'Group /index' do
    before :each do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @icon_file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png')
      @group = Group.create(name: 'stationary', icon: @icon_file, user_id: @user.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(2)
      visit groups_path
    end

    it 'displays the name of group' do
      expect(page).to have_content(@group.name)
    end

    it 'displays the title of the page' do
      expect(page).to have_content('GROUPS')
    end

    it 'displays a button with text Add new group' do
      expect(page).to have_content('Add new group')
    end

    it 'button redirects to a page to add new recipe' do
      click_link 'Add new group'
      expect(page).to have_current_path new_group_path
    end

    it 'displays buttons with text Detail and Expense' do
      expect(page).to have_content('Detail')
      expect(page).to have_content('Expense')
    end
  end
end
