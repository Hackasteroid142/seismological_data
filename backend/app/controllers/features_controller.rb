class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[ show update destroy create_comment ]

  # GET /features
  # 
  # @param { number } page Número de página que se desea ver
  # @param { number } perPage Cantidad de features por página
  # @param { string } magType filtro para buscar por tipo de mag
  # 
  # @return { object} Features encontradas según filtros aplicados
  def index
    @features = Feature.filter_features(filter_params)

    feature_data = @features.map do |feature|
      {
        id: feature.id,
        type: "feature",
        attributes: {
          external_id: feature.externalId,
          magnitude: feature.magnitude,
          place: feature.place,
          time: Time.at(feature.time / 1000),
          tsunami: !!feature.tsunami,
          mag_type: feature.magType,
          title: feature.title,
          coordinates: {
            longitude: feature.longitude,
            latitude: feature.latitude
          }
        },
        links: {
          external_url: feature.url,
        }
      }
    end

    response = {
      data: feature_data,
      pagination: {
        current_page: filter_params[:page].to_i,
        total: feature_data.count,
        per_page: filter_params[:per_page].to_i,
      }
    }

    render json: response
  end

  # GET /features/1
  def show
    render json: @feature
  end

  # POST /features
  def create
    @feature = Feature.new(feature_params)

    if @feature.save
      render json: @feature, status: :created, location: @feature
    else
      render json: @feature.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /features/1
  def update
    if @feature.update(feature_params)
      render json: @feature
    else
      render json: @feature.errors, status: :unprocessable_entity
    end
  end

  # DELETE /features/1
  def destroy
    @feature.destroy!
  end

  # POST /features/:id/comment
  #
  # @param { string } body Texto con el contenido del comentario
  def create_comment
    if params[:body].blank?
      render json: { error: "El cuerpo del comentario no puede estar vacío" }, status: :unprocessable_entity
      return
    end

    @comment = @feature.comments.new(content: params[:body])

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end

    def filter_params
      params.permit(:magType, :page, :per_page)
    end

    # Only allow a list of trusted parameters through.
    def feature_params
      params.require(:feature).permit(:mag, :place, :time, :url, :tsunami, :magType, :title, :longitude, :latitude)
    end
end
