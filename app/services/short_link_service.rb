# frozen_string_literal: true

class ShortLinkService
  LINK_HASH_SIZE = 7

  def initialize(original_link, hash_algorithm = Digest::SHA256.new)
    @original_link = original_link
    @hash_algorithm = hash_algorithm
    @link_instance = Link.find_or_create_by(original_link: original_link)
  end

  def call
    if record_not_found?
      loop do
        set_link_hash
        break unless collision?
        shuffle_original_link
      end
      @link_instance.save
    end
    @link_instance
  end

  private

  def record_not_found?
    @link_instance.link_hash.nil?
  end

  def shuffle_original_link
    @original_link = @original_link.chars.shuffle.join
  end

  def set_link_hash
    @link_instance.link_hash = generate_short_hash
  end

  def generate_short_hash
    (@hash_algorithm.hexdigest @original_link).slice(0, LINK_HASH_SIZE - 1)
  end

  def collision?
    @link_instance.invalid? && @link_instance.errors[:original_link].none?
  end
end
