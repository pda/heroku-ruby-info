require "erb"
require "json"

run ->(env) {

  COMMANDS = [
    "ruby --version",
    "gem --version",
    "bundle --version",
    "cat Gemfile",
  ]

  commands = Hash[
    COMMANDS.map { |cmd| [cmd, `#{cmd}`] }
  ]

  case env["PATH_INFO"]
  when "/"
    [
      200,
      {"Content-Type" => "text/html"},
      [ERB.new(File.read("index.html.erb")).result(binding)]
    ]
  when "/style.css"
    [
      200,
      {"Content-Type" => "text/css"},
      [File.read("style.css")]
    ]
  when "/index.json"
    [
      200,
      {"Content-Type" => "text/json"},
      [JSON.pretty_generate(commands)]
    ]
  else
    [404, {"Content-Type" => "text/plain"}, ["404: Not Found"]]
  end


}
