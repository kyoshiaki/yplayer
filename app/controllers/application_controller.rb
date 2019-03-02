class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper
  include DirectoriesHelper
  include SessionsHelper
  include SoundPlayersHelper
  include SoundsHelper
  include UsersHelper
end
