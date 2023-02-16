class GroupsController < ApplicationController
  before_action :find_user
  before_action :find_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = @user.groups.all
    # @groups_sum = {}
    # @groups.each do |group|
    #   @groups_sum[group.id] = group.expenses.sum(:amount)
    # end
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = @user
    if @group.save
      redirect_to group_path(id: @group.id), notice: 'Group created successfully'
    else
      flash.now[:alert] = @group.errors.full_messages.first if @group.errors.any?
      render :new, status: 400
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(id: @group.id), notice: 'Group updated successfully'
    else
      flash.now[:alert] = @group.errors.full_messages.first if @group.errors.any?
      render :edit, status: 400
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group_expenses = GroupExpense.where(group_id: @group.id)
    @group_expenses.each do |group_expense|
      expense_id = group_expense.expense_id
      group_expense.destroy
      expense = Expense.delete(expense_id)
    end
    if @group.destroy
      redirect_to groups_path, notice: 'Groups was deleted successfully'
    else
      flash.now[:alert] = @group.errors.full_messages.first if @group.errors.any?
      render :index, status: 400
    end
  end

  private

  def find_user
    @user = current_user
  end

  def find_group
    @group = Group.find_by_id(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
