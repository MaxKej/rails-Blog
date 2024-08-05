
# Model Role obsługuje role użytkowników w aplikacji.
#
# @!attribute [rw] name
#   @return [String] nazwa roli (admin, normal)
# @!attribute [rw] resource_type
#   @return [String, nil] typ zasobu, do którego należy rola
# @!attribute [rw] resource_id
#   @return [Integer, nil] ID zasobu, do którego należy rola
class Role < ApplicationRecord
  # Relacja z modelem User przez tabelę łączącą users_roles
  # @return [ActiveRecord::Associations::CollectionProxy<User>]
  has_and_belongs_to_many :users, join_table: :users_roles

  # Relacja do zasobu, który może być dowolnym modelem (polimorficzne)
  # @return [ActiveRecord::Associations::BelongsToPolymorphicAssociation]
  belongs_to :resource,
             polymorphic: true,
             optional: true

  # Walidacja typu zasobu
  # @return [void]
  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  # Walidacja nazwy roli
  # @return [void]
  validates :name,
            inclusion: { in: ["admin", "normal"] },
            uniqueness: true

  scopify
end
