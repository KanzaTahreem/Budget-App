class ExpensesController < ApplicationController
  load_and_authorize_resource except: %i[show]

  before_action :find_user
  before_action :find_group
  before_action :find_group_expenses
  before_action :find_expense, only: %i[show edit update destroy]

  def index
    authorize! :manage, @group
  end

  def show; end

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

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to group_expense_path(group_id: @group.id, id: @expense.id), notice: 'Expense updated successfully'
    else
      flash.now[:alert] = @expense.errors.full_messages.first if @expense.errors.any?
      render :edit, status: 400
    end
  end

  # rubocop:disable Lint/UselessAssignment
  def destroy
    if can? :edit, @expense
      @group_expenses = GroupExpense.where(expense_id: @expense.id)
      @group_expenses.each do |group_expense|
        expense_id = group_expense.expense_id
        group_expense.destroy
      end
      if @expense.destroy
        redirect_to group_expenses_path(group_id: @group.id), notice: 'Expense was deleted successfully'
      else
        flash.now[:alert] = @expense.errors.full_messages.first if @expense.errors.any?
        render :index, status: 400
      end
    else
      flash[:alert] = 'Un Authorized'
      redirect_to groups_path
    end
  end
  # rubocop:enable Lint/UselessAssignment

  private

  def find_user
    @user = current_user
  end

  def find_group
    @group = Group.find(params[:group_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Group not found!'
    redirect_to not_found_index_path
  end

  def find_group_expenses
    @group_expenses = GroupExpense.where({ group_id: params[:group_id] }).order(created_at: :desc)
  end

  def find_expense
    @expense = Expense.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Expense not found!'
    redirect_to not_found_index_path
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :icon)
  end
end
