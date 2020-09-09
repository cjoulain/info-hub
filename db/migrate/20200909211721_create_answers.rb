class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'

    create_table :answers, id: :uuid do |t|
      t.string :body

      t.timestamps
    end
  end
end
