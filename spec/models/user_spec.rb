# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:products).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
end
