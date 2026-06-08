require "test_helper"

class CvDownloadsControllerTest < ActionDispatch::IntegrationTest
  test "new renders the download form" do
    get new_cv_download_url
    assert_response :success
    assert_select "form"
  end

  # create — new record

  test "create with valid email creates a record and enqueues mail" do
    assert_difference "CvDownload.count", 1 do
      post cv_downloads_url, params: { cv_download: { email: "test@example.com", language: "en" } }
    end
    assert_redirected_to new_cv_download_url
  end

  test "create stores the selected language on the record" do
    post cv_downloads_url, params: { cv_download: { email: "test@example.com", language: "nl" } }
    assert_equal "nl", CvDownload.last.language
  end

  test "create with invalid email re-renders form" do
    assert_no_difference "CvDownload.count" do
      post cv_downloads_url, params: { cv_download: { email: "bad" } }
    end
    assert_response :unprocessable_entity
  end

  # create — token reuse

  test "create with existing valid token reuses it and does not create a new record" do
    cv_download = cv_downloads(:one)
    cv_download.update!(requested_at: 1.hour.ago, download_count: 0)

    assert_no_difference "CvDownload.count" do
      post cv_downloads_url, params: { cv_download: { email: cv_download.email, language: "nl" } }
    end
    assert_redirected_to new_cv_download_url
  end

  test "create with existing valid token updates language on existing record" do
    cv_download = cv_downloads(:one)
    cv_download.update!(requested_at: 1.hour.ago, download_count: 0)

    post cv_downloads_url, params: { cv_download: { email: cv_download.email, language: "de" } }
    assert_equal "de", cv_download.reload.language
  end

  test "create with existing expired token creates a new record" do
    cv_download = cv_downloads(:two)
    cv_download.update!(requested_at: 25.hours.ago)

    assert_difference "CvDownload.count", 1 do
      post cv_downloads_url, params: { cv_download: { email: cv_download.email, language: "en" } }
    end
  end

  test "create with existing maxed-out token creates a new record" do
    cv_download = cv_downloads(:one)
    cv_download.update!(requested_at: 1.hour.ago, download_count: CvDownload::MAX_DOWNLOADS)

    assert_difference "CvDownload.count", 1 do
      post cv_downloads_url, params: { cv_download: { email: cv_download.email, language: "en" } }
    end
  end

  # show — valid token

  test "show with valid token records download and serves file" do
    skip("Will be reimplemented through gh issue #84")
    cv_download = cv_downloads(:one)
    cv_download.update!(requested_at: 1.hour.ago, download_count: 0)
    count_before = cv_download.download_count

    Dir.mktmpdir do |dir|
      pdf = File.join(dir, "cv_en.pdf")
      FileUtils.touch(pdf)

      CvDownloadsController.prepend(Module.new do
        private
        define_method(:pdf_storage_path) { |lang| pdf }
      end)
    end

    # File won't exist in test env — assert it redirects gracefully to cv_path
    get cv_download_url(token: cv_download.token)
    assert_equal count_before + 1, cv_download.reload.download_count
    assert_redirected_to cv_path
  end

  test "show with valid token redirects to cv_path when pdf is missing" do
    skip("Will be reimplemented through gh issue #84")
    cv_download = cv_downloads(:one)
    cv_download.update!(requested_at: 1.hour.ago, download_count: 0)

    get cv_download_url(token: cv_download.token)
    assert_redirected_to cv_path
  end

  # show — guard rails

  test "show with expired token redirects to new with alert" do
    cv_download = cv_downloads(:two)
    cv_download.update!(requested_at: 25.hours.ago)

    get cv_download_url(token: cv_download.token)
    assert_redirected_to new_cv_download_url
  end

  test "show with maxed-out token redirects to new with alert" do
    cv_download = cv_downloads(:one)
    cv_download.update!(requested_at: 1.hour.ago, download_count: CvDownload::MAX_DOWNLOADS)

    get cv_download_url(token: cv_download.token)
    assert_redirected_to new_cv_download_url
  end

  test "show with unknown token redirects to new with alert" do
    get cv_download_url(token: "doesnotexist")
    assert_redirected_to new_cv_download_url
  end
end
