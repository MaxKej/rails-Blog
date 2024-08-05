
# Model Comment reprezentuje komentarze do postów.
#
# @!attribute [rw] post_id
#   @return [Integer] ID posta, do którego należy komentarz
# @!attribute [rw] user_id
#   @return [Integer, nil] ID użytkownika, który napisał komentarz (może być pusty)
# @!attribute [rw] content
#   @return [String] treść komentarza
class Comment < ApplicationRecord
  paginates_per 10

  # Relacja z modelem Post
  # @return [Post]
  belongs_to :post

  # Relacja z modelem User (opcjonalna)
  # @return [User, nil]
  belongs_to :user, optional: true
end

