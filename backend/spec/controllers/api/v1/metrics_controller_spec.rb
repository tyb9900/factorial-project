require 'rails_helper'

RSpec.describe Api::V1::MetricsController do
  describe "GET #index" do
    let!(:metric_day_1) { create(:metric, value: 20, timestamp: Time.zone.parse('2022-05-05 00:00'))  }

    it "returns the metrics timeline response" do
      %w(minute hour day).each do |avg_by|
        get :index, params: { avg_by: avg_by, format: :json}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({"2022-05-05 00:00"=>"20.0"})
      end
    end

    it "returns error response if no params given" do
      expect { get :index }.to raise_exception
    end
  end

  describe "POST #create" do
    it "returns sucess and metrics object" do
      post :create, params: { name: 'first_metric', value: 10, timestamp: Time.zone.parse('2022-05-05 00:00') }
      expect(response).to have_http_status(:success)
    end
  end
end
