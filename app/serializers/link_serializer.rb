class LinkSerializer < ActiveModel::Serializer
  attributes :link_hash, :original_link, :visits_number, :unique_visits_number

  def visits_number
    object.visits.length
  end

  def unique_visits_number
    object.unique_visits.length
  end
end
