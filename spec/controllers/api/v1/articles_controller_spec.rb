# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::ProductsController do
  it {should use_before_action(:authenticate_api_user!)}
end

