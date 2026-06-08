class CvDownloadsController < ApplicationController
  PDF_FILES = {
    "en" => Rails.root.join("storage", "cv", "cv.pdf"),
    "nl" => Rails.root.join("storage", "cv", "cv_nl.pdf"),
    "de" => Rails.root.join("storage", "cv", "cv_de.pdf")
  }.freeze

  DOWNLOAD_NAMES = {
    "en" => "menno_godeke_cv.pdf",
    "nl" => "menno_godeke_cv_nl.pdf",
    "de" => "menno_godeke_cv_de.pdf"
  }.freeze

  def new
    @cv_download = CvDownload.new
    @default_language = default_language
  end

  def create
    email    = params.dig(:cv_download, :email).to_s.strip
    language = params.dig(:cv_download, :language).presence || default_language

    existing = CvDownload.where(email: email).order(created_at: :desc).first

    if existing&.usable?
      existing.update!(language: language)
      CvDownloadMailer.confirmation(existing).deliver_later
      redirect_to new_cv_download_path, notice: t("cv_download.notice_sent")
      return
    end

    @cv_download = CvDownload.new(email: email, language: language)
    @default_language = language

    if @cv_download.save
      CvDownloadMailer.confirmation(@cv_download).deliver_later
      redirect_to new_cv_download_path, notice: t("cv_download.notice_sent")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @cv_download = CvDownload.find_by(token: params[:token])

    if @cv_download.nil? || !@cv_download.usable?
      redirect_to new_cv_download_path, alert: t("cv_download.alert_invalid")
      return
    end

    lang     = @cv_download.language || "en"
    pdf_path = PDF_FILES[lang]

    unless File.exist?(pdf_path)
      redirect_to cv_path, alert: t("cv_download.alert_unavailable")
      return
    end

    @cv_download.record_download!

    send_file pdf_path,
              filename: DOWNLOAD_NAMES[lang],
              type: "application/pdf",
              disposition: "attachment"
  end

  private

  def default_language
    locale = I18n.locale.to_s
    CvDownload.languages.key?(locale) ? locale : "en"
  end
end
