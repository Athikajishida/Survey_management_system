class CreateSurveys < ActiveRecord::Migration[8.0]
  def change
    create_table :surveys do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :active, default: true, null: false
      t.integer :version, default: 1
      t.boolean :is_template, default: false

      t.timestamps
    end
  end
end
