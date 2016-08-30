require_relative 'acceptance_helper'

feature 'Sign in with Twitter' do
  before { visit new_user_session_path }

  scenario 'user can sign in with his Twitter account' do
    expect(page).to have_content('Sign in with Twitter')

    click_on 'Sign in with Twitter'
    mock_auth_hash(:twitter)
    OmniAuth.config.add_mock(:twitter, { info: { email: nil } })  

    expect(page).to have_content 'Пожалуйста введите свой e-mail'
    fill_in 'email', with: 'user_example@example.com'
    click_on 'Send'

    expect(page).to have_content I18n.t('devise.omniauth_callbacks.success', kind: 'Twitter')
    expect(current_path).to eq root_path
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Could not authenticate you from Twitter'
  end
end