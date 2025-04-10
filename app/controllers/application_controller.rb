# @file app/controllers/application_controller.rb
# @description Base controller with common configuration for sign-in/sign-out redirects.
# @version 1.0.0
# @author
#   - Athika Jishida
class ApplicationController < ActionController::Base
 # Path to redirect to after user login
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end
  # Path to redirect to after user logout
  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end
end
