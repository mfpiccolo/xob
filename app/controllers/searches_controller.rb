class SearchesController < ApplicationController

  def new
    @search = Search.new
    @user = current_user || User.new
  end

  def create
    @search = Search.new(params[:search])
    @results = @search.search
    @service = params[:search][:service]
  end

  def index
    # render partial: 'search_results', formats: :js, object: @results
  end

end
