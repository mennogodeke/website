Job.find_or_create_by!(title: "Senior Software Engineer", company: "Kape Technologies") do |job|
  job.start_date = "2022-02-01"
  job.end_date   = "2026-01-01"
  job.description = "Led development of payment integrations and data-heavy Rails applications. Focused on TDD and CI/CD pipelines."
end

Job.find_or_create_by!(title: "Software Engineer", company: "Kape Technologies") do |job|
  job.start_date = "2019-02-01"
  job.end_date   = "2022-01-01"
  job.description = "Built and maintained APIs and back-end services for a suite of privacy-focused products."
end

Job.find_or_create_by!(title: "Junior Software Engineer", company: "ZenGuard") do |job|
  job.start_date = "2017-08-01"
  job.end_date   = "2019-01-01"
end

Job.find_or_create_by!(title: "Software Engineering Intern", company: "ZenGuard") do |job|
  job.start_date = "2017-02-01"
  job.end_date   = "2017-07-01"
end

Job.find_or_create_by!(title: "Software Engineering Intern", company: "Shopboostr") do |job|
  job.start_date = "2016-06-01"
  job.end_date   = "2016-12-01"
end
