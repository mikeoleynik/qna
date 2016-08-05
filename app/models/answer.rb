class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :attachments, as: :attachable

  validates :body, :question_id, :user_id, presence: true

  accepts_nested_attributes_for :attachments
  
  default_scope { order(best: :desc) }

  def set_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
