class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[ show update destroy ]

  # GET /features
  def index
    @features = Feature.all

    @features = @features.by_magType(filter_params[:magType]) if filter_params[:magType].present?

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

    render json: { data: feature_data }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end

    def filter_params
      params.permit(:magType)
    end

    # Only allow a list of trusted parameters through.
    def feature_params
      puts params.inspect
      params.require(:feature).permit(:mag, :place, :time, :url, :tsunami, :magType, :title, :longitude, :latitude)
    end
end
