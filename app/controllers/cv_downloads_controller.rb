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

    pdf_path = Rails.root.join("storage", "cv", "cv.pdf")

    unless File.exist?(pdf_path)
      redirect_to cv_path, alert: "The CV PDF isn't available yet — check back soon."
      return
    end

    send_file pdf_path,
              filename: "menno-godeke-cv.pdf",
              type: "application/pdf",
              disposition: "attachment"
  end
end
