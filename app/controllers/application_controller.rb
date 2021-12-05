class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  private

  def not_found(e)
    return render json: {status: "error", message: "Record with id: #{params[:id]} not found"}, status: :unprocessable_entity
  end

  def not_destroyed(e)
    return render json: {status: "error", message: "record could not be destroyed", errors: e.record.errors }, status: :unprocessable_entity
  end
end
