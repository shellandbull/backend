# Be sure to restart your server when you modify this file.
# https://github.com/rails-api/active_model_serializers/issues/1027#issuecomment-126543577
mime_types = [
  "application/vnd.api+json",
  "text/x-json",
  "application/json"
]

Mime::Type.unregister :json
Mime::Type.register "application/json", :json, mime_types
