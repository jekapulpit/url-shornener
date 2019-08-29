class LinkShowSerializer < ActiveModel::Serializer
  attributes :link_hash, :original_link, :location_stats, :visits_number, :unique_visits_number

  def location_stats
    object.location_stats.as_json
  end

  def visits_number
    object.visits.count
  end

  def unique_visits_number
    object.unique_visits.count
  end
end
