require "./lib/google_custom_search_api.rb"

class Search < ActiveRecord::Base
  include GoogleCustomSearchApi

  attr_accessible :domain, :terms, :image, :add_terms, :file_type, :must_have

  after_initialize :build_query_string

  attr_accessor :domain, :terms, :image, :add_terms, :file_type, :must_have, :query

  def search_google
    results = GoogleCustomSearchApi.search(query)
  end


  private

  def terms_to_query_string
    @terms = @terms.gsub(" ", "+") if @terms.present?
    @add_terms = @add_terms.gsub(" ", "+") if @add_terms.present?
    @must_have = @must_have.gsub(" ", "_") if @must_have.present?
  end

  def build_query_string
    terms_to_query_string
    @query = ""
    query_hash = {
      terms_q: (("q=#{terms}" if terms) || ""),
      add_terms_q: (("&hq=#{add_terms}" if add_terms) || ""),
      domain_q: (("&siteSearch=#{domain}" if domain) || ""),
      image_q: (("&searchType=#{image}" if image) || ""),
      file_type_q: (("&fileType=#{file_type}" if file_type) || ""),
      must_have_q: (("&orTerms=#{must_have}" if must_have) || "")
    }
    query_hash.each_pair do |k, v|
      @query << v
    end
  end

  def image?
    @image ||= false
  end
end
