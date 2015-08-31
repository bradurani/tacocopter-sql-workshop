class RenameQuestionId < ActiveRecord::Migration
  def change
    rename_column :answers, :questions_id, :question_id
  end
end
