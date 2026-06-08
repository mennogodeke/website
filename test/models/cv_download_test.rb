require "test_helper"

class CvDownloadTest < ActiveSupport::TestCase
  test "valid with email" do
    cv_download = CvDownload.new(email: "user@example.com")
    assert cv_download.valid?
  end

  test "invalid without email" do
    cv_download = CvDownload.new
    assert_not cv_download.valid?
  end

  test "invalid with malformed email" do
    cv_download = CvDownload.new(email: "not-an-email")
    assert_not cv_download.valid?
  end

  test "generates a unique token on create" do
    cv_download = CvDownload.create!(email: "new@example.com")
    assert_not_nil cv_download.token
  end

  # expired?

  test "expired? returns false for recent record" do
    cv_download = cv_downloads(:one)
    cv_download.requested_at = 1.hour.ago
    assert_not cv_download.expired?
  end

  test "expired? returns true for old record" do
    cv_download = cv_downloads(:one)
    cv_download.requested_at = 25.hours.ago
    assert cv_download.expired?
  end

  test "expired? returns true when requested_at is nil" do
    cv_download = cv_downloads(:one)
    cv_download.requested_at = nil
    assert cv_download.expired?
  end

  # maxed_out?

  test "maxed_out? returns false below the download cap" do
    cv_download = cv_downloads(:one)
    cv_download.download_count = CvDownload::MAX_DOWNLOADS - 1
    assert_not cv_download.maxed_out?
  end

  test "maxed_out? returns true at the download cap" do
    cv_download = cv_downloads(:one)
    cv_download.download_count = CvDownload::MAX_DOWNLOADS
    assert cv_download.maxed_out?
  end

  # usable?

  test "usable? returns true when not expired and not maxed out" do
    cv_download = cv_downloads(:one)
    cv_download.requested_at = 1.hour.ago
    cv_download.download_count = 0
    assert cv_download.usable?
  end

  test "usable? returns false when expired" do
    cv_download = cv_downloads(:one)
    cv_download.requested_at = 25.hours.ago
    assert_not cv_download.usable?
  end

  test "usable? returns false when maxed out" do
    cv_download = cv_downloads(:one)
    cv_download.requested_at = 1.hour.ago
    cv_download.download_count = CvDownload::MAX_DOWNLOADS
    assert_not cv_download.usable?
  end

  # record_download!

  test "record_download! increments download_count" do
    cv_download = cv_downloads(:one)
    count_before = cv_download.download_count
    cv_download.record_download!
    assert_equal count_before + 1, cv_download.reload.download_count
  end

  test "record_download! sets last_download_at" do
    cv_download = cv_downloads(:one)
    cv_download.record_download!
    assert_not_nil cv_download.reload.last_download_at
  end
end
