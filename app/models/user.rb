class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # enum role: [:user, :moderator, :admin]

  after_initialize :set_default_role, if: :new_record?

  validates :roles, presence: true

  def set_default_role
    self.add_role(:normal)
  end

  def admin?
    self.has_role?(:admin)
  end
end
