class Answer < ApplicationRecord
  belongs_to :question

  default_scope { order(created_at: :asc) }

  validates :body, presence: true
end
