require "./lib/google_custom_search_api.rb"

class Search < ActiveRecord::Base
  include GoogleCustomSearchApi

  attr_accessible :domain, :terms, :image, :add_terms, :file_type

  after_initialize :build_query_string

  attr_accessor :domain, :terms, :image, :add_terms, :file_type, :query

  def search_google
    results = GoogleCustomSearchApi.search(query)
  end


  private

  def build_query_string
    @query = ""
    query_hash = {
      terms_q: (("&q=#{terms}" if terms) || ""),
      add_terms_q: (("&hq=#{add_terms}" if add_terms) || ""),
      domain_q: (("&siteSearch=#{domain}" if domain) || ""),
      image_q: (("&searchType=#{image}" if image) || ""),
      file_type_q: (("&fileType=#{file_type}" if file_type) || "")
    }
    query_hash.each_pair do |k, v|
      @query << v
    end
  end

  def image?
    @image ||= false
  end
end
