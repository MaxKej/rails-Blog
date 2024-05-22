class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  # attribute :author, :string
  # attribute :timestamp, :datetime
end
