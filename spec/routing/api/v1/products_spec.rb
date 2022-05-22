# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :routing do
  describe 'Routing' do
    it { should route(:get, 'api/products').to(action: :index, format: :json) }
    it { should route(:get, 'api/products/1').to(action: :show, id: '1', format: :json) }
    it { should route(:post, 'api/products').to(action: :create, format: :json) }
    it { should route(:put, 'api/products/1').to(action: :update, id: '1', format: :json) }
    it { should route(:patch, 'api/products/1').to(action: :update, id: '1', format: :json) }
    it { should route(:delete, 'api/products/1').to(action: :destroy, id: '1', format: :json) }
  end
end
