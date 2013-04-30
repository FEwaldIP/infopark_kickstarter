gem('infopark_rails_connector')
gem('infopark_cloud_connector')

gem_group(:assets) do
  gem('therubyracer', require: 'v8')
end

gem_group(:test, :development) do
  gem('infopark_kickstarter', path: '../../../')
end

run('bundle --quiet')

generate('cms:kickstart')