class PagesController < ApplicationController
  def home
    @jobs = Job.includes(:skills).order(start_date: :desc).limit(2)
    @top_experiences = Experience.limit(6)
    @featured_project = Project.includes(:skills).order(year: :desc).first
  end

  def contact
  end

  def design_preview
    @experiences = Experience.includes(:skills).all
    @jobs = Job.includes(:skills).order(start_date: :desc).limit(2)
    @top_experiences = Experience.limit(6)
    @featured_project = Project.includes(:skills).order(year: :desc).first
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
