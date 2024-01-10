class StaticPagesController < ApplicationController
  def home
    @projects = Project.includes(:user).order(id: :desc).limit(6)
  end
end
