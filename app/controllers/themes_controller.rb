class ThemesController < ApplicationController
  def update
    theme = params[:theme] == "light" ? "light" : "dark"
    cookies.permanent[:theme] = theme
    redirect_back fallback_location: root_path
  end
end
