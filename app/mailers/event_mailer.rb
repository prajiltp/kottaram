class EventMailer < ApplicationMailer
  def changed_event(user, event, subject, category)
  	@event =  event
  	@user = user
  	@category = category
  	@event_name = @event.cooking? ? 'Cooking' : @event.name
  	mail(to: user.email,
         subject: subject)
  end
end
