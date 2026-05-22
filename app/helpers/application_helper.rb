module ApplicationHelper
  EXPERIENCE_RAIL_ICONS = {
    "backend"              => "fa-solid fa-server",
    "fullstack"            => "fa-solid fa-layer-group",
    "devops"               => "fa-solid fa-gears",
    "cloud"                => "fa-solid fa-cloud",
    "apps"                 => "fa-brands fa-apple",
    "programming_language" => "fa-solid fa-cubes"
  }.freeze

  def safe_url(url)
    return nil if url.blank?
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) ? url : nil
  rescue URI::InvalidURIError
    nil
  end

  def experience_rail_icon(category)
    EXPERIENCE_RAIL_ICONS.fetch(category.to_s, "fa-solid fa-cubes")
  end
end
