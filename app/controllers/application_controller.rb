class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :validation_error_response
  rescue_from ActionController::ParameterMissing, with: :validation_error_response

  def validation_error_response(error)
    render json: ErrorSerializer.new(error).validation_error, status: :bad_request
  end
end
