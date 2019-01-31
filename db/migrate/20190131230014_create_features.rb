class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
