class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers, id: :uuid do |t|
      t.string :body
      t.uuid :question_id
      t.timestamps
    end
  end
end
