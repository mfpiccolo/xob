require "./lib/google_custom_search_api.rb"

class Search < ActiveRecord::Base
  include GoogleCustomSearchApi

  attr_accessible :domain, :terms, :image, :add_terms, :file_type, :must_have,
    :excluded_terms, :exact_terms

  after_initialize :build_query_string

  attr_accessor :domain, :terms, :image, :add_terms, :file_type, :must_have,
  :excluded_terms, :exact_terms, :query

  def search_google
    results = GoogleCustomSearchApi.search(query)
  end


  private

  def terms_to_query_string
    @terms = @terms.gsub(" ", "+") if @terms.present?
    @add_terms = @add_terms.gsub(" ", "+") if @add_terms.present?
    @must_have = @must_have.gsub(" ", "+") if @must_have.present?
    @excluded_terms = excluded_terms.gsub(" ", "+") if @excluded_terms.present?
    @exact_terms = exact_terms.gsub(" ", "+") if @exact_terms.present?
  end

  def build_query_string
    terms_to_query_string
    @query = ""
    query_hash = {
      q: (("q=#{terms}" if terms) || ""),
      hq: (("&hq=#{add_terms}" if add_terms) || ""),
      siteSearch: (("&siteSearch=#{domain}" if domain) || ""),
      searchType: (("&searchType=#{image}" if image) || ""),
      fileType: (("&fileType=#{file_type}" if file_type) || ""),
      orTerms: (("&orTerms=#{must_have}" if must_have) || ""),
      excludeTerms: (("&excludeTerms=#{excluded_terms}" if excluded_terms) || ""),
      exactTerms: (("&exactTerms=#{exact_terms}" if exact_terms) || "")
    }
    query_hash.each_pair do |k, v|
      @query << v
    end
  end

  def image?
    @image ||= false
  end
end
