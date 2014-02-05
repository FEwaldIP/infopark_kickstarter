
# Set cache path outside of the application directory.
RailsConnector::Configuration.cache_path = "/tmp/cache/#{Rails.root.basename}"
