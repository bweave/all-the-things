class GraphqlController < ApplicationController
	skip_before_action :verify_authenticity_token

  def query
  	res = Schema.execute(params[:query], variables: params[:variables])
		render json: res
	end
end
