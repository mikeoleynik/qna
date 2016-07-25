require_relative 'acceptance_helper'

feature 'Edit answer', %q{
 In order to fix mistake
 As an author an answer
 I'd like to be able to edit my answer
} do

  let(:user) {create(:user)}
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question, user: user) }
  
  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать'
  end
  
  describe 'Authenticated user...' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees link to edit' do
      within ".answers" do
        expect(page).to have_link 'Редактировать'
      end
    end
    
    scenario 'try to edit his answer', js: true do
      click_on 'Редактировать'
      within ".answers" do
        fill_in 'Ответ', with: 'Ответуля'
        click_on 'Сохранить'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Ответуля'
        expect(page).to_not have_selector 'textarea'
      end

    end

    scenario 'try to edit alien answer'
  end

end