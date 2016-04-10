class OauthApplicationSerializer < ApplicationSerializer
  attributes :name, :redirect_uri, :owner_id

  def type
    "oauth-applications"
  end
end
