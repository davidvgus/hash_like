require 'digest/md5'

class HashLike

  attr_reader :count

  def initialize
    @count = 0;
    @buckets = Array.new(1039) { Array.new }
  end

  def empty?
    true if @count <= 0
  end

  def buckets
    @buckets.count
  end

  def keys
    key_list = []
    @buckets.each do |bucket|
      bucket.each { |item| key_list << item.first }
    end
    key_list
  end

  def [](key)
    if (bucket_item = key_exists key)
      bucket_item[1]
    else
      nil
    end
  end

  def []=(key, value)
    return nil if key == nil
    digest = make_digest(key)
    bucket = get_bucket(digest)

    if (bucket_item = key_exists(key))
      bucket_item[1] = value
    else
      @buckets[bucket] << [key, value]
      @count += 1
    end
  end

private

  def key_exists(key)
    digest = make_digest(key)
    bucket = get_bucket(digest)
    @buckets[bucket].each do |bucket_item|
      if bucket_item.first == key
        return bucket_item
      end
    end
    false
  end

  def get_bucket(digest)
    digest % @buckets.count
  end

  def make_digest(str)
    Digest::MD5.hexdigest(str).to_i(16)
  end
end
