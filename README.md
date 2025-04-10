# 📝 Survey Management System

A scalable and dynamic Ruby on Rails application for handling surveys, collecting responses, and analyzing KPIs for leadership insights.

## 🔧 Tech Stack

- **Ruby**: 3.4.1 (+PRISM)
- **Rails**: 8.0.2
- **Database**: PostgreSQL
- **Testing**: RSpec
- **Authentication**: Devise (for user sessions)
- **Frontend**: HTML, CSS (basic layout)

---

## 📦 Features

### ✅ User Functionality
- Take surveys with multiple categories and questions
- Each answer stores a score based on the selected response
- Users can only participate once in each survey

### ⚙️ Admin Functionality
- Create, read, update, and delete surveys, questions, categories, tags
- View dynamic KPI dashboards for:
  - Average score per category
  - Employee engagement index
  - Performance distribution (e.g., Poor, Average, Good, Proficient)

### 📊 KPI Classification System
| Score Range     | Classification     |
|------------------|--------------------|
| 0 - 1.5          | Poor               |
| 1.5 - 3          | Average            |
| 3 - 4            | Good               |
| 4+               | Very Proficient    |

---

## 🗃️ Database Schema Highlights

- `users`: Authenticated users
- `surveys`, `categories`, `questions`, `answers`
- `responses`: User survey attempt
- `response_details`: Stores question-wise answers with scores
- `user_category_scores`: Precomputed category-wise KPIs per user
- `tags`, `question_tags`: For tagging questions (optional metadata)

![Untitled (1)](https://github.com/user-attachments/assets/7f9e4de1-2088-4ae1-ace9-b17342c7d80b)


---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/Athikajishida/survey_management_system.git
cd survey_management_system
# Survey Management System

## Installation Guide

### 1. Clone the Repository

```bash
git clone [repository-url]
cd [repository-name]
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Setup the Database

```bash
rails db:create
rails db:migrate
rails db:seed 
```

### 4. Run the Server

```bash
rails server
```

Then open your browser and navigate to: 📍 `http://localhost:3000`

## Running Tests 🧪

RSpec test cases are provided for core controller logic:

```bash
bundle exec rspec
```

## Features ✅

* Displaying only active surveys
* Ensuring one-time user participation
* Validating survey response logic and score storage

## Dynamic KPI Calculation 📐

The system supports:
* Real-time average score computation per category
* Automatic performance classification
* Adaptability to any number of categories/questions

## Future Implementation 🧠

* 📊 Visual dashboard using Chartkick or Recharts
* 📅 Trend analysis over time
* 🧪 A/B testing of survey structures
* ⚡ Resilient data structure for evolving survey formats

## Author ✍️

Developed by **[Athika Jishida ]** 🔗 [http://www.linkedin.com/in/athika-jishida-46242b12a]


