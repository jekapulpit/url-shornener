class HttpUrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors.add(attribute, "it is not a valid HTTP URL")
    end
  end
end

class Link < ApplicationRecord
  visitable
  self.primary_key = 'link_hash'
  validates :link_hash, uniqueness: true, presence: true
  validates :original_link, http_url: true
end
