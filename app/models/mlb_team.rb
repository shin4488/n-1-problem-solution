class MlbTeam < ApplicationRecord
  has_many :players, dependent: :destroy
end
