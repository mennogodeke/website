class CvDownload < ApplicationRecord
  TOKEN_TTL     = 24.hours
  MAX_DOWNLOADS = 3

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
    requested_at.nil? || requested_at < TOKEN_TTL.ago
  end

  def maxed_out?
    download_count >= MAX_DOWNLOADS
  end

  def usable?
    !expired? && !maxed_out?
  end

  def record_download!
    update!(download_count: download_count + 1, last_download_at: Time.current)
  end

  private

  def set_timestamps
    self.requested_at = Time.current
    self.approved_at  = Time.current
  end
end
