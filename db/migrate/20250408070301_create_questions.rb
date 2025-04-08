class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :category, null: false, foreign_key: true
      t.text :text, null: false
      t.string :question_type, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
