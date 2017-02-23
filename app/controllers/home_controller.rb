class HomeController < ApplicationController
  skip_before_action :authenticate_and_configure, only: [:index]
  def index
  	redirect_to events_path if current_user
  end
end