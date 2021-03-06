class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer, only: [:show]
  before_action :set_subscription, only: [:show]
  after_action :publish_question, only: [:create]

  respond_to :json, :js

  authorize_resource
  
  def index
    respond_with (@questions = Question.all)
  end

  def show    
    respond_with @question 
  end

  def new
    respond_with(@question = Question.new) 
  end

  def edit    
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    respond_with(@question.update(question_params))
  end

  def destroy
    respond_with(@question.destroy)
  end

  private
    def load_question
      @question = Question.find(params[:id])
    end

    def build_answer
      @answer = @question.answers.build
    end

    def set_subscription
      @subscription = @question.subscriptions.find_by(user: current_user)
    end

    def publish_question
      PrivatePub.publish_to('/questions', question: @question.to_json) if @question.valid?
    end

    def question_params
      params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_delete])
    end
end