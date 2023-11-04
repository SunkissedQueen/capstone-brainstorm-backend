# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# users
user1 = User.where(email: 'dilemma1@example.com').first_or_create(username: 'User1', password: 'password1', password_confirmation: 'password1')
user2 = User.where(email: 'dilemma2@example.com').first_or_create(username: 'User2', password: 'password2', password_confirmation: 'password2')

# blockers
blocker1 = Blocker.create(
  category: 'holiday',
  blocker_description: 'Should I bring a new dish to the holiday dinner?',
  resolved: true,
  urgent: true
)
blocker2 = Blocker.create(
  category: 'clothing',
  blocker_description: 'My favorite outfit is white, and it is after Labor Day. What should I do?',
  resolved: true,
  urgent: true
)  
blocker3 = Blocker.create!(
  category: 'education',
  blocker_description: 'I am not sure where to go to learn about coding. Do you have any suggestions?',
  resolved: false,
  urgent: true
)

# solutions
solution1 = user1.solutions.create(
  blocker: blocker1,
  description: 'Holidays are valuable moments. Bring your best not your test.',
  require_followup: false,
  attempted: true,
  acceptable: true
)
solution2 = user2.solutions.create(
  blocker: blocker2,
  description: "It's your prerogative. Wear your closet accesories however you wish.",
  require_followup: false,
  attempted: true,
  acceptable: true
)
solution3 = user2.solutions.create(
  blocker: blocker3,
  description: 'That is such an important decision. I am grateful that I chose LEARN Academy. It is more than just coding over there; it is a community of collaboration and creativity.',
  require_followup: false,
  attempted: true,
  acceptable: true
)

# printing to console
p "user1 solutions", user1.solutions
p "user2 solutions", user2.solutions
p "user1 blockers", user1.blockers
p "user2 blockers", user2.blockers
p "blocker1 solutions", blocker1.solutions
p "blocker2 solutions", blocker2.solutions
p "blocker3 solutions", blocker3.solutions
p "blocker1 users", blocker1.users
p "blocker2 users", blocker2.users
p "blocker3 users", blocker3.users