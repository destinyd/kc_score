Rails.application.routes.draw do
  KcScore::Routing.mount '/', :as => 'kc_score'
  mount PlayAuth::Engine => '/auth', :as => :auth
end
