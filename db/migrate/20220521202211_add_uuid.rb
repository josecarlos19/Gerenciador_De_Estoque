# frozen_string_literal: true
class AddUuid < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'
  end
end
