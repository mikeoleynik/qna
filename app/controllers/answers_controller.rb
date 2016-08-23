class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :set_answer, only: [:update, :destroy, :best]

  respond_to :js

  def new
    @answer = Answer.new
  end

  def show    
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.js 
      else
        format.js 
      end
    end
  end

  def update      
    respond_with(@answer.update(answer_params))  
  end

  def destroy   
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def best
    @answer.set_best if current_user.author_of?(@answer.question)
    @answers = @answer.question.answers
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
      @question = @answer.question
    end

    def load_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:body, :best, attachments_attributes: [:file, :id, :_delete])
    end
end