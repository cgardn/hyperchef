require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems you've limited to
# :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hyperchef class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails
  # version.
    config.load_defaults 6.0

    # autoload paths
    config.autoload_paths << Rails.root.join('services')

    # cache store
    #   using memory store since the only thing in it is the Filter Graph,
    #   which doesn't involve user data so will be the same across all 
    #   instances
    config.cache_store = :memory_store

    # initialize cached data
    config.after_initialize do
      FilterGraph.graph()
    end

    # Settings in config/environments/* take precedence over those specified
    # here.  Application configuration can go into files in
    # config/initializers -- all .rb files in that directory are automatically
    # loaded after loading the framework and any gems in your application.
  end end
