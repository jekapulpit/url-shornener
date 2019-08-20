class LinkSerializer < ActiveModel::Serializer
  attributes :link_hash, :original_link, :visits_number, :creations_number, :unique_visits_number

  def visits_number
    object.visits.count
  end

  def creations_number
    object.creations.count
  end

  def unique_visits_number
    object.unique_visits.count
  end
end
