class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :groups, class_name: 'Group', foreign_key: 'user_id'
  has_many :expenses, class_name: 'Expense', foreign_key: 'user_id'

  validates :name, presence: true, length: { in: 2..300 }

  def admin?
    role == 'admin'
  end
end
