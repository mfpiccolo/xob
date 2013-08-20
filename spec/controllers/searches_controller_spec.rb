require "spec_helper"

describe SearchesController do
  describe "GET new" do
    before do
      get :new
    end

    it { should respond_with(:success) }
  end
end
