require "net/http"

namespace :cv do
  desc "Generate CV PDF and save to storage/cv/cv.pdf"
  task generate: :environment do
    output_path = Rails.root.join("storage", "cv", "cv.pdf")
    FileUtils.mkdir_p(output_path.dirname)

    port = 3099
    url  = "http://localhost:#{port}/cv"
    server_pid = nil

    begin
      server_pid = Process.spawn(
        "bin/rails server -p #{port} -e development",
        out: File::NULL,
        err: File::NULL
      )

      print "Starting server"
      ready = 30.times.any? do
        sleep 1
        print "."
        Net::HTTP.get_response(URI("http://localhost:#{port}/up")).is_a?(Net::HTTPSuccess)
      rescue Errno::ECONNREFUSED, Errno::ECONNRESET
        false
      end
      puts

      raise "Server failed to start on port #{port}" unless ready

      puts "Generating PDF from #{url}..."
      pdf = Grover.new(url, format: "A4", print_background: true).to_pdf

      File.binwrite(output_path, pdf)
      puts "Written to #{output_path}"
    ensure
      if server_pid
        Process.kill("TERM", server_pid)
        Process.wait(server_pid)
      end
    end
  end
end
