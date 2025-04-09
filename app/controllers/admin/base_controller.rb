module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    layout 'admin'

    private

    def ensure_admin!
      redirect_to root_path, alert: "Access denied" unless current_user.admin?
    end
  end
end