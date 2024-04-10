class Feature < ApplicationRecord
    validates :place, :url, :magType, :title, :longitude, :latitude, :magnitude, presence: true
    validates :longitude, numericality: { less_than_or_egual_to: 180, greater_than_or_equal_to: -180 }
    validates :latitude, numericality: { less_than_or_egual_to: 90, greater_than_or_equal_to: -90 }
    validates :magnitud, numericality: { less_than_or_egual_to: 10, greater_than_or_equal_to: -1 }
end
