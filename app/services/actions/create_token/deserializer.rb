require 'dry/monads/result'

module Actions
  module CreateToken
    class Deserializer
      include Dry::Monads[:do, :result, :try]

      def call(request)
        params = ActionController::Parameters.new(request.params)
        
        result = yield deserialize(params)

        Success(result.to_h)
      end

      private

      def deserialize(params)
        #ActionController::Parameters.action_on_unpermitted_parameters = :raise

        res = Try[ActionController::ParametersMissing, ActionController::UnpermittedParameters] do 
          params.require(:token).permit(:first_name, :last_name)
        end

        ree.error? ? Failure(:deserialize) : res
      end
    end
  end
end
