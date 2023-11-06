require 'rails_helper'

RSpec.describe "Blockers", type: :request do

  describe "GET /index" do
    it 'returns all the blockers' do
      blocker = Blocker.create(
        category: 'holiday',
        blocker_description: 'Should I bring a new dish to the holiday dinner?',
        resolved: true,
        urgent: true
      )
      get '/blockers'

      blocker = JSON.parse(response.body)
      p blocker
      expect(blocker.first['category']).to eq 'holiday'
      expect(response).to have_http_status(200)
    end
  end
end
