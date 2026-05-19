class ExperienceController < ApplicationController
  def show
    @experiences = Experience.includes(:skills).where.not(category: :programming_language)
    @programming_languages = Experience.includes(:skills).all.programming_language
    @skills = Skill.all
  end
end
