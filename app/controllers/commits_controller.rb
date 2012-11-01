class CommitsController < ApplicationController
  load_and_authorize_resource :except => [ :index ]
  before_filter :load_project
  
  def index
    @commits = @project.commits.where("committed_at < ?", Time.parse(params[:before_time])).page(1)
    if @commits.empty? # Let's try to load more from Github
      @project.commits.populate_100_last_commits(@project, params[:before_sha])      
    end
    @commits = @commits.where("committed_at < ?", Time.parse(params[:before_time])).page(1)
  end
    
  # Loads the last 100 commits from Github or all commits that are newer than a particular commit.
  def populate
    if params[:after] # Fetch all commits that are newer to the commit with sha == params[:after]
        @project.commits.populate_commits_newer_than(params[:after], @project)
    else # First time I'm populating. Load the 100 most recent commits and that's it.
        @project.commits.populate_100_last_commits(@project)
    end
    @commits = @project.commits.page(1)
  end
  
  private

  def load_project
    @project = current_user.projects.find(params[:project_id])
    authorize! :read, @project
  end
end
