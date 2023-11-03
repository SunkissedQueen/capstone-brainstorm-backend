# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# users
user1 = User.where(email: 'dilemma1@example.com').first_or_create(username: 'User1', password: 'password1', password_confirmation: 'password1')
user2 = User.where(email: 'dilemma2@example.com').first_or_create(username: 'User2', password: 'password2', password_confirmation: 'password2')

# blockers
blocker1 = [
  {
    category: 'holiday',
    blocker_description: 'Should I bring a new dish to the holiday dinner?',
    resolved: true,
    urgent: true
  }
]

blocker2 = [
  {
    category: 'clothing',
    blocker_description: 'My favorite outfit is white, and it is after Labor Day. What should I do?',
    resolved: true,
    urgent: true
  },{
    category: 'education',
    blocker_description: 'I am not sure where to go to learn about coding. Do you have any suggestions?',
    resolved: false,
    urgent: true
  }
]

# create associations between users and blockers
blocker1.each do |blocker|
  user2.blockers.create blocker
  p "creating blocker: #{blocker}"
end

blocker2.each do |blocker|
  user1.blockers.create blocker
  p "creating blocker: #{blocker}"
end

# solutions
solution1 = Solution.create(
  description: 'Holidays are valuable moments. Bring your best not your test.',
  require_followup: false,
  attempted: false,
  acceptable: true,
  user_id: user2.id,
  blocker_id: 1
)

solution2 = Solution.create(
  description: "It's your prerogative. Do what you want to do with your closet accesories!",
  require_followup: false,
  attempted: true,
  acceptable: true,
  user_id: user1.id,
  blocker_id: 2
)

solution3 = Solution.create(
  description: 'Everything that I continue to aspire to be is what I have acquired from LEARN Academy.',
  require_followup: true,
  attempted: false,
  acceptable: true,
  user_id: user1.id,
  blocker_id: 3
)
p "creating solution: #{solution1}, #{solution2}, #{solution3}"