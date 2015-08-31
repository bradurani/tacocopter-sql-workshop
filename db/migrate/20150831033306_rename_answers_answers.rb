class RenameAnswersAnswers < ActiveRecord::Migration
  def change
    rename_column :answers, :answers, :answer
  end
end
