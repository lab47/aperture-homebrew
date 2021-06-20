brew_dir = File.expand_path(File.dirname(__FILE__) + "/brew/Library/Homebrew") 

ENV["HOMEBREW_BREW_FILE"] = File.expand_path(brew_dir, "brew.rb")
ENV["HOMEBREW_REPOSITORY"] = File.expand_path(File.join(brew_dir, "..", ".."))
ENV["HOMEBREW_LIBRARY"] = File.expand_path(File.join(brew_dir, ".."))

$in_build_dir ||= false

if $in_build_dir
  tmp = File.expand_path(Dir.getwd + "/brew-tmp")
else
  tmp = File.expand_path(File.dirname(__FILE__) + "/../tmp")
end

$state ||= ""

if $state != "" 
  ENV["HOMEBREW_PREFIX"] = $state
else
  ENV["HOMEBREW_PREFIX"] = File.join(tmp, "prefix")
end

Dir.mkdir File.join(tmp, "Cellar") rescue nil
Dir.mkdir File.join(tmp, "tmp") rescue nil
Dir.mkdir File.join(tmp, "Logs") rescue nil
Dir.mkdir File.join(tmp, "Cache") rescue nil
Dir.mkdir File.join(tmp, "prefix") rescue nil
ENV["HOMEBREW_CELLAR"] = File.join(tmp, "Cellar")
ENV["HOMEBREW_LOGS"] = File.join(tmp, "Logs")
ENV["HOMEBREW_CACHE"] = File.join(tmp, "Cache")
ENV["HOMEBREW_TEMP"] = ENV['TMPDIR'] || "/tmp"

version = `which sw_vers > /dev/null && sw_vers -productVersion || echo "no"`

if version != "no"
  ENV["HOMEBREW_MACOS_VERSION"] = version
end

ENV["HOMEBREW_USER_AGENT_CURL"] = "iris 0.1"
ENV["HOMEBREW_RUBY_PATH"] = `which ruby`.strip # "/Users/evan/.rbenv/shims/ruby"

$: << brew_dir
$: << File.expand_path(File.dirname(__FILE__) + "/..")
