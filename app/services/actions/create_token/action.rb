# Проверка авторизхациит запроса (authorize)
# Преобразование запроса в параметры (deserialize)
# Првоерка десериализованных параметров (validator)
# Возвращаем успешный ответ с сериализованными данными и статусом :created

require 'dry/monads'
require 'dry/matcher/result_matcher'

module Actions
  module CreateToken
    class Action
      include Dry::Monads[:do, :result]
      include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

      def initialize
        @deserializer = Deserializer.new
        @validator = Validator.new
        @authorizer = Authorizer.new
      end

      def call(request)
        auth = yield authorizer.call(request)
        params = yield deserializer.call(request)

        yield validator.call(params)

        Success(status: :created, result: Serializer.new(params).to_json)
      end

      private 

      attr_accessor :deserializer, :validator, :authorizer
    end
  end
end
