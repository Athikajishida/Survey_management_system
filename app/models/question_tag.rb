# @file app/models/question_tag.rb
# @description : Join model linking questions and tags.
# @version 1.0.0
# @author
#   - Athika Jishida
class QuestionTag < ApplicationRecord
  belongs_to :question
  belongs_to :tag
end
