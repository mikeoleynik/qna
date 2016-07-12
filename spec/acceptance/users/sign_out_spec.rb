require 'rails_helper'

feature 'User sign out', %q{
  In order to be not able to ask question
  As an User
  I want to be able to sign out
} do 

  let(:user) { create(:user) }

  scenario 'Registered user try to sign out' do
    sign_in(user)
    click_on 'Выход'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

end