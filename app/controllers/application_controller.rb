class ApplicationController < ActionController::Base
  # before_action :authenticate_customer!, except: [:top, :about, :show, :index, :edit]
  # ↑ここだと全てに適応されてしまうので、今回のようなcustomer,adminで分けるときは各々のControllerに記述する。
  # adminのデータをcustomerに記述するのは、2つに分けている場合同じemail等の入力になるのでできない。好ましくない。
  before_action :authenticate_admin!, if: :admin_url
  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin_url
    request.fullpath.include?("/admin")
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end

end
