require 'dry/monads/result'

module Actions
  module CreateToken
    class Authorizer
      include Dry::Monads[:result]

      def call(request)
        token = request.headers['Authorization'].to_s

        token.length.zero? ? Failure(:authorize) : Success(token.gsub('Bearer ', ''))
      end
    end
  end
end
