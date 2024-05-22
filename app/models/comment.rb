class Comment < ApplicationRecord
  belongs_to :post
  # attribute :comment_author, :string
  # attribute :timestamp, :datetime
end
