# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 20 }
end
