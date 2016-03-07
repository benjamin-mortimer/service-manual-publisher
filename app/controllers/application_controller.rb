class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include GDS::SSO::ControllerMethods
  before_filter :require_signin_permission!

  def preview_content_model_url(content_model)
    [Plek.find('draft-origin'), content_model.slug].join('')
  end
  helper_method :preview_content_model_url

  def back_or_default(fallback_uri = root_url, anchor: nil)
    uri = if request.referrer.present? && request.referrer != request.url
      request.referrer
    else
      fallback_uri
    end
    if anchor && uri.exclude?("#")
      uri += "##{anchor}"
    end
    uri
  end
end
