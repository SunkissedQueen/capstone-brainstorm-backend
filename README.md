## Has Many Relationships
### References
- [Join Table in Rails](https://medium.com/@mahdy.a.noureddine/step-by-step-guide-on-efficiently-making-a-join-table-in-rails-426fa6b9cce2)

- [Modify Devise](https://github.com/learn-academy-2023-foxtrot/syllabus/blob/main/capstone/modifying-devise.md)

### Explanation
In Ruby on Rails, a "has_many through" relationship is a type of association that allows you to connect three models in a more complex way. Users can have many blockers and solutions. Blockers and solutions can be assigned to many users. The User and Blocker models don't have a direct association with each other; instead, they go through the Solution model.

### Process
1. Generate resources: `foreign keys for User and Blocker models will be placed on the Solution model`
2. Define the models: `has_many through relationship will be placed on User and Blocker` 
3. Create associations in the seed file: 
```rb
  # Create user seeds
  user1 = User.where(email: 'dilemma1@example.com').first_or_create(username: 'User1', password: 'password1', password_confirmation: 'password1')

  # Create blocker seeds
  blocker1 = Blocker.create(
    category: 'holiday',
    blocker_description: 'Should I bring a new dish to the holiday dinner?',
    resolved: true,
    urgent: true
  )

  # Create solution seeds
  # user1.solutions is a reference to the association between the User model and the Solution model, which represents a user's solutions. The create method is used to build and save a new Solution record with the specified attributes. `blocker: blocker1` assigns the Blocker record blocker1 to the solution, linking this solution to the 'holiday' blocker.
  solution1 = user1.solutions.create(
    blocker: blocker1,
    description: 'Holidays are valuable moments. Bring your best not your test.',
    require_followup: false,
    attempted: true,
    acceptable: true
  )
```

