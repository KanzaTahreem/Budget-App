require 'rails_helper'

RSpec.describe 'Splash Page', type: :system do
  describe 'Splash /index' do
    before :each do
      # @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      # @icon_file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png')
      # @group = Group.create(name: 'stationary', icon: @icon_file, user_id: @user.id)
      # @expense = Expense.create(name: 'pen', amount: 10.2)
      # @user.skip_confirmation!
      # @user.save!
      # visit new_user_session_path
      # fill_in 'user_email', with: 'email@gmail.com'
      # fill_in 'user_password', with: 'password'
      # click_button 'Log in'
      # sleep(2)
      # visit group_expenses_path(group_id: @group.id, id: @expense.id)
      visit root_path
    end

    it 'displays the name of app' do
      expect(page).to have_content('PayMark')
    end

    it 'displays a button with text Log in' do
      expect(page).to have_content('LOG IN')
    end

    it 'button redirects to log in form' do
      click_link 'LOG IN'
      expect(page).to have_current_path new_user_session_path
    end

    it 'displays a button with text Log in' do
      expect(page).to have_content('SIGN UP')
    end

    it 'button redirects to log in form' do
      click_link 'SIGN UP'
      expect(page).to have_current_path new_user_registration_path
    end
  end
end
