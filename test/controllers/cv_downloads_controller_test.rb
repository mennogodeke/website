require "test_helper"

class CvDownloadsControllerTest < ActionDispatch::IntegrationTest
  test "new renders the download form" do
    get new_cv_download_url
    assert_response :success
    assert_select "form"
  end

  test "create with valid email redirects and enqueues mail" do
    assert_difference "CvDownload.count", 1 do
      post cv_downloads_url, params: { cv_download: { email: "test@example.com" } }
    end
    assert_redirected_to new_cv_download_url
  end

  test "create with invalid email re-renders form" do
    assert_no_difference "CvDownload.count" do
      post cv_downloads_url, params: { cv_download: { email: "bad" } }
    end
    assert_response :unprocessable_entity
  end

  test "show with valid token records download" do
    cv_download = cv_downloads(:one)
    cv_download.update!(requested_at: 1.hour.ago)
    count_before = cv_download.download_count

    get cv_download_url(token: cv_download.token)

    assert_equal count_before + 1, cv_download.reload.download_count
    # sends the file (200) if the PDF exists, redirects to cv_path if not yet generated
    assert_includes [ 200, 302 ], response.status
  end

  test "show with expired token redirects to new with alert" do
    cv_download = cv_downloads(:two)
    cv_download.update!(requested_at: 25.hours.ago)

    get cv_download_url(token: cv_download.token)

    assert_redirected_to new_cv_download_url
  end

  test "show with unknown token redirects to new with alert" do
    get cv_download_url(token: "doesnotexist")
    assert_redirected_to new_cv_download_url
  end
end
