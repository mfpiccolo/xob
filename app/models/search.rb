require "./lib/google_custom_search_api.rb"

class Search < ActiveRecord::Base
  include GoogleCustomSearchApi

  attr_accessible :terms

  def search_google
    results = GoogleCustomSearchApi.search(terms)
  end

end
