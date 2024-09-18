class Projects::AccessesController < ApplicationController
  include ProjectScoped

  def edit
    @users = @project.users
  end

  def update
    @project.update_access [ Current.user, *find_users ]
    redirect_to edit_project_access_url(@project)
  end

  private
    def find_users
      Current.account.users.active.where(id: params[:user_ids])
    end
end
