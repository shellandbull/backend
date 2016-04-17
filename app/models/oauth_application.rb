OauthApplication = Doorkeeper::Application

class OauthApplication
  belongs_to :owner, required: true, dependent: :destroy, class_name: "User"
end
