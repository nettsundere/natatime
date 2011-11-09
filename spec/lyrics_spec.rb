# Encoding: UTF-8
require 'spec_helper'

module Natatime
  describe Lyrics do
    before :each do
      @redis = Spec::redis_connect 
      @redis.flushall
      store = Store.new @redis
      
      %w{депутат военкомат компромат автомат штат}.each {|i| store.add_at! i}
      %w{дверь окно внучка ручка тучка}.each {|i| store.add_noun! i}
      %w{скорая новая красная}.each {|i| store.add_adjective! i}
      %w{лопата вата дата}.each {|i| store.add_ata! i}
       
      @lyr_gen = Lyrics.new store 
    end
    
    after(:each) { Spec::redis_disconnect @redis }
    
    describe "#compose" do
      it "should compose lyrics for the required format" do
        composed = @lyr_gen.compose :at, :at, :at, :at, :at, :ata
        composed.should have(6).grep(/ата$/)
      end
      
      it "should raise an error when unsupported line format specified" do
        lambda { @lyr_gen.compose :at, :bad_format }.should raise_error
      end
    end
  end
end
