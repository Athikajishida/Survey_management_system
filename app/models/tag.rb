# @file app/models/tag.rb
# @description Represents tags used to group or filter survey questions. 
# Tags are associated with questions via the join model QuestionTag.
# @version 1.0.0
# @author
#   - Athika Jishida
class Tag < ApplicationRecord
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags
  
  validates :name, presence: true, uniqueness: true
end
