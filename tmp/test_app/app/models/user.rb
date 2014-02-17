class User
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def logged_in?
    true
  end

  def admin?
    contact.role_names.include?('superuser')
  end

  def contact
    @contact ||= refresh
  end

  def refresh
    @contact = Rails.cache.fetch("contact.#{user_id}", expires_in: 24.hours, force: true) do
      Infopark::Crm::Contact.find(user_id)
    end
  end

  def full_name
    [contact.first_name, contact.last_name].join(' ')
  end
end
