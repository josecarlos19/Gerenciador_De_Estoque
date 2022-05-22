# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
                   uniqueness: { case_sensitive: true }
  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true,
                    numericality: { only_integer: false, greater_than: 0 }
  attribute :active, :boolean, default: true
end
