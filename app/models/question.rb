class Question < ApplicationRecord
  default_scope { order(created_at: :asc) }

  # has_many: answers

  validates :title, :body, presence: true 
end

