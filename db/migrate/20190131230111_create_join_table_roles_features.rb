class CreateJoinTableRolesFeatures < ActiveRecord::Migration[5.2]
  def change
    create_join_table :roles, :features do |t|
      t.index [:role_id, :feature_id]
      t.index [:feature_id, :role_id]
    end
  end
end
