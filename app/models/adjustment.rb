class Adjustment < ActiveRecord::Base
  belongs_to :adjustee, :polymorphic => true
end
