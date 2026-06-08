class PagesController < ApplicationController
  def home
    @jobs = Job.includes(:skills).order(start_date: :desc).limit(3)
    @top_experiences = Experience.limit(6)
    @featured_project = Project.includes(:skills).order(year: :desc).first
    @chip_skills = Skill.where("icon LIKE 'devicon%'").where.not(accent: nil).order(:name)
    @lang_cards = Experience.includes(:experience_skills, :skills)
                            .where(name: [ "Ruby", "Go", "Swift", "AI-Ready Development" ])
                            .index_by(&:name)
                            .values_at("Ruby", "Go", "Swift", "AI-Ready Development")
                            .compact
  end

  def contact
  end

  def cv
    load_cv_data
  end

  def cv_preview
    load_cv_data
    render layout: "cv"
  end

  private

  def load_cv_data
    @jobs = Job.includes(:skills).order(start_date: :desc)
    @experiences = Experience.includes(:skills).all
    @skills = Skill.all
  end
end
