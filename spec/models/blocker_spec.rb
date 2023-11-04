require 'rails_helper'

RSpec.describe Blocker, type: :model do

  it 'should validate category' do
    blocker = Blocker.create(
      category: nil,
      blocker_description: 'Should I bring a new dish to the holiday dinner?',
      resolved: true,
      urgent: true
    )
    expect(blocker.errors[:category]).to include("can't be blank")
  end

  it 'should validate description' do
    blocker = Blocker.create(
      category: 'holiday',
      blocker_description: nil,
      resolved: true,
      urgent: true
    )
    expect(blocker.errors[:blocker_description]).to include("can't be blank")
  end
end
