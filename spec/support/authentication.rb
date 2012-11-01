def login_as(user)
  controller.stub!(:current_user).and_return(user)
end

def logout
  controller.stub!(:current_user).and_return(nil)
end