class ProfilePagePresenter
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  ATTRIBUTES = %w(
    id
    gender
    first_name
    last_name
    email
    language
    want_email
  )

  ATTRIBUTES.each do |attribute|
    attr_accessor attribute
  end

  validates :id, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def initialize(attributes = {})
    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end
  end

  def attributes
    ATTRIBUTES.inject({}) do |hash, attribute|
      hash[attribute] = send(attribute)
      hash
    end
  end

  private

  def persisted?
    false
  end
end
