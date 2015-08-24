module SessionHelper

  def is_admin?
    if(user_signed_in?)
      if(current_user.role.name == "admin")
        return true
      end
    end

    return false
  end
end
