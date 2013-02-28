require "erb"
require "json"

COMMANDS = [
  "ruby --version",
  "gem --version",
  "bundle --version",
  "cat Gemfile",
]

commands = Hash[COMMANDS.map { |cmd| [cmd, `#{cmd}`.chop] }]
html = ERB.new(File.read("index.html.erb")).result(binding)
json = JSON.pretty_generate(commands)
css = File.read("style.css")

run ->(env) {

  case env["PATH_INFO"]

  when "/" then
    response 200, "text/html", html

  when "/index.json"
    response 200, "text/json", json

  when "/style.css"
    response 200, "text/css", css

  else
    response 404, "text/plain", "404: Not Found"

  end

}

def response(status, content_type, body)
  [status, {"Content-Type" => content_type}, [body]]
end
