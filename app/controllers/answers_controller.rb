class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :set_answer, only: [:update, :destroy, :best]

  def new
    @answer = Answer.new
  end

  def show    
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update      
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy   
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to  @answer.question
    else
      flash[:notice] = 'No rights to delete'
      redirect_to root_url
    end
  end

  def best
    if current_user.author_of?(@answer.question)
      @answer.best
      flash[:notice] = 'You choose best answer'
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def load_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:body)
    end
end