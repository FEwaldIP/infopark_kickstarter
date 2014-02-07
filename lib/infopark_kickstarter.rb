require 'rails/generators'

require 'infopark_kickstarter/engine'

require 'generators/cms/actions'
require 'generators/cms/migration'
require 'generators/cms/widget/example'

module InfoparkKickstarter
  extend ActiveSupport::Autoload

  autoload :Resource
  autoload :Attribute
  autoload :ObjClass
end
