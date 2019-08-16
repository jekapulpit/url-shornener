class ShortLinkService
  attr_reader :original_link, :hash_algorithm, :link_instance

  def initialize(original_link, hash_algorithm = Digest::SHA256.new)
    @original_link = original_link
    @hash_algorithm = hash_algorithm
    @link_instance = (Link.find_by(original_link: original_link) || Link.new(original_link: original_link))
  end

  def call
    generate_link_instance while link_instance.invalid?
    link_instance.save ? link_instance : link_instance.errors
  end

  def generate_link_instance
    link_instance.link_hash = generate_short_hash
  end

  def generate_short_hash
    (hash_algorithm.hexdigest original_link).slice(0,7)
  end
end