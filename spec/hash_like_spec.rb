require "spec_helper"
require "hash_like"

describe HashLike do
  context "When new" do
    let(:new_hash) { HashLike.new }

    it "it is empty" do
      new_hash.empty?.should be_true
    end

    it "has ten buckets" do
      new_hash.buckets.should eq 10
    end
  end

  describe "#[]=" do
    context "when adding an item" do
      let(:test_hash) { HashLike.new }

      it "increments count by one." do
        expect{test_hash["nines"] = 999}.to change{test_hash.count}.from(0).to(1)
      end
    end
  end
end
