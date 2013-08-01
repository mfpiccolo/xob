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

  def save_search
    @search ||= current_user.searches.new if current_user.present?
    # draggables = params[:draggables] = JSON.parse params[:draggables] if params[:draggables].is_a? String
    @search.save_search(params[:draggables])
    # @search.save

    respond_to do |format|
      format.json { render :json => "test" }
    end
  end

end
