class Expense < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :group_expenses, class_name: 'GroupExpense', foreign_key: 'expense_id'

  validates :name, presence: true, length: { in: 2..300 }
  validates :amount, presence: true, numericality: { only_decimal: true, greater_than_or_equal_to: 0 }

end