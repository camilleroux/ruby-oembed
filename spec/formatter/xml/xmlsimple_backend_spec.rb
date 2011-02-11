require File.dirname(__FILE__) + '/../../spec_helper'

describe "OEmbed::Formatter::XML::Backends::XmlSimple" do
  include OEmbedSpecHelper

  before(:all) do
    # At the moment the xmlsimple gem is required in serveral other tests,
    # causing this assertion to fail when the whole suite is run.
    #lambda {
    #  OEmbed::Formatter::XML.backend = 'XmlSimple'
    #}.should raise_error(LoadError)
    
    require 'xmlsimple'
    
    lambda {
      OEmbed::Formatter::XML.backend = 'XmlSimple'
    }.should_not raise_error
  end

  it "should support XML" do
    proc { OEmbed::Formatter.support?(:xml) }.
    should_not raise_error(OEmbed::FormatNotSupported)
  end
  
  it "should be using the XmlSimple backend" do
    OEmbed::Formatter::XML.backend.should == OEmbed::Formatter::XML::Backends::XmlSimple
  end
  
  it "should decode an XML String" do
    decoded = OEmbed::Formatter.decode(:xml, valid_response(:xml))
    # We need to compare keys & values separately because we don't expect all
    # non-string values to be recognized correctly.
    decoded.keys.should == valid_response(:object).keys
    decoded.values.map{|v|v.to_s}.should == valid_response(:object).values.map{|v|v.to_s}
  end
end