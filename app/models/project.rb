class Project < ApplicationRecord
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  validates :name, presence: true
  validate :url_is_http,      if: -> { url.present? }
  validate :repo_url_is_http, if: -> { repo_url.present? }

  default_scope { order(position: :asc) }

  private

  def url_is_http
    errors.add(:url, "must be a valid HTTP or HTTPS URL") unless http_url?(url)
  end

  def repo_url_is_http
    errors.add(:repo_url, "must be a valid HTTP or HTTPS URL") unless http_url?(repo_url)
  end

  def http_url?(value)
    URI.parse(value).is_a?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end
