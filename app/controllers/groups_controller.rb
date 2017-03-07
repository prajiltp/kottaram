class GroupsController < ApplicationController
  before_filter :set_group

  def completed
  	if @group
  	  authorize @group
  	  @group.complete_and_reassign
  	  redirect_to events_path
  	end
  end

  def skipped
    if @group
      authorize @group
      @group.skip_for_slot
      redirect_to events_path
    end
  end

  private

  def set_group
  	@event = Event.find_by(id: params[:event_id])
  	@group = @event.groups.find_by(id: params[:id]) if @event
  end

end
