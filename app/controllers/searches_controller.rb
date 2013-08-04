class SearchesController < ApplicationController

  def new
    @search = Search.new
    @user = current_user || User.new
  end

  def create
    @search = Search.new(search_params)
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

  private

  def search_params
    params.require(:search).permit(:domain, :terms, :image, :add_terms,
      :file_type, :must_have, :excluded_terms, :exact_terms, :google,
      :twitter, :result_type, :draggables)
  end

end
