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
  self.primary_key = 'link_hash'
  validates :link_hash, uniqueness: true, presence: true
  validates :original_link, http_url: true

  def visits
    Ahoy::Event.where(properties: {"title"=>"redirection event", "link_hash"=>link_hash})
  end

  def creations
    Ahoy::Event.where(properties: {"title"=>"link creation event", "link_hash"=>link_hash})
  end

  def with_visit_stats
    attributes.merge({
        visits_number: visits.count,
        creations_number: creations.count
                     })
  end
end
