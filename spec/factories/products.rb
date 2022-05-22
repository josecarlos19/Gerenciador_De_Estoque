# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Games::Minecraft.block }
    price { 10.5 }
    quantity { 2 }
    active { true }
    user # references => it uses the user factory

    factory :invalid_product do
      name { nil }
    end
  end
end
