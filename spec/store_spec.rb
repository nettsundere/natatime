# Encoding: UTF-8
require 'spec_helper'

module Natatime
  describe Natatime do
    before :each do
      @@redis.flushall
      @st = Store.new @@redis
    end  
    
    describe "#new" do      
      it "should be empty after the initialize" do
        @st.words_count.should be 0
      end      
    end
    
    describe "Fill process" do
      describe "#add_at!" do
        it "should add at_word and 'а' letter to the end of it; at word should be in lowercase" do
          @st.add_at! "ДепуТат"
          @st.add_at! "КомпрОмат"
          @st.load_ats(2).should =~ %w{депутата компромата}
        end
        
        it "should increase words count" do
          expect { @st.add_at! "штат" }.to change(@st, :words_count).from(0).to(1) 
        end
        
        it "should raise an error when (maximum + 1) of elements requested" do
          lambda { @st.load_ats(3) }.should raise_error
        end
      end

      describe "#add_ata!" do
        it "should add ata_word; ata word should be in lowercase" do
          @st.add_ata! "лОпАта"
          @st.load_atas(1).should == %w{лопата}   
        end
        
        it "should increase words count" do
          expect { @st.add_ata! "лопата" }.to change(@st, :words_count).from(0).to(1) 
        end
        
        it "should raise an error when (maximum + 1) of elements requested" do
          lambda { @st.load_atas(2) }.should raise_error
        end
      end
    
      describe "#add_noun" do
        it "should add noun word; noun word should be in lowercase" do
          @st.add_noun! "дВерь"
          @st.load_nouns(1).should == %w{дверь}   
        end
        
        it "should increase words count" do
          expect { @st.add_noun! "лопата" }.to change(@st, :words_count).from(0).to(1) 
        end
        
        it "should raise an error when (maximum + 1) of elements requested" do
          lambda { @st.load_nouns(2) }.should raise_error
        end
      end

      describe "#add_adjective!" do
        it "should add adjective word and change 2 symbols (ый,ой,ее) in the end to the 'ая'; 
            adjective should be in lowercase" do
          @st.add_adjective! "острый"
          @st.add_adjective! "звездный"
          @st.load_adjectives(2).should =~ %w{острая звездная}        
        end
        
        it "should increase words count" do
          expect { @st.add_adjective! "звездный" }.to change(@st, :words_count).from(0).to(1) 
        end
        
        it "should raise an error when (maximum + 1) of elements requested" do
          lambda { @st.load_adjectives(3) }.should raise_error
        end
      end
    end
    
    describe "Loading" do
      describe "#load_ats" do
        before :each do
          @stored_items = %w{депутат солдат компромат военкомат автомат}
          @stored_items.each {|item| @st.add_at! item}
        end
      
        it "should fail when specified negative count" do
          lambda { @st.load_ats(-1) }.should raise_error
        end
        
        it "should load required count of words" do
          @st.should have(3).load_ats(3)
        end
      end
      
      describe "#load_atas" do  
        before :each do
          @stored_items = %w{лопата хата -+=,!!}
          @stored_items.each {|item| @st.add_ata! item}
        end
      
        it "should fail when specified negative count" do
          lambda { @st.load_atas(-1) }.should raise_error
        end
        
        it "should load required count of words" do
          @st.should have(2).load_atas(2)
        end
      end  
      
      describe "#load_nouns" do
        before :each do
          @stored_items = %w{дверь окно}
          @stored_items.each {|item| @st.add_noun! item}
        end
          
        it "should fail when specified negative count" do
          lambda { @st.load_nouns(-1) }.should raise_error
        end
        
        it "should load required count of words" do
          @st.should have(2).load_nouns(2)
        end
      end 
      
      describe "#load_adjectives" do  
        before :each do
          @stored_items = %w{красивый красный скоростной}
          @stored_items.each {|item| @st.add_adjective! item}
        end
          
        it "should fail when specified negative count" do
          lambda { @st.load_adjectives(-1) }.should raise_error
        end
        
        it "should load required count of words" do
          @st.should have(2).load_adjectives(2)
        end
      end      
    end
  end
end
