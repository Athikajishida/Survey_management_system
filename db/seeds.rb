# db/seeds.rb
# Create users
user1 = User.create!(email: 'employee1@example.com')
user2 = User.create!(email: 'employee2@example.com')
user3 = User.create!(email: 'employee3@example.com')

# Create survey
survey = Survey.create!(
  title: 'Employee Satisfaction Survey',
  description: 'Annual survey to measure employee satisfaction across departments',
  active: true
)

# Create categories
work_env = survey.categories.create!(name: 'Work Environment', description: 'Questions about office facilities')
leadership = survey.categories.create!(name: 'Management & Leadership', description: 'Questions about team leadership')
communication = survey.categories.create!(name: 'Communication', description: 'Questions about team communication')
career = survey.categories.create!(name: 'Career Development', description: 'Questions about growth opportunities')
compensation = survey.categories.create!(name: 'Compensation & Benefits', description: 'Questions about pay and benefits')

# Create questions and answers for Work Environment
q1 = work_env.questions.create!(text: 'How satisfied are you with the office facilities?', question_type: 'rating', position: 1)
q1.answers.create!([
  { text: 'Not At All', score: 1 },
  { text: 'Slightly', score: 2 },
  { text: 'Somewhat', score: 3 },
  { text: 'Mostly', score: 4 },
  { text: 'Completely', score: 5 }
])

q2 = work_env.questions.create!(text: 'Do you have all the necessary equipment to perform your job effectively?', question_type: 'rating', position: 2)
q2.answers.create!([
  { text: 'Not At All', score: 1 },
  { text: 'Slightly', score: 2 },
  { text: 'Somewhat', score: 3 },
  { text: 'Mostly', score: 4 },
  { text: 'Completely', score: 5 }
])

# Create questions and answers for Leadership
q3 = leadership.questions.create!(text: 'My manager provides clear directions and leadership', question_type: 'rating', position: 1)
q3.answers.create!([
  { text: 'Not At All', score: 1 },
  { text: 'Slightly', score: 2 },
  { text: 'Somewhat', score: 3 },
  { text: 'Mostly', score: 4 },
  { text: 'Completely', score: 5 }
])

# Create questions and answers for Communication
q4 = communication.questions.create!(text: 'Information is shared openly within the organization', question_type: 'rating', position: 1)
q4.answers.create!([
  { text: 'Not At All', score: 1 },
  { text: 'Slightly', score: 2 },
  { text: 'Somewhat', score: 3 },
  { text: 'Mostly', score: 4 },
  { text: 'Completely', score: 5 }
])

# Create questions and answers for Career Development
q5 = career.questions.create!(text: 'I have opportunities to grow professionally', question_type: 'rating', position: 1)
q5.answers.create!([
  { text: 'Not At All', score: 1 },
  { text: 'Slightly', score: 2 },
  { text: 'Somewhat', score: 3 },
  { text: 'Mostly', score: 4 },
  { text: 'Completely', score: 5 }
])

# Create questions and answers for Compensation
q6 = compensation.questions.create!(text: 'I am satisfied with my compensation package', question_type: 'rating', position: 1)
q6.answers.create!([
  { text: 'Not At All', score: 1 },
  { text: 'Slightly', score: 2 },
  { text: 'Somewhat', score: 3 },
  { text: 'Mostly', score: 4 },
  { text: 'Completely', score: 5 }
])

# Create some tags
engagement = Tag.create!(name: 'engagement')
wellbeing = Tag.create!(name: 'wellbeing')
communication_tag = Tag.create!(name: 'communication')

# Assign tags to questions
QuestionTag.create!(question: q1, tag: wellbeing)
QuestionTag.create!(question: q2, tag: wellbeing)
QuestionTag.create!(question: q3, tag: engagement)
QuestionTag.create!(question: q4, tag: communication_tag)
QuestionTag.create!(question: q5, tag: engagement)
QuestionTag.create!(question: q6, tag: wellbeing)

puts "Seed data created successfully!"