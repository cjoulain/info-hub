class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'

    create_table :questions, id: :uuid do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
