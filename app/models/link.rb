class Link < ApplicationRecord
  self.primary_key = 'link_hash'
  validates :link_hash, uniqueness: true
end
