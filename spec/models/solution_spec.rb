require 'rails_helper'

RSpec.describe Solution, type: :model do
  let(:user) { User.create(
    username: 'User1',
    email: 'test@example.com',
    password: 'password1',
    password_confirmation: 'password1'
  )}
  let(:blocker) {Blocker.create(
    category: 'holiday',
    blocker_description: 'Should I bring a new dish to the holiday dinner?',
    resolved: true,
    urgent: true
  )}
  
  it 'validates description' do
    solution = user.solutions.create(
      blocker: blocker,
      description: nil,
      require_followup: false,
      attempted: true,
      acceptable: true
    )
    expect(solution.errors[:description]).to include("can't be blank")
  end

  it 'validates blocker' do
    solution = user.solutions.create(
      blocker: nil,
      description: 'Holidays are valuable moments. Bring your best not your test.',
      require_followup: false,
      attempted: true,
      acceptable: true
    )
    expect(solution.errors[:blocker_id]).to include("can't be blank")

  end

  it 'validates user' do
    solution = Solution.create(
      blocker_id: blocker.id,
      user_id: nil,
      description: 'Holidays are valuable moments. Bring your best not your test.',
      require_followup: false,
      attempted: true,
      acceptable: true
    )
    expect(solution.errors[:user_id]).to include("can't be blank")
  end
end
