class PagesController < ApplicationController
  def home
  end

  def experience
    @expertises = Expertise.includes(:skills).all
    @skills = Skill.all
  end

  def career
  end

  def projects
  end

  def contact
  end
end
