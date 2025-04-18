class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true
      t.string :text, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
