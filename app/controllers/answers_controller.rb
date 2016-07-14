class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]

  def new
    @answer = Answer.new
  end

  def show    
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    
    if @answer.save
      redirect_to  @answer.question
    else
      render :new
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to  @answer.question
    else
      flash[:notice] = 'No rights to delete'
      redirect_to root_url
    end
  end

  private
    def load_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:body)
    end
end