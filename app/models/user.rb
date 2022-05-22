# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable,  and :omniauthable

  has_many :products, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :trackable,
         :rememberable,
         :validatable
  include DeviseTokenAuth::Concerns::User
end
