class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後（投稿画面一覧）
  def after_sign_in_path_for(resource)
    post_images_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
