# frozen_string_literal: true

class CreateMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :metrics do |t|
      t.string :name, null: false
      t.float :value, null: false
      t.datetime :timestamp, null: false

      t.timestamps
    end
  end
end
