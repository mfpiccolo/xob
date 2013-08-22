require "spec_helper"

describe Search, :vcr do

  describe "#search" do

    it "returns a hash of info" do
      search_results = Search.new(required_terms: "lebron", google: "google", twitter: "twitter").search
      search_results[:google_results]["items"].first["title"]
        .should eq "LeBron James - Wikipedia, the free encyclopedia"
    end
  end

  describe "#save_search" do
    let(:json) { "{\"google0\":{\"value\":\"google\",\"left\":60.9375,\"top\":262.671875,\"parent_id\":\"whole-page\"},\"twitter1\":{\"value\":\"twitter\",\"left\":60.9375,\"top\":477.59375,\"parent_id\":\"whole-page\"},\"domain2\":{\"value\":\"\",\"left\":121.890625,\"top\":135.3125,\"parent_id\":\"whole-page\"},\"image3\":{\"value\":\"image\",\"left\":121.890625,\"top\":183.078125,\"parent_id\":\"whole-page\"},\"file_type4\":{\"value\":null,\"left\":121.890625,\"top\":230.828125,\"parent_id\":\"whole-page\"},\"result_type5\":{\"value\":null,\"left\":121.890625,\"top\":469.625,\"parent_id\":\"whole-page\"},\"must_have6\":{\"value\":\"\",\"left\":121.890625,\"top\":278.59375,\"parent_id\":\"whole-page\"},\"excluded_terms7\":{\"value\":\"\",\"left\":121.890625,\"top\":326.359375,\"parent_id\":\"whole-page\"},\"exact_terms8\":{\"value\":\"\",\"left\":121.890625,\"top\":374.109375,\"parent_id\":\"whole-page\"},\"required_terms9\":{\"value\":\"\",\"left\":539.890625,\"top\":271.875,\"parent_id\":\"new_search\"},\"name\":\"lskdfj slkdfj\"}" }

    it "saves the search with draggables" do
      search = Search.new
      search.save_search(json)
      Search.last.draggables.should eq json
    end
  end
end
