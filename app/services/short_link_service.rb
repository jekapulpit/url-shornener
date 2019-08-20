# frozen_string_literal: true

class ShortLinkService
  def initialize(original_link, hash_algorithm = Digest::SHA256.new)
    @original_link = original_link
    @hash_algorithm = hash_algorithm
    @link_instance = Link.find_or_create_by(original_link: original_link)
  end

  def call
    update_link_hash while collision?
    @link_instance.save
    @link_instance
  end

  private

  def update_link_hash
    @link_instance.link_hash = generate_short_hash
  end

  def generate_short_hash
    (@hash_algorithm.hexdigest @original_link.chars.shuffle.join).slice(0, 6)
  end

  def collision?
    @link_instance.invalid? && @link_instance.errors[:original_link].none?
  end
end
