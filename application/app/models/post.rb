# Model Post reprezentuje posty tworzone przez użytkowników.
#
# @!attribute [rw] user_id
#   @return [Integer] ID użytkownika, który stworzył post
# @!attribute [rw] title
#   @return [String] tytuł posta
# @!attribute [rw] content
#   @return [String] treść posta
class Post < ApplicationRecord
  # Relacja z modelem User
  # @return [User]
  belongs_to :user

  # Relacja z modelem Comment, z zależnością usuwania powiązanych komentarzy
  # @return [ActiveRecord::Associations::CollectionProxy<Comment>]
  has_many :comments, dependent: :destroy

  # Walidacja obecności user_id
  # @return [void]
  validates :user_id, presence: true

  # Walidacja obecności tytułu
  # @return [void]
  validates :title, presence: true

  # Walidacja obecności treści
  # @return [void]
  validates :content, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {
    number_of_shards: 1,
    number_of_replicas: 0
  } do
    mappings dynamic: 'false' do
      indexes :title, type: :text, analyzer: 'english'
      indexes :content, type: :text, analyzer: 'english'
    end
  end

  # Przygotowuje JSON do zindeksowania w Elasticsearch
  #
  # @param options [Hash] opcje indeksowania
  # @return [Hash] zindeksowane dane w formacie JSON
  def as_indexed_json(options = {})
    as_json(only: [:title, :content, :user_id])
  end
end