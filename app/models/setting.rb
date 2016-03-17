class Setting < ApplicationRecord
  # ------------------------------------------------------------------
  # Attributes
  # ------------------------------------------------------------------
  attribute :ssh_key, :encryption

  # ------------------------------------------------------------------
  # Validations
  # ------------------------------------------------------------------
  validates :email, presence: true
  validates :ssh_key, presence: true
end
