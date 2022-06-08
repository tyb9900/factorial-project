# frozen_string_literal: true

class MetricsTimelineService
  GROUPS = %w(minute hour day)

  DATE_FORMATS = {
    minute: '%Y-%m-%d %H:%M',
    hour: '%Y-%m-%d %H:00',
    day: '%Y-%m-%d 00:00'
  }.freeze

  def initialize(params)
    raise unless GROUPS.include? params[:avg_by] 
    
    @avg_by = params[:avg_by].downcase
  end

  def call
    timeline_range.merge(metrics_data)
  end

  private

  # This function will query the data from database
  def metrics_data
    Metric.query_by(@avg_by)
  end

  # This function will return the range of time steps from start of data to end.
  def timeline_range
    temp_hash = {}
    metrics = Metric.order(:timestamp)
    start_time = metrics.first.timestamp.to_f
    end_time = metrics.last.timestamp.to_f
    
    while start_time <= end_time
      formated_time = Time.at(start_time).utc.strftime(date_format)
      temp_hash[formated_time] = 0
      start_time += time_step
    end
    # temp_hash.shift
    temp_hash
  end

  def date_format
    format ||= DATE_FORMATS[@avg_by.to_sym]
  end

  def time_step
    @time_step ||=
      case @avg_by
      when 'day'
        86400 # 60*60*24 seconds in a day
      when 'hour'
        3600 # 60 * 60 seconds in an hour
      when 'minute'
        60
      end
  end
end
