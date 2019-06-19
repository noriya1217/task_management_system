class ApplicationController < ActionController::Base
  before_action :basic

  private
  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == 'hoge' && password == 'piyo'
    end
  end
end
