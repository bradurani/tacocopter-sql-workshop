class StoresController < ApplicationController
  def index

  end

  def search
    @stores = Store.joins(store_tacos: :taco, store_salsas: :salsa).
      where(tacos: { id: taco_params }).
      where(salsas: { id: salsa_params }).
      uniq.
      preload(:city)

    render :index
  end

  private
  def taco_params
    params.require(:taco_ids)
  end

  def salsa_params
    params.require(:salsa_ids)
  end
end
