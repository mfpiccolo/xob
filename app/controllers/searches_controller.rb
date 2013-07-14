class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(params[:search])
    @results = @search.search_google.items
    render :index, collection: @results, object: @search
  end

  def index
  end

end
