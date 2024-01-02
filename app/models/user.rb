class User < ApplicationRecord
  before_save :downcase_username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: { case_sensitive: false }, length: { maximum: 25, minimum: 3 }

  has_many :projects, dependent: :destroy

  private

  # Converts username to all lowercase.
  def downcase_username
    self.username.downcase!
  end
end
