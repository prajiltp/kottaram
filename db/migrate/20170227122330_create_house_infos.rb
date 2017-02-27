class CreateHouseInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :house_infos do |t|
      t.integer :name
      t.datetime :agreement_created
      t.integer :agreement_validity
      t.datetime :agreement_extended_at
      t.integer :extension_period
      t.float :rent
      t.timestamps
    end
  end
end
