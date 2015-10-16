class StoreTaco < ActiveRecord::Base
  belongs_to :store
  belongs_to :taco
end
