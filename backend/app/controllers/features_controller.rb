class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[ show update destroy create_comment ]

  # GET /features
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

  def create_comment
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
