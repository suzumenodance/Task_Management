class User < ApplicationRecord
  validates :email, {presence: true, length: {maximum: 140}, uniqueness: true}
  validates :name, {presence: true, length: {maximum: 140}, uniqueness: true}
end
