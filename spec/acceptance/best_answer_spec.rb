require_relative 'acceptance_helper'

feature 'Сhoose the best answer', %q{
  As user
  I want set best to one of answer
  In order to choose best answer
} do

  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let(:second_answer) { create(:answer, question: question, user: user) }

  describe 'auth user' do
    before do
      sign_in(user)
    end

    scenario 'sees link best answer' do
      visit question_path(question)

      expect(page).to have_link 'Лучший ответ'
    end

    scenario 'set best answer to his question', js: true do
      visit question_path(question)

      within '.answers' do
        click_on 'Лучший ответ'
      end

      expect(page).to have_content 'Этот ответ лучший'
    end
  end

  describe 'Non auth user' do

    scenario 'not set best answer' do
      visit question_path(question)

      expect(page).to_not have_link 'Лучший ответ'
    end
  end

end