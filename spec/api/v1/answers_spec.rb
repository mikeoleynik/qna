require 'rails_helper'

describe 'Answers API' do
  describe 'GET /index' do
    it_behaves_like "API Authenticable"

    context "authorized" do
      let(:access_token) { create(:access_token) }
      let(:user) { create(:user) }
      let(:question) { create(:question, user: user) }
      let!(:answers) { create_list(:answer, 2, question: question, user: user) }
      let(:answer) { answers.first }

      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'return 200 status code' do
        expect(response).to be_success
      end

      it 'return list of answers' do
        expect(response.body).to have_json_size(2).at_path("answers")
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer include #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}/answers", { format: :json }.merge(options)
    end
  end

  describe 'GET /show' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }

    context 'unauthorized' do
      it "return 401 status if token empty" do
        get "/api/v1/answers/#{answer.id}", format: :json
        expect(response.status).to eq 401
      end

      it "return 401 status if token wrong" do
        get "/api/v1/answers/#{answer.id}", format: :json, access_token: '12345678'
        expect(response.status).to eq 401
      end
    end

    context "authorized" do
      let!(:access_token) { create(:access_token) }
      let!(:comments) { create_list(:comment, 2, commentable: answer, user: user) }
      let!(:comment) { comments.last }
      let!(:attachments) { create_list(:attachment, 2, attachable: answer) }
      let!(:attachment) { attachments.last }

      before { get "/api/v1/questions/#{question.id}/answers/", format: :json, access_token: access_token.token }

      it "returns 200 status code" do
        expect(response).to be_success
      end

      %w(id body created_at updated_at body).each do |attr|
        it "answer contain #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      context "comments" do
        it "included in answer" do
          expect(response.body).to have_json_size(2).at_path("answer/comments")
        end

        %w(id comment_body created_at updated_at).each do |attr|
          it "contain #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("answer/comments/0/#{attr}")
          end
        end
      end

      context "attachments" do
        it "included in answer" do
          expect(response.body).to have_json_size(2).at_path("answer/attachments")
        end

        it "contain url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("answer/attachments/0/url")
        end
      end
    end
  end

  describe 'POST /create' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create(:access_token, resource_owner_id: user.id) }

      context 'with valid attributes' do

        let(:request) do
          post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), format: :json, access_token: access_token.token
        end
        
        it 'returns 201 status code' do
          request
          expect(response).to be_success
        end

        it 'creates new answer for user' do
          expect { request }.to change(user.answers, :count).by(1)
        end

        it 'creates new answer for question' do
          expect { request }.to change(question.answers, :count).by(1)
        end
      end

      context 'with invalid attributes' do

        let(:request) do
          post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:invalid_answer), format: :json, access_token: access_token.token
        end
        
        it 'returns 422 status code' do
          request
          expect(response.status).to eq 422
        end

        it 'does not save the answer in the database' do
          expect { request }.to_not change(Answer, :count)
        end
      end
    end

    def do_request(options = {})
      post "/api/v1/questions/#{question.id}/answers", { format: :json }.merge(options)
    end  
  end
end