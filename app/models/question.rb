class Question < ApplicationRecord
  has_many :answers

  default_scope { order(created_at: :asc) }

  validates :title, :body, presence: true 
end

