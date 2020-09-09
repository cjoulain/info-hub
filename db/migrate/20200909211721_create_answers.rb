class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'

    create_table :answers, id: :uuid do |t|
      t.string :body
      t.uuid :question_id
      t.timestamps
    end

    add_index :answers, :question_id
  end
end
