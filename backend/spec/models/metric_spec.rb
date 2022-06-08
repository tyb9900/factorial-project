require 'rails_helper'

RSpec.describe Metric, type: :model do
    subject {Metric.new(name:'Metric name', value: 10.0, timestamp:1.day.ago)}
    
    before {subject.save}

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :value }
    it { is_expected.to validate_presence_of :timestamp }

  end