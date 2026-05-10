class PagesController < ApplicationController
  def home
  end

  def experience
    @expertises = Expertise.includes(:skills).all
    @skills = Skill.all
  end

  def projects
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
    @expertises = Expertise.includes(:skills).all
    @skills = Skill.all
  end
end
