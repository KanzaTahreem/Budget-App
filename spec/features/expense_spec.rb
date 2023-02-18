require 'rails_helper'

RSpec.describe 'Expenses Page', type: :system do
  describe 'Expenses /index' do
    before :each do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @icon_file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png')
      @group = Group.create(name: 'stationary', icon: @icon_file, user_id: @user.id)
      @expense = Expense.create(name: 'pen', amount: 10.2)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(2)
      visit group_expenses_path(group_id: @group.id, id: @expense.id)
    end

    it 'displays the name of group' do
      expect(page).to have_content(@group.name)
    end

    it 'displays the name of expense' do
      expect(page).to have_content(@expense.name)
    end

    it 'displays the title of the page' do
      expect(page).to have_content('EXPENSES')
    end

    it 'displays a button with text Add new expense' do
      expect(page).to have_content('Add new expense')
    end

    it 'button redirects to a page to add new expense' do
      click_link 'Add new expense'
      expect(page).to have_current_path new_group_expense_path(group_id: @group.id, id: @expense.id)
    end
  end
end
