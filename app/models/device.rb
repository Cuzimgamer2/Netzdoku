
class Device < ApplicationRecord
  belongs_to :contract

  VALID_STATUS = %w[running stopped waiting].freeze

  validates :status, inclusion: { in: VALID_STATUS }

  def update_status!(new_status)
    write_attribute(:status, new_status)
    save!
  end

  def status=(new_status)
    unless new_record?
      raise NoMethodError,
            "Status darf nur über update_status! geändert werden"
    end

    super
  end

  def show_routing_table
    "nicht verfügbar"
  end
end
