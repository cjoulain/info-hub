class Question < ApplicationRecord
  has_many :answers, -> { order(created_at: :asc) }

  default_scope { order(created_at: :asc) }

  validates :title, :body, presence: true 
end

