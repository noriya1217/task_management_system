class ApplicationController < ActionController::Base
  before_action :basic
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == 'hoge' && password == 'piyo'
    end
  end
end
