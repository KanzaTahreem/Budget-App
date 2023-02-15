class GroupsController < ApplicationController
  before_action :find_user
  before_action :find_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = @user.groups.all
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
