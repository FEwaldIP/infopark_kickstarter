class ContactPagePresenter
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  ATTRIBUTES = %w(
    email
    subject
    message
  )

  validates :subject, presence: true
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
