class User < ApplicationRecord
  has_many :sessions
  has_one :survey
end
