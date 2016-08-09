class Answer < ActiveRecord::Base
  include Attachable
  
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable
  
  validates :body, :question_id, :user_id, presence: true

  default_scope { order(best: :desc) }

  def set_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
