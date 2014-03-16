require "spec_helper"
require "hash_like"

describe HashLike do
  context "When new" do
    let(:new_hash) { HashLike.new }

    it "it is empty" do
      new_hash.empty?.should be_true
    end
  end

  describe "#[]=" do
    context "when adding an item" do
      let(:test_hash) { HashLike.new }

      it "increments count by one." do
        expect{test_hash["nines"]= 999}.to change{test_hash.count}.from(0).to(1)
      end
    end
  end

  describe "#[]" do
    let(:test_hash) { HashLike.new }

    it "retrieves the correct key" do
      test_hash["one"] = 1
      test_hash["two"] = 2
      test_hash["three"] = "banana"
      test_hash["two"] = []

      test_hash["three"].should == "banana"
    end
  end

  describe "#delete" do
    let(:test_hash) { HashLike.new }

    before do
      test_hash["one"] = 1
      test_hash["two"] = 2
      test_hash["three"] = "banana"
      test_hash["two"] = []
    end

    it "deletes the correct bucket item" do
      test_hash.delete("three").should == ["three", "banana"]
    end

    it "returns false if key doesn't exist" do
      test_hash.delete("ten").should be_false
    end
  end

  describe "#keys" do
    context "After adding an item."
    let(:test_hash) { HashLike.new }

    it "has a key for that item" do
      test_hash["testing"] = 123
      expect(test_hash.keys).to include("testing")
    end

    it "the count for keys matches the count for the object" do
    test_hash["one"] = 1
    test_hash["two"] = 2
    test_hash.count.should eq(test_hash.keys.count)
    end
  end
end
