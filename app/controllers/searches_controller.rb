class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(params[:search])
    @results = @search.search_google
  end

  def index
    # render partial: 'search_results', formats: :js, object: @results
  end

end
