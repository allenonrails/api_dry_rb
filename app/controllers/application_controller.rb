class ApplicationController < ActionController::API
  private

  def call_action(action)
    action.call(request) do |result|
      result.success { |status:, result:| render json: result, status: status }
      result.failure(:authorize) { head :forbidden }
      result.failure(:deserialize) { head :bad_request }
      result.failure(Dry::Validation::Result) do |res|
        render json: { errors: res.errors.to_h}, status: :unprocessable_entity
      end
      result.failure { head 500 }
    end
  end
end
