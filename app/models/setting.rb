class Setting < ApplicationRecord
  # ------------------------------------------------------------------
  # Validations
  # ------------------------------------------------------------------
  validates :email, presence: true
end
