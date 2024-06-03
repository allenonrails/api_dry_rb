require 'dry-struct'

module Types
  include Dry.Types()
end

module Actions
  module CreateToken
    class Serializer < Dry::Struct
      transform_keys(&:to_sym)

      attribute :first_name, Types::String
      attribute :last_name, Types::String
    end
  end
end
