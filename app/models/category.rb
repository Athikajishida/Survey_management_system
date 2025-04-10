# @file app/models/category.rb
# @description Represents a section within a survey containing a group of questions.
# Supports user scoring through the user_category_scores association.
# @version 1.0.0
# @author
#   - Athika Jishida
class Category < ApplicationRecord
  belongs_to :survey
  has_many :questions, dependent: :destroy
  has_many :user_category_scores, dependent: :destroy
  
  validates :name, presence: true
end
