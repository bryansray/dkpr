class User < ActiveRecord::Base
  acts_as_authentic
  
  # Associations
  belongs_to :account

  # Validations
  validates_uniqueness_of :email
end
