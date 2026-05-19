class CvDownload < ApplicationRecord
  has_secure_token :token

  enum :role, {
    frontend: 0,
    backend:  1,
    fullstack: 2,
    devops:   3,
    platform: 4,
    apps:     5,
    default:  6
  }

  enum :language, {
    en: 0,
    nl: 1,
    de: 2
  }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_create :set_timestamps

  def expired?
    requested_at < 24.hours.ago
  end

  def record_download!
    increment!(:download_count)
    update!(last_download_at: Time.current)
  end

  private

  def set_timestamps
    self.requested_at = Time.current
    self.approved_at  = Time.current
  end
end
