module ApplicationHelper
  def safe_url(url)
    return nil if url.blank?
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) ? url : nil
  rescue URI::InvalidURIError
    nil
  end
end
