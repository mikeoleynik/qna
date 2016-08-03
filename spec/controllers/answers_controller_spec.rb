require 'rails_helper'

describe AnswersController do
  login_user
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

  describe 'GET #new' do
    before { get :new, question_id: question.id }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      
      it 'save the new answer in the database' do
        expect { post :create, question_id: question.id, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
      end

      it 'created answer associated with logged user' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(@user.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question_id: question.id, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do

    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changed answer attributes' do
        patch :update, question_id: question, id: answer, answer: { body: 'new body' }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end   

      it 'redirect to the updated question' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :update
      end
    end
  end


  describe 'DELETE #destroy' do
    
    context 'Authenticated user' do
      let(:answer) { create(:answer, question: question, user: @user) }
      
      it 'delete his answer' do
        expect{ delete :destroy, id: answer, question_id: question.id, user: @user, format: :js }.to change(@user.answers, :count).by(-1)
      end

      it 'do not delete not alias answer' do
        expect{ delete :destroy, id: answer, question_id: question.id, format: :js }.to change(Answer, :count)
      end

      it 'redirect to question page' do
        delete :destroy, id: answer, question_id: question.id, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'Non-authenticated user' do
      it 'do not delete any answer' do
        expect{ delete :destroy, id: answer, question_id: question.id, format: :js }.to_not change(Answer, :count)
      end
    end
  end

  describe 'PATCH #best' do
    login_user
    
    context 'answer owner' do

      it 'assings the requested answer to @answer' do
        patch :best, id: answer, question_id: question.id, format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'render best template' do
        patch :best, id: answer, format: :js
        expect(response).to render_template :best
      end

      it 'set best value to true' do
        answer.reload
        expect(answer.best).to eq true
      end
    end
  end
end