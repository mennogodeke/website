module ExperienceHelper
  def expertise_card_class(name)
    case name
    when /back.?end/i    then "is-backend"
    when /cloud|devops/i then "is-cloud"
    when /ios|macos/i    then "is-ios"
    when /front.?end/i   then "is-frontend"
    else ""
    end
  end
end
