class CreateUserCategoryScores < ActiveRecord::Migration[8.0]
  def change
    create_table :user_category_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :total_score, null: false
      t.integer :max_score, null: false
      t.float :percentage

      t.timestamps
    end
    add_index :user_category_scores, [:user_id, :survey_id, :category_id], unique: true, name: 'index_user_category_scores_unique'

  end
end
