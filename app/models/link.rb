# frozen_string_literal: true

class HttpUrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && uri.host.presence
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors.add(attribute, 'it is not a valid HTTP URL')
    end
  end
end

class Link < ApplicationRecord
  self.primary_key = 'link_hash'
  validates :link_hash, uniqueness: true, presence: true
  validates :original_link, http_url: true

  def visits
    Ahoy::Event.where(properties: { 'title' => 'redirection event', 'link_hash' => link_hash })
  end

  def creations
    Ahoy::Event.where(properties: { 'title' => 'link creation event', 'link_hash' => link_hash })
  end

  def unique_visits
    Ahoy::Event.joins(:visit)
        .select('DISTINCT ahoy_visits.ip')
        .where(name: 'visit', properties: { 'title' => 'redirection event', 'link_hash' => link_hash })
        .order(:ip)
  end

  def with_visit_stats
    attributes.merge(
      visits_number: visits.count,
      creations_number: creations.count,
      unique_visits_number: unique_visits.count,
    )
  end
end
