# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)
require "freeling_ruby"

describe WStringTest do
  it "should convert an UTF-8 Ruby String into a wstring" do
    assert_equal "olé", WStringTest.test_wstring_from_ruby("olé")
  end

  it "should convert a wstring into an UTF-8 Ruby String" do
    assert_equal "おはよう", WStringTest.test_wstring_to_ruby
  end
end
