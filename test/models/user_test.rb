require 'minitest_helper'

describe User do
  subject { User.new }
  it { must have_many(:searches) }
end
