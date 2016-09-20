class Answer < ActiveRecord::Base
  include Attachable
  include Votable
  include Commentable
  
  belongs_to :user
  belongs_to :question, touch: true
  has_many :votes, as: :votable
  
  validates :body, :question_id, :user_id, presence: true

  after_create :notify_subscribers

  default_scope { order(best: :desc) }

  def set_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

  def notify_subscribers
    NotifySubscribersJob.perform_later(self)
  end
end
