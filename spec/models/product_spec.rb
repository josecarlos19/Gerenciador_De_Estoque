# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { build :product }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }

    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:price) }

    it { is_expected.not_to allow_value(1.5).for(:quantity) } # Decimal values aren't allowed
    it { is_expected.not_to allow_value(-1).for(:quantity) }

    it { is_expected.not_to allow_value(-1).for(:price) }
  end
end
