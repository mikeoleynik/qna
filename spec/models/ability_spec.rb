require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for quest' do
    let(:user) { nil }

    it {should be_able_to :read, Question }
    it {should be_able_to :read, Answer }
    it {should be_able_to :read, Comment }

    it {should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it {should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:question) { create :question }

    it {should_not be_able_to :manage, :all }
    it {should be_able_to :read, :all }  

    context 'Question' do
      it {should be_able_to :create, Question }

      it {should be_able_to :update, create(:question, user: user), user: user }
      it {should_not be_able_to :update, create(:question, user: other), user: user }

      it { should be_able_to :destroy, create(:question, user: user), user: user }
      it { should_not be_able_to :destroy, create(:question, user: other), user: user }
    end

    context 'Answer' do
      it {should be_able_to :create, Answer }

      it {should be_able_to :update, create(:answer, question: question, user: user), user: user }
      it {should_not be_able_to :update, create(:answer, question: question, user: other), user: user }

      it { should be_able_to :destroy, create(:answer, question: question, user: user), user: user }
      it { should_not be_able_to :destroy, create(:answer, question: question, user: other), user: user }
    end        

    context 'Comment' do
      it {should be_able_to :create, Comment }
    end    

    context 'vote' do
      it { should be_able_to :unvote, Vote }
      it { should be_able_to :up, Vote }
      it { should be_able_to :down, Vote }
    end

    context "attachment" do
      let(:question) { create(:question, user: user) }
      let(:attachment) { create(:attachment, attachable: question) }

      let(:question_two) { create(:question, user: other) }
      let(:attach) { create(:attachment, attachable: question_two) }

      it { should be_able_to :manage, attachment,user: user  }
      it { should_not be_able_to :manage, attach, user: user }
    end

    context 'best' do
      let(:answer) { create :answer, question: question, user: user }
      
      it { should be_able_to :best, answer, user: user }
      it { should_not be_able_to :best, answer, user: user }
    end    
  end
end