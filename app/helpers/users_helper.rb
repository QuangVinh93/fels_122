module UsersHelper
  def gravatar_for user, size = Settings.avatar.size
    if user.present?
      gravatar_id = Digest::MD5::hexdigest user.email.downcase
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_tag gravatar_url, alt: user.name, class: "gravatar"
    end
  end

  def avatar_for user, height = Settings.height, width = Settings.width
    if user.avatar.blank?
      image_tag Settings.avatar.default, height: height, width: width
    else
      image_tag user.avatar_url(:thumb)
    end
  end
end
