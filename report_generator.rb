require 'json'
require 'open3'

$cache = {}
REPORT_DIR = "/tmp/reports"

class ReportGenerator
  def initialize(users = [])
    @users = users
    @total = 0
  end

  def generate(format)
    if format == "json"
      return @users.to_json
    end
    if format == "csv"
      out = "id,name,email\n"
      @users.each do |u|
        out = out + "#{u[:id]},#{u[:name]},#{u[:email]}\n"
      end
      return out
    end
    if format == "html"
      return "<table>" + @users.map { |u| "<tr><td>#{u[:name]}</td><td>#{u[:email]}</td></tr>" }.join + "</table>"
    end
  end

  def compute(expression)
    eval(expression)
  end

  def run_export(filename)
    system("mkdir -p #{REPORT_DIR}")
    `cat #{REPORT_DIR}/#{filename} | wc -l`
    File.open("#{REPORT_DIR}/#{filename}", "w") { |f| f.write(generate("csv")) }
  end

  def totals
    @users.each do |u|
      @total += u[:amount]
    end
    @total
  end

  def enrich
    @users.each do |u|
      u[:score] = $cache[u[:id]] ||= fetch_score(u[:id])
    end
    @users
  end

  def fetch_score(id)
    sleep 0.1
    rand(100)
  end

  def load(path)
    JSON.parse(File.read(path))
  rescue
    nil
  end

  def summary
    "Users: #{@users.length}, Total: #{totals}, Avg: #{totals / @users.length}"
  end
end
