require 'rails_helper'

RSpec.describe 'Unauthorizeds', type: :request do
  describe 'GET /index' do
    before(:each) { get unauthorized_path }

    it 'returns http success' do
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end
end
