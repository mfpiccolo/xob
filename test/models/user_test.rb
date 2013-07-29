require 'minitest_helper'

describe User do

  describe "validations" do

    it { must have_many(:searches) }
  end

end
