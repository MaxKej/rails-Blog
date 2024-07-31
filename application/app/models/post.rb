class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {
    number_of_shards: 1,
    number_of_replicas: 0,
    analysis: {
      filter: {
        polish_stemmer: {
          type: "stemmer",
          language: "polish"
        }
      },
      analyzer: {
        polish: {
          type: "custom",
          tokenizer: "standard",
          filter: ["lowercase", "polish_stemmer"]
        }
      }
    }
  } do
    mappings dynamic: 'false' do
      indexes :title, type: :text, analyzer: 'polish'
      indexes :content, type: :text, analyzer: 'polish'
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:title, :content, :user_id])
  end
end