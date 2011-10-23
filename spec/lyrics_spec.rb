# Encoding: UTF-8
require 'spec_helper'
module Natatime
  describe Lyrics do

    before :each do
      @@redis.flushall
      @store = Store.new @@redis
      @store.add_at! "депутат"
      @store.add_at! "военкомат"      
    end      

    describe "#compose" do      
      before :each do
        @lyrics = Lyrics.new @store
      end
      
      it "should raise an error when negative lines count required" do
        lambda { @lyrics.compose(-1) }.should raise_error
      end 
      
      it "should return required number of lines" do
        @lyrics.compose(10).should have(10).items
      end
    end
  end
end
