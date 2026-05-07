class JobsController < ApplicationController
  def index
    @jobs = Job.order(start_date: :desc)
  end
end
