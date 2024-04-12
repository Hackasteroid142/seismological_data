class Feature < ApplicationRecord
    MAX_PER_PAGE = 1000

    has_many :comments

    validates :place, :url, :magType, :title, :longitude, :latitude, :magnitude, presence: true
    validates :longitude, numericality: { less_than_or_egual_to: 180, greater_than_or_equal_to: -180 }
    validates :latitude, numericality: { less_than_or_egual_to: 90, greater_than_or_equal_to: -90 }
    validates :magnitude, numericality: { less_than_or_egual_to: 10, greater_than_or_equal_to: -1 }

    scope :by_magType, -> (magType) { where(magType: magType) }

    # Aplica filtros para búsqueda de Features
    #
    # @param { number } page Número de página que se desea ver
    # @param { number } perPage Cantidad de features por página
    # @param { string } magType filtro para buscar por tipo de mag
    # 
    # @return { object} Features encontradas según filtros aplicados
    def self.filter_features(params)
        per_page = params[:per_page].to_i
        page = params[:page].to_i

        if per_page <= 0 || per_page > MAX_PER_PAGE
            raise ArgumentError, "El parámetro per_page debe ser un número entre 1 y #{MAX_PER_PAGE}" 
        end

        @features = Feature.all

        if params[:magType].present? 
            mag_types = params[:magType].split(',')
            @features = @features.where(magType: mag_types)
        end
        
          @features.page(page).per(per_page)
    end
end
