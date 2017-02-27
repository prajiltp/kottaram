class EventsController < ApplicationController
  before_action :set_event, except: [:index]
  def index
  	@events = Event.all
  end

  def generate_group
  	@group, @errors = @event.assign_user_to_group(current_user)
  	redirect_to events_path
  end

  private

  def set_event
  	@event = Event.find params[:id]
  end

end