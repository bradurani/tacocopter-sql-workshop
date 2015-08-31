class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :questions
      t.text :answers
      t.timestamps
    end
  end
end
