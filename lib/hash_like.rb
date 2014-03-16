
class HashLike

  attr_reader :count

  def initialize
    @count = 0;
    @buckets = Array.new(1039) { Array.new }
  end

  def empty?
    true if @count <= 0
  end

  def delete(key)
    if keys.include?(key)
      bucket_item = get_bucket_item(key)
      @buckets[get_bucket_index(key)].delete(bucket_item)
    else
      return false
    end
  end

  def keys
    key_list = []
    @buckets.each do |bucket|
      bucket.each { |item| key_list << item.first }
    end
    key_list
  end

  def [](key)
    if (bucket_item = get_bucket_item(key))
      bucket_item[1]
    else
      nil
    end
  end

  def []=(key, value)
    return nil if key == nil
    bucket = get_bucket_index(key)

    if (bucket_item = get_bucket_item(key))
      bucket_item[1] = value
    else
      @buckets[bucket] << [key, value]
      @count += 1
    end
  end

private

  def get_bucket_item(key)
    bucket_index = get_bucket_index(key)
    @buckets[bucket_index].each do |bucket_item|
      if bucket_item.first == key
        return bucket_item
      end
    end
    false
  end

  def get_bucket_index(key)
    key.hash % @buckets.count
  end
end
