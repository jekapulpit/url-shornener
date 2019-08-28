# frozen_string_literal: true

class Link < ApplicationRecord
  self.primary_key = 'link_hash'
  validates :link_hash, uniqueness: true, presence: true
  validates :original_link, http_url: true
  has_many :visits, foreign_key: :link_hash, class_name: 'Ahoy::Visit'

  def unique_visits
    visits.pluck(:ip).uniq
  end
end
