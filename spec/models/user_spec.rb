require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should validate username' do
    user = User.create(
      username: nil, 
      email: 'dilemma@example.com', 
      password: 'password1',
      password_confirmation: 'password1'
    )
    expect(user.errors[:username]).to include("can't be blank")
  end

  it 'should validate email' do
    user = User.create(
      username: 'User1', 
      email: nil, 
      password: 'password1',
      password_confirmation: 'password1'
    )
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'should validate password' do
    user = User.create(
      username: 'User1', 
      email: 'dilemma@example.com', 
      password: nil,
      password_confirmation: nil
    )
    expect(user.errors[:password]).to include("can't be blank")
  end

end