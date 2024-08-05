# Model User obsługuje uwierzytelnianie i zarządzanie rolami użytkowników.
#
# @!attribute [rw] email
#   @return [String] adres email użytkownika
# @!attribute [rw] encrypted_password
#   @return [String] zaszyfrowane hasło użytkownika
# @!attribute [rw] roles
#   @return [Array<Role>] role przypisane użytkownikowi
class User < ApplicationRecord
  rolify
  # Dołącz domyślne moduły devise. Inne dostępne moduły to:
  # :confirmable, :lockable, :timeoutable, :trackable i :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # enum role: [:user, :moderator, :admin]

  after_initialize :set_default_role, if: :new_record?

  validates :roles, presence: true

  has_many :posts

  # Ustawia domyślną rolę dla nowego użytkownika
  #
  # @return [void]
  def set_default_role
    self.add_role(:normal) if self.roles.blank?
  end

  # Sprawdza, czy użytkownik ma rolę administratora
  #
  # @return [Boolean] prawda, jeśli użytkownik ma rolę admin, w przeciwnym razie fałsz
  def admin?
    self.has_role?(:admin)
  end
end
