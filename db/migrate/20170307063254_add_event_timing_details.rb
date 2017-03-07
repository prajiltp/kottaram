class AddEventTimingDetails < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :interval, :float
    change_table :groups do |t|
  	  t.integer :status, default: 0
  	  t.integer :slot, default: 0
  	  t.date :event_date
    end
    Event.all.each do |event|
      if event.cleaning?
      	event.interval = 1
      elsif event.cooking?
      	event.interval = 0.5
      end
      event.save
    end
  end
end
