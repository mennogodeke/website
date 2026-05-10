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

  def cv
    @jobs = Job.includes(:skills).order(start_date: :desc)
    @expertises = Expertise.includes(:skills).all
    @skills = Skill.all
  end
end
