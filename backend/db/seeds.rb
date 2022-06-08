# frozen_string_literal: true

Metric.create(name: 'First', value: 10, timestamp: 1.hour.ago)
Metric.create(name: 'Second', value: 20, timestamp: 3.minute.ago)
Metric.create(name: 'Third', value: 30, timestamp: 5.minutes.ago)
