class CvDownloadsController < ApplicationController
  def new
    @cv_download = CvDownload.new
  end

  def create
    @cv_download = CvDownload.new(email: params[:cv_download][:email])

    if @cv_download.save
      CvDownloadMailer.confirmation(@cv_download).deliver_later
      redirect_to new_cv_download_path, notice: "Check your email — a download link is on its way."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @cv_download = CvDownload.find_by(token: params[:token])

    if @cv_download.nil? || @cv_download.expired?
      redirect_to new_cv_download_path, alert: "This link is invalid or has expired. Please request a new one."
      return
    end

    @cv_download.record_download!

    # TODO: replace with send_file once PDF generation is implemented
    redirect_to cv_path, notice: "PDF download coming soon — enjoy the HTML version for now!"
  end
end
