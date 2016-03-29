module KcScore
  class ApplicationController < ActionController::Base
    layout "kc_score/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
    end
  end
end