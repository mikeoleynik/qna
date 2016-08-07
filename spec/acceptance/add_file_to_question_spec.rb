require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  let(:user){ create(:user) }
  let(:another_user){create(:user)}
  let!(:question){ create(:question) }

  before do
    sign_in(user)
    visit new_question_path
    fill_in 'Заголовок', with: 'Test question'
    fill_in 'Вопрос', with: 'text'
  end

  scenario 'User adds file when asks question', js: true do

    click_on "Добавить"
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on "Создать"

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
  end

  scenario 'Author can delete their attached files', js: true do
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"  
    click_on "Создать"
    expect(page).to have_content "удалить"

    within ".question" do
      click_on "удалить"
      expect(page).to_not have_content "spec_helper.rb"
    end
  end

  scenario 'Only author can destroy their files', js: true do
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"  
    click_on "Создать"
    expect(page).to have_content "удалить"

    click_on "Выход"
    
    sign_in(another_user)   
    visit question_path(question)
    
    within ".question" do
      expect(page).to_not have_content "удалить"
    end
  end
end