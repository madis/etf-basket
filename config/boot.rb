ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
if ENV['RAILS_ENV'] != 'production'
  # Disable bootsnap until https://forum.snapcraft.io/t/ld-library-path-in-classic-snap/5030/32
  require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
end
