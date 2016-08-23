class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  

  respond_to :json, :js
  
  def index
    respond_with (@questions = Question.all)
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
    respond_with @question 
  end

  def new
    @question = Question.new
    @question.attachments.build
    respond_with @question 
  end

  def edit    
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    
    if @question.save
      PrivatePub.publish_to '/questions', question: @question.to_json
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
      respond_with @question
    end   
  end

  def destroy
    if @question.user_id == current_user.id
      respond_with(@question.destroy)
    end
  end

  private
    def load_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_delete])
    end
end