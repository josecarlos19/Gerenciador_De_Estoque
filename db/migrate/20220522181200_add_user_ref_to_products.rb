# frozen_string_literal: true
class AddUserRefToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :user, null: false, foreign_key: true, type: :uuid
  end
end
