require 'rails_helper'

describe CommentsController do

    let(:user)  { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question, user: user) }
    let!(:comment) { create(:comment, user: user) }


  describe "POST #create" do

    context "User can create comment" do

      login_user

      it "for question" do
        expect { post :create, question_id: question, comment: attributes_for(:comment), format: :js }.to change(question.comments, :count).by(1)
      end

      it "for answer" do
        expect { post :create, answer_id: answer, comment: attributes_for(:comment), format: :js }.to change(answer.comments, :count).by(1)
      end

      it "send OK to client from server" do
        post :create, question_id: question, comment: attributes_for(:comment), format: :js
        expect(response).to have_http_status(200)
      end
    end


    context "Unauthenticate user can not create comment" do

      it "try to write comment" do
        expect { post :create, question_id: question, comment: attributes_for(:comment), format: :js }.to_not change(Comment, :count)
      end

      it "send ERROR to client from server" do
        post :create, question_id: question, comment: attributes_for(:comment), format: :js
        expect(response).to have_http_status(401)
      end
    end
  end
end