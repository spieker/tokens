require 'spec_helper'

describe ActiveRecord::Mixin::TokenGenerator do
  before :each do
    @klass = TokenTest.dup
  end

  it "geneates a token" do
    SecureRandom.stub(:random_number).and_return(0)
    @klass.tokenize :token
    @klass.create.token.should == 'aaaaaaaa'
  end
  
  it "raises an exception if no free token is available" do
    SecureRandom.stub(:random_number).and_return(0)
    @klass.tokenize :token
    @klass.create.token.should == 'aaaaaaaa'
    expect {
      @klass.create
    }.to raise_error(NoFreeToken)
  end

  it "generates duplicate tokens if allowed" do
    SecureRandom.stub(:random_number).and_return(0)
    @klass.tokenize :token, :uniq => false
    @klass.create.token.should == 'aaaaaaaa'
    @klass.create.token.should == 'aaaaaaaa'
  end
  
  it "generates duplicate tokens in different scopes if allowed" do
    SecureRandom.stub(:random_number).and_return(0)
    @klass.tokenize :token, :scope => 'scope'
    @klass.create(:scope => 'a').token.should == 'aaaaaaaa'
    @klass.create(:scope => 'b').token.should == 'aaaaaaaa'
  end

  it "generates tokens with the specified length" do
    (6..32).each do |i|
      @klass = TokenTest.dup
      @klass.tokenize :token, :length => i
      10.times do
        @klass.create.token.length.should == i
      end
    end
  end

  it "generates different tokens for different columns" do
    @klass.tokenize [:token, :token_two]
    r = @klass.create!
    r.token.should_not == r.token_two
  end

  it "generates the same token for two columns if specified" do
    @klass.tokenize [:token, :token_two], :same_token => true
    r = @klass.create!
    r.token.should == r.token_two
  end

  it "generates tokens from the given character map" do
    SecureRandom.stub(:random_number).and_return(0)
    @klass.tokenize :token, :characters => ['x']
    @klass.create.token.should == 'xxxxxxxx'
  end
end
