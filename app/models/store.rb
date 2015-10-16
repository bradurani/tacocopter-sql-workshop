class Store < ActiveRecord::Base
  has_many :store_tacos
  has_many :store_salsas

  belongs_to :city
end
