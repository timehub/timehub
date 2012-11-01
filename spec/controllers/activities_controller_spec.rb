require 'spec_helper'

describe ActivitiesController do
  describe "create" do
    describe "as a non logged in user" do
      it "should raise an authentication error" do
        project = Factory(:project)
        post :create, :project_id => project.id, format: :js
        response.should redirect_to(root_path)
      end
    end

    describe "as a logged in user" do
      before(:each) do
        @project = Factory(:project, :user => user = Factory(:user))
        login_as user
      end

      let(:activity) { Factory.attributes_for(:activity) }

      it "should create an acitivity with valid params" do
        expect {
          post :create, project_id: @project.id, activity: activity, format: :js
        }.to change(Activity, :count).from(0).to(1)
      end

      it "should authorize the project" do
        project = Factory(:project)
        lambda {
          post :create, project_id: project.id, activity: activity, format: :js
        }.should raise_error(ActiveRecord::RecordNotFound)
      end

      it "should render the create template" do
        post :create, project_id: @project.id, format: :js
        response.should render_template(:create)
      end
    end
  end
end
