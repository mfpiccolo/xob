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

  def save_search
    @search ||= current_user.searches.new if current_user.present?
    @search.save_search(params[:draggables])
  end

  def get_draggables
    @draggables = current_user.searches.find(params[:id]).draggables
  end

  private

  def search_params
    params.require(:search).permit(:domain, :required_terms, :image, :add_terms,
      :file_type, :must_have, :excluded_terms, :exact_terms, :google,
      :twitter, :result_type, :draggables, :name)
  end

end
