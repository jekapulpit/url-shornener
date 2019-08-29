# frozen_string_literal: true

class Link < ApplicationRecord
  self.primary_key = 'link_hash'
  validates :link_hash, uniqueness: true, presence: true
  validates :original_link, http_url: true
  has_many :visits, foreign_key: :link_hash, class_name: 'Ahoy::Visit'

  def unique_visits
    visits.pluck(:ip).uniq
  end

  def specific_visit_stats
    attributes.merge({
        visits_number: visits.length,
        unique_visits_number: unique_visits.length
                     })
  end

  def location_stats
    visits
        .select('ahoy_visits.country as country, count(ahoy_visits.id) as times_redirected')
        .group(:country, :link_hash).order('times_redirected desc').limit(3)
  end

  scope :visits_left_join, -> { joins('left join ahoy_visits on links.link_hash = ahoy_visits.link_hash') }

  scope :with_visit_stats, -> { visits_left_join
                                     .select('links.*, count(ahoy_visits.ip) as visits_number, count(DISTINCT ahoy_visits.ip) as unique_visits_number')
                                     .group(:original_link, :link_hash, :created_at, :updated_at)
                                     .order('visits_number desc') }
  scope :paginate, ->(start_index, end_index) { limit(end_index - start_index).offset(start_index) }
end
