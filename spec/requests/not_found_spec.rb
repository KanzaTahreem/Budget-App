require 'rails_helper'

RSpec.describe 'NotFounds', type: :request do
  describe 'GET /index' do
    before(:each) { get not_found_index_path }

    it 'returns http success' do
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end
end
