require "test_helper"

class CvDownloadMailerTest < ActionMailer::TestCase
  test "confirmation email is addressed correctly" do
    cv_download = cv_downloads(:one)
    mail = CvDownloadMailer.confirmation(cv_download)

    assert_equal [cv_download.email], mail.to
    assert_equal "Your CV download link", mail.subject
  end

  test "confirmation email body contains the download url" do
    cv_download = cv_downloads(:one)
    mail = CvDownloadMailer.confirmation(cv_download)

    assert_match cv_download.token, mail.body.encoded
  end
end
