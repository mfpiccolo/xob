require "./lib/google_custom_search_api.rb"

class Search < ActiveRecord::Base
  include GoogleCustomSearchApi

  belongs_to :user

  attr_accessible :domain, :terms, :image, :add_terms, :file_type, :must_have,
    :excluded_terms, :exact_terms, :google, :twitter, :result_type

  after_initialize :set_services, :build_query_string

  attr_accessor :domain, :terms, :image, :add_terms, :file_type, :must_have,
    :excluded_terms, :exact_terms, :google, :twitter, :services, :result_type, :google_query,
    :twitter_terms, :twitter_options

  def search
    {
      google_results: (GoogleCustomSearchApi.search(google_query) unless google_query.blank?),
      twitter_results: (Twitter.search(twitter_terms, twitter_options) unless twitter_terms.blank?)
    }
  end


  private

  def terms_to_query_string
    @terms = @terms.gsub(" ", "+") if @terms.present?
    @add_terms = @add_terms.gsub(" ", "+") if @add_terms.present?
    @must_have = @must_have.gsub(" ", "+") if @must_have.present?
    @excluded_terms = excluded_terms.gsub(" ", "+") if @excluded_terms.present?
    @exact_terms = exact_terms.gsub(" ", "+") if @exact_terms.present?
  end

  def set_services
    if google && twitter
      @services = [google, twitter]
    elsif google
      @services = [google]
    elsif twitter
      @services = [twitter]
    end
  end

  def build_query_string
    terms_to_query_string
    @google_query = ""
    @twitter_query = ""
    unless services.blank?
      @services.each do |service|
        if service == "twitter"
          @twitter_terms = ((terms if terms) || "")

          @twitter_options = {
            result_type: ((result_type if result_type) || "")
          }

        elsif service == "google"
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
            @google_query << v
          end
        end
      end
    end
  end

  def image?
    @image ||= false
  end
end
