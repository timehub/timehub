class ProjectsController < ApplicationController
  load_and_authorize_resource :through => :current_user, :shallow => true
  respond_to :js, :only => [:update, :populate]

  def index
    @projects = current_user.projects.order(:name).includes(:invoices)
  end

  def show
    if @project.to_param != params[:id]
      headers["Status"] = "301 Moved Permanently"
      redirect_to project_url(@project)
    else
      @commits = @project.commits(:include => { :entries => :invoices }).page(1)
    end
  end

  # we only update the rate
  def update
    @project.update_attributes(rate: params[:project][:rate])
  end

  # Loads a few projects from Github.
  def populate
    repos = API::Repositories.each_for_oauth_token(current_user.access_token) do |repo|
      current_user.projects.create_from_github_repo(repo)
    end
    @projects = current_user.projects.order(:name)
  end
end
