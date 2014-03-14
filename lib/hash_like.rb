require 'digest/md5'

class HashLike

  attr_reader :count

  def initialize( buckets: 10)
    @count = 0;
    @buckets = Array.new(buckets) { Array.new }

  end

  def empty?
    true if @count <= 0
  end

  def buckets
    @buckets.count
  end

  def []=(key, value)
    return nil if key == nil
    digest = make_digest key
    bucket = get_bucket digest
    @buckets[bucket] = [key, value]

  end

private

  def get_bucket digest
    digest % @buckets.count
  end

  def make_digest str
    Digest::MD5.hexdigest(str)
  end
end
