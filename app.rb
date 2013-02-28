require "sinatra"

COMMANDS = [
  "ruby --version",
  "gem --version",
  "bundle --version",
]

get "/" do

  @commands = Hash[
    COMMANDS.map { |cmd| [cmd, `#{cmd}`] }
  ]

  @gemfile = File.read("Gemfile")

  erb :index

end
