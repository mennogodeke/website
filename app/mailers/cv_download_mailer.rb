class CvDownloadMailer < ApplicationMailer
  def confirmation(cv_download)
    @cv_download = cv_download
    @download_url = cv_download_url(token: cv_download.token)

    mail(to: cv_download.email, subject: "Your CV download link")
  end
end
