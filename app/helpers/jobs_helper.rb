module JobsHelper
  def job_end_date(date)
    date ? date.strftime("%b %Y") : "Present"
  end
end
