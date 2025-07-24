class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern
  include Pundit

  def after_sign_in_path_for(resource)
    ideas_path
  end

  def after_sign_up_path_for(resource)
    ideas_path
  end
end
