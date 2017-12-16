class ApplicationController < JSONAPI::ResourceController
  protect_from_forgery with: :exception
end
