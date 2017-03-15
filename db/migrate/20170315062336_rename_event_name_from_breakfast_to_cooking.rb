class RenameEventNameFromBreakfastToCooking < ActiveRecord::Migration[5.0]
  def change
  	breakfast = Event.where('name=?', 'Breakfast').first
  	breakfast.update!(name: 'cooking') if breakfast
  end
end
