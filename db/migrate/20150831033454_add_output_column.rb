class AddOutputColumn < ActiveRecord::Migration
  def change
    add_column :questions, :output, :text, null: false
  end
end
