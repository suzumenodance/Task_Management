class Post < ApplicationRecord
  # validates :検証するカラム名, {検証する内容}
  # validates :content, {presence: true}#空の投稿を防ぐ
  # validates :content, {length: {maximum: 140}}#空の投稿を防ぐ
  validates :content, {presence: true, length: {maximum: 140}}
end
