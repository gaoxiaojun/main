require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'
require File.dirname(__FILE__) + '/shared/clone'

describe "Array#dup" do
  it_behaves_like :array_clone, :dup # FIX: no, clone and dup are not alike

  it "does not copy frozen status from the original" do
    a = [1, 2, 3, 4]
    b = [1, 2, 3, 4]
    a.freeze
    aa = a.dup
    bb = b.dup

    aa.frozen?.should be_false
    bb.frozen?.should be_false
  end

  it "does not copy singleton methods" do
    a = [1, 2, 3, 4]
    b = [1, 2, 3, 4]
    def a.a_singleton_method; end
    aa = a.dup
    bb = b.dup

    a.respond_to?(:a_singleton_method).should be_true
    b.respond_to?(:a_singleton_method).should be_false
    aa.respond_to?(:a_singleton_method).should be_false
    bb.respond_to?(:a_singleton_method).should be_false
  end
end
