class ApplicationController < ActionController::BASE
  before_action :authenticate_user!
end
