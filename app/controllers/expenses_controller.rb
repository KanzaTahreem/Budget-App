class ExpensesController < ApplicationController
  before_action :find_user
  before_action :find_group
  before_action :find_group_expenses

  def index
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = @user
    if @expense.save
      GroupExpense.create(group_id: @group.id, expense_id: @expense.id)
      redirect_to group_expenses_path(group_id: @group.id), notice: 'Expense created successfully'
    else
      flash.now[:alert] = @expense.errors.full_messages.first if @expense.errors.any?
      render :new, status: 400
    end
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
