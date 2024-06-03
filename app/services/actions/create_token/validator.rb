require 'dry/validation'

Dry::Validation.load_extensions(:monads)

module Actions
  module CreateToken
    class Validator < Dry::Validation::Contract
      params do 
        required(:first_name).filled(:string)
        required(:last_name).filled(:string)
      end
    end
  end
end
