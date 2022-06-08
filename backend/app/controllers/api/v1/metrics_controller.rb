# frozen_string_literal: true

module Api
  module V1
    class MetricsController < ApplicationController
      def index
        metrics = MetricsTimelineService.new(params).call
        render json: metrics
      end

      def create
        metric = Metric.new(metric_params)
        if metric.save
          render json: { success: 200, metric: metric }, status: 200
        else
          render json: { error: 500, message: 'Internal Server Error' }, status: 500
        end
      end

      private

      def metric_params
        params.permit(:name, :value, :timestamp)
      end
    end
  end
end
