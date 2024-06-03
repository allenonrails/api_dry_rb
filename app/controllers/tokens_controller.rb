class TokensController < ApplicationController
  def create
    call_action(create_token)
  end

  private

  def create_token 
    Actions::CreateToken::Action.new
  end
end
