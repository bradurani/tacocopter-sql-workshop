class RemoveOutputColumn < ActiveRecord::Migration
  def change
    remove_column :questions, :output
  end
end
