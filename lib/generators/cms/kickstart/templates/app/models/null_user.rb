class NullUser
  attr_reader :user_id

  def logged_in?
    false
  end

  def admin?
    false
  end
end
