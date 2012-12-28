require 'spec_helper'

describe Object do
  it "returns 8 a's if only a is given as character list" do
    new_token(8, ['a']).should == 'aaaaaaaa'
  end

  it "returns 'bbbbbbbb' if random_number retruns 1" do
    SecureRandom.stub(:random_number).and_return(1)
    new_token.should == 'bbbbbbbb'
  end

  it "returns a random string with the given length" do
    32.times do |i|
      100.times do
        new_token(i).length.should == i
      end
    end
  end
end

