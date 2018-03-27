module ExceptionFallback

  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :bad_params
    rescue_from ActiveRecord::RecordNotUnique, with: :not_unique
  end

  def bad_params
    render json: {error: "Provided params are not ok"}, status: 400
  end

  def not_unique
    render json: {error: "Provided data already exists"}, status: 400
  end

end
