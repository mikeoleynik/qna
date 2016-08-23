require_relative 'acceptance_helper'

  feature 'Add comment to answer' do

    let!(:user) {create(:user)}
    let!(:question) {create(:question, user: user)}
    let!(:answer) {create(:answer, question: question, user: user)}

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario "User can add comment to answer", js: true do
      within ".answers" do
        click_on "коммент"
        fill_in "Комментарий", with: "qwerty"
        click_on 'Create'
        
        expect(page).to have_content "qwerty"
      end
    end
  end