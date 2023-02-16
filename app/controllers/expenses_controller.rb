class ExpensesController < ApplicationController
  before_action :find_user
  before_action :find_group
  before_action :find_group_expenses

  def index
  end

  private
  
  def find_user
    @user = current_user
  end
  
  def find_group
    @group = Group.find_by_id(params[:group_id])
  end

  def find_group_expenses
    @group_expenses = GroupExpense.where({group_id: params[:group_id]})
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :icon)
  end
end
