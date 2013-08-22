require "spec_helper"

describe SearchesController do
  describe "GET new" do
    let(:user) { double }
    before do
      User.should_receive(:new).and_return(user)
      get :new
    end

    it { should respond_with(:success) }

    it "should set user and search" do
      assigns[:user].should eq user
      assigns[:search].class.name.should eq "Search"
    end

  end

  # TODO remote: true tests wont work with rspec. Capybara maybe?
  # describe "POST create" do
  #   let(:search) { build(:search) }

  #   before do
  #     search.should_receive(:search)
  #     Search.should_receive(:new).and_return(search)

  #     xhr :post, :create, search: { required_terms: "something", google: "google" }
  #   end

  #   it { should render_template(:partial => '_google_search_results') }

  #   it "redirects to root path" do
  #     response.should eq 200
  #     assigns[:service].should eq "google"
  #   end
  # end
end
