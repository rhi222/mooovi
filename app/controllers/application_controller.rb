class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	#deviseコントローラーのアクションが動いた時のみ、configure_permitted_parametersを動かす処理を書く
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception
	def after_sign_out_path_for(resource)
		'/users/sign_in' # サインアウト後のリダイレクト先URL
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up).push(:nickname, :avatar)
	end
end
