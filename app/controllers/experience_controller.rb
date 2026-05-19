class ExperienceController < ApplicationController
  def show
    @experiences = Experience.includes(:skills).all
    @skills = Skill.all
  end
end
