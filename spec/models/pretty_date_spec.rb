require 'spec_helper'

describe PrettyDate do
  it "should raise error if style not present" do
    lambda{ PrettyDate.style(Time.now).with(99999) }.should raise_error
  end

  it "should raise error if style already registered" do
    lambda{ PrettyDate.register_style(1, proc {}) }.should raise_error
  end

  it "should return style 1" do
    style = "12:45pm"
    date  = DateTime.parse '27/05/2012 12:45'
    PrettyDate.style(date).with(1).should eq style
  end

  it "should return style 2" do
    style = "05.27.2012"
    date  = DateTime.parse '27/05/2012 12:45'
    PrettyDate.style(date).with(2).should eq style
  end

  it "should return style 3" do
    style = "05.27.2012 12:45pm"
    date  = DateTime.parse '27/05/2012 12:45'
    PrettyDate.style(date).with(3).should eq style
  end


  it "should return style 4" do
    style = "27.05.2012"
    date  = DateTime.parse '27/05/2012 12:45'
    PrettyDate.style(date).with(4).should eq style
  end

  it "should return style 5" do
    style = "27.05.2012 12:45pm"
    date  = DateTime.parse '27/05/2012 12:45'
    PrettyDate.style(date).with(5).should eq style
  end

  it "should return style 6 if not on the hour" do
    style = "12:45pm"
    date  = DateTime.parse '27/05/2012 12:45'
    PrettyDate.style(date).with(6).should eq style
  end

  it "should return style 6 when in the afternoon" do
    style = "12 o'clock"
    date  = DateTime.parse '27/05/2012 12:00'
    PrettyDate.style(date).with(6).should eq style
  end

  it "should return style 6 when in the moring" do
    style = "11 o'clock in the morning"
    date  = DateTime.parse '27/05/2012 11:00'
    PrettyDate.style(date).with(6).should eq style
  end

  it "should return style 6" do
    style = "Friday 6th January 2012"
    date  = DateTime.parse '06/01/2012 16:15'
    PrettyDate.style(date).with(7).should eq style
  end

  it "should return style 8" do
    style = "4:15pm, Friday 6th January 2012"
    date  = DateTime.parse '06/01/2012 16:15'
    PrettyDate.style(date).with(8).should eq style
  end
end
