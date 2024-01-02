class StaticPagesController < ApplicationController
  def home
    @projects = Project.includes(:user).order(created_at: :desc).limit(6)
  end
end
