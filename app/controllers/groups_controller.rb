class GroupsController < ApplicationController
  before_action :find_user

  def index
    @groups = @user.groups.all
  end

  private

  def find_user
    @user = current_user
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
