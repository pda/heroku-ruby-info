require "erb"
require "json"

COMMANDS = [
  "ruby --version",
  "gem --version",
  "bundle --version",
  "cat Gemfile",
]

commands = Hash[COMMANDS.map { |cmd| [cmd, `#{cmd}`.chop] }]

run ->(env) {

  case env["PATH_INFO"]

  when "/"
    template = File.read("index.html.erb")
    response 200, "text/html", ERB.new(template).result(binding)

  when "/index.json"
    response 200, "text/json", JSON.pretty_generate(commands)

  when "/style.css"
    response 200, "text/css", File.read("style.css")

  else
    response 404, "text/plain", "404: Not Found"

  end

}

def response(status, content_type, body)
  [status, {"Content-Type" => content_type}, [body]]
end
