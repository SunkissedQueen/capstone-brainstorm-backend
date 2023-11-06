require 'rails_helper'

RSpec.describe "Solutions", type: :request do
  # persistent user 
  let(:user) { User.create(
    username: 'User1',
    email: 'dilemma1@example.com',
    password: 'password1',
    password_confirmation: 'password1'
  )}

  # persistent blocker
  let(:blocker1) { Blocker.create(
    category: 'holiday',
    blocker_description: 'Should I bring a new dish to the holiday dinner?',
    resolved: true,
    urgent: true
  )}

  describe "GET /index" do
    it 'returns all the blockers' do
      solution = user.solutions.create(
        blocker: blocker1,
        description: 'Holidays are valuable moments. Bring your best not your test.',
        require_followup: false,
        attempted: true,
        acceptable: true
      )
      get '/solutions'

      solution = JSON.parse(response.body)
      # p solution
      expect(solution.first['description']).to include 'Holidays are valuable'
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    it 'saves a valid solution' do
      solution_params = {
        solution: {
          blocker_id: blocker1.id,
          description: 'Holidays are valuable moments. Bring your best not your test.',
          require_followup: false,
          attempted: true,
          acceptable: true,
          user_id: user.id
        }
      }

      post '/solutions', params: solution_params

      expect(response).to have_http_status(200)

      solution = JSON.parse(response.body)
      # p solution
      expect(solution['description']).to include 'Holidays are valuable'

      # associations
      expect(user.blockers.count).to eq 1
    end
  end

  describe "PATCH /update" do
    it 'updates an existing solution' do
      solution_params = {
        solution: {
          blocker_id: blocker1.id,
          description: 'Holidays are valuable moments. Bring your best not your test.',
          require_followup: false,
          attempted: true,
          acceptable: true,
          user_id: user.id
        }
      }

      post '/solutions', params: solution_params
      edit_solution = Solution.first
      expect(edit_solution['require_followup']).to eq false

      edit_params = {
        solution: {
          blocker_id: blocker1.id,
          description: 'Holidays are valuable moments. Bring your best not your test.',
          require_followup: true,
          attempted: true,
          acceptable: true,
          user_id: user.id
        }
      }
      patch "/solutions/#{edit_solution.id}", params: edit_params

      expect(response).to have_http_status(200)

      solution = JSON.parse(response.body)
      # p solution
      expect(solution['require_followup']).to eq true
    end
  end

  describe "DELETE /destroy" do
    it 'deletes an existing solution' do
      solution = user.solutions.create(
        blocker: blocker1,
        description: 'Holidays are valuable moments. Bring your best not your test.',
        require_followup: false,
        attempted: true,
        acceptable: true
      )

      delete "/solutions/#{solution.id}"

      expect(response).to have_http_status(204)
      solutions = Solution.all
      expect(solutions.count).to eq 0
      expect(user.solutions.count).to eq 0
    end
  end

end
