# frozen_string_literal: true

class Metric < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true
  validates :timestamp, presence: true

  DATE_FORMATS = {
    minute: 'yyyy-mm-dd hh24:mi',
    hour: 'yyyy-mm-dd hh24:00',
    day: 'yyyy-mm-dd 00:00'
  }.freeze

  def self.query_by(avg)
    group("to_char(timestamp, '#{DATE_FORMATS[avg.to_sym]}')")
      .average(:value)
  end
end
