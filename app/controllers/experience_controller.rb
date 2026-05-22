class ExperienceController < ApplicationController
  def show
    @experiences = Experience.includes(experience_skills: :skill)
                              .where.not(category: :programming_language)
                              .sort_by { |e| -e.years_of_experience }
    @max_years = @experiences.map(&:years_of_experience).max
  end
end
