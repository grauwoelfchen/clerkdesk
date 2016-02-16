module Shared
  module AvatarLinkHelper
    def avatar_url(user)
      if user.avatar_url.present?
        user.avatar_url
      else
        default_url = ''
        gravater_id = Digest::MD5.hexdigest(user.email.downcase)
        "https://gravatar.com/avatar/#{gravater_id}.png?" \
          "s=40&d=#{CGI.escape(default_url)}"
      end
    end
  end
end
