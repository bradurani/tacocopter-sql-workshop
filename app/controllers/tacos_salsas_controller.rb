class TacosSalsasController < ApplicationController
  def index
    @tacos  = Taco.all
    @salsas = Salsa.all
  end
end
