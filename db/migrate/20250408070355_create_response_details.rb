class CreateResponseDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :response_details do |t|
      t.references :response, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.integer :score, null: false

      t.timestamps
    end
  end
end
