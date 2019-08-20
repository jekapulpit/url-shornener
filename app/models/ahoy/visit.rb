# frozen_string_literal: true

class Ahoy::Visit < ApplicationRecord
  self.table_name = 'ahoy_visits'
  has_many :events, class_name: 'Ahoy::Event'
  geocoded_by :ip
end
