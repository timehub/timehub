class ActivitiesController < ApplicationController
  load_and_authorize_resource :project, :through => :current_user
  load_resource :activity, :through => :project
  respond_to :js, :json

  def create
    @activity.save
    respond_with(@activity)
  end
end
