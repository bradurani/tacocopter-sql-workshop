class QuestionsController < ApplicationController

  def index
    @questions = Question.all.eager_load(:answers)
  end

end
