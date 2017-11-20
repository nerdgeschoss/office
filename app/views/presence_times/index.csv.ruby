require "csv"

CSV.generate do |csv|
  csv << [:start_at, :end_at, :duration]
  @presence_times.each do |time|
    csv << [time.start_at, time.end_at, time.duration]
  end
end
