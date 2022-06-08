require 'rails_helper'

RSpec.describe MetricsTimelineService, type: :model do
  describe '#call method' do
let(:metric_day_1) { create(:metric, value: 10, timestamp: Time.zone.parse('2022-05-05 00:00'))  }
    let(:metric_day_2) { create(:metric, value: 5, timestamp: Time.zone.parse('2022-05-05 03:45'))  }
    let(:metric_day_3) { create(:metric, value: 10, timestamp: Time.zone.parse('2022-05-07 00:00'))  }

    let(:metric_hour_1) { create(:metric, value: 10, timestamp: Time.zone.parse('2022-05-05 00:00'))  }
    let(:metric_hour_2) { create(:metric, value: 5, timestamp: Time.zone.parse('2022-05-05 00:15'))  }
    let(:metric_hour_3) { create(:metric, value: 10, timestamp: Time.zone.parse('2022-05-05 02:00'))  }

    let(:metric_minute_1) { create(:metric, value: 10, timestamp: Time.zone.parse('2022-05-05 00:00'))  }
    let(:metric_minute_2) { create(:metric, value: 5, timestamp: Time.zone.parse('2022-05-05 00:02'))  }
    let(:metric_minute_3) { create(:metric, value: 10, timestamp: Time.zone.parse('2022-05-05 00:02'))  }

    let(:avg_by_day_params) { { avg_by: 'day'} }
    let(:avg_by_hour_params) { { avg_by: 'hour'} }
    let(:avg_by_minute_params) { { avg_by: 'minute'} }

    it "works average by days" do
      metric_day_1
      metric_day_2
      metric_day_3

      hsh = described_class.new(avg_by_day_params).call
       expect(hsh).to eq({"2022-05-05 00:00"=>0.75e1, "2022-05-06 00:00"=>0, "2022-05-07 00:00"=>0.1e2})
    end

    it "works average by hours" do
      metric_hour_1
      metric_hour_2
      metric_hour_3

      hsh = described_class.new(avg_by_hour_params).call
      expect(hsh).to eq({"2022-05-05 00:00"=>0.75e1, "2022-05-05 01:00"=>0, "2022-05-05 02:00"=>0.1e2})
    end

    it "works average by minutes" do
      metric_minute_1
      metric_minute_2
      metric_minute_3

      hsh = described_class.new(avg_by_minute_params).call
      expect(hsh).to eq({"2022-05-05 00:00"=>0.1e2, "2022-05-05 00:01"=>0, "2022-05-05 00:02"=>0.75e1})
    end
  end
end
