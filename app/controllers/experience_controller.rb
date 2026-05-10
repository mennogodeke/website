class ExperienceController < ApplicationController
  def show
    @expertises = Expertise.includes(:skills).all
    @skills = Skill.all
  end
end
