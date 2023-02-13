class User < ApplicationRecord
  has_many :groups, class_name: 'Group', foreign_key: 'user_id'
  has_many :expenses, class_name: 'Expense', foreign_key: 'user_id'
end