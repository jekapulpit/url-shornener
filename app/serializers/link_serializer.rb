class LinkSerializer < ActiveModel::Serializer
  attributes :link_hash, :original_link, :visits_number, :unique_visits_number
end
