# @file spec/controllers/home_controller_spec.rb
# @description Test suite for HomeController.
# Validates that the root path renders successfully.
# Uses RSpec and Rails test helpers.
# @version 1.0.0
# @author
#   - Athika Jishida
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
