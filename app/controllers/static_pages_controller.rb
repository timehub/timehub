class StaticPagesController < ApplicationController
  skip_authorization_check

  def home
  end

  def help ; end

end
