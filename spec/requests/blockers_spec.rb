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
      # p blocker
      expect(blocker.first['category']).to eq 'holiday'
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    it 'saves a valid blocker' do
      blocker_params = {
        blocker: {
          category: 'holiday',
          blocker_description: 'Should I bring a new dish to the holiday dinner?',
          resolved: true,
          urgent: true
        }
      }

      post '/blockers', params: blocker_params

      expect(response).to have_http_status(200)

      blocker = JSON.parse(response.body)
      # p blocker
      expect(blocker['blocker_description']).to include 'Should I bring a new'
    end
  end

  describe "PATCH /update" do
    it 'updates an existing blocker' do
      blocker_params = {
        blocker: {
          category: 'holiday',
          blocker_description: 'Should I bring a new dish to the holiday dinner?',
          resolved: true,
          urgent: true
        }
      }

      post '/blockers', params: blocker_params
      edit_blocker = Blocker.first
      expect(edit_blocker['resolved']).to eq true

      edit_params = {
        blocker: {
          category: 'holiday dinner',
          blocker_description: 'Should I bring a new dish to the holiday dinner?',
          resolved: false,
          urgent: true
        }
      }
      patch "/blockers/#{edit_blocker.id}", params: edit_params

      expect(response).to have_http_status(200)

      blocker = JSON.parse(response.body)
      # p blocker
      expect(blocker['resolved']).to eq false
      expect(blocker['category']).to eq 'holiday dinner'
    end
  end

  describe "DELETE /destroy" do
    it 'deletes an existing blocker' do
      blocker = Blocker.create(
        category: 'holiday dinner',
        blocker_description: 'Should I bring a new dish to the holiday dinner?',
        resolved: false,
        urgent: true
      )

      delete "/blockers/#{blocker.id}"

      expect(response).to have_http_status(204)
      blockers = Blocker.all
      expect(blockers.count).to eq 0
    end
  end
end
