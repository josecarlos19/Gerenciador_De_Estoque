# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/products', type: :request do
  let(:user) { create :user }
  let(:product) { create :product, user: user }
  let(:product_two) { create :product, user: create(:user) }

  let(:valid_attributes) { attributes_for :product, user: user }
  let(:invalid_attributes) { attributes_for :invalid_product, user: user }

  let(:valid_headers) do
    user.create_new_auth_token.merge('Accept' => 'application/vnd.app.v1')
  end
  let(:invalid_headers) do
    { 'Accept' => 'application/vnd.app.v1' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_products_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders only products from logged user' do
      product
      product_two

      get api_products_url, headers: valid_headers, as: :json
      expect(json_response.size).to eq 1
      expect(json_response[0][:id]).to eq product.id
    end

    it_behaves_like 'user not logged in' do
      let(:url) { get api_products_url, headers: invalid_headers, as: :json }
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_product_url(product), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        get api_product_url(product_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        get api_product_url(product), headers: invalid_headers, as: :json
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect do
          post api_products_url,
               params: { product: valid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(Product, :count).by(1)
      end

      it 'renders a JSON response with the new product' do
        post api_products_url,
             params: { product: valid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect do
          post api_products_url,
               params: { product: invalid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(Product, :count).by(0)
      end

      it 'renders a JSON response with errors for the new product' do
        post api_products_url,
             params: { product: invalid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_products_url,
             params: { product: valid_attributes },
             headers: invalid_headers,
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :product }

      it 'updates the requested product' do
        patch api_product_url(product),
              params: { product: new_attributes },
              headers: valid_headers,
              as: :json
        product.reload
        expect(product.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the product' do
        patch api_product_url(product),
              params: { product: new_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the product' do
        patch api_product_url(product),
              params: { product: invalid_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        patch api_product_url(product_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch api_product_url(product),
              params: { product: valid_attributes },
              headers: invalid_headers,
              as: :json
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested product' do
      product
      expect do
        delete api_product_url(product), headers: valid_headers, as: :json
      end.to change(Product, :count).by(-1)
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        delete api_product_url(product_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        delete api_product_url(product), headers: invalid_headers, as: :json
      end
    end
  end
end
