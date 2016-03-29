module KcScore
  class Routing
    # KcScore::Routing.mount "/kc_score", :as => 'kc_score'
    def self.mount(prefix, options)
      KcScore.set_mount_prefix prefix

      Rails.application.routes.draw do
        mount KcScore::Engine => prefix, :as => options[:as]
      end
    end
  end
end
