class StaticController < ApplicationController
  skip_before_filter :authenticate_user!
  def show
    @static = Static.find(params[:id])
  end
end
