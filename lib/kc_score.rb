module KcScore
  class << self
    def kc_score_config
      self.instance_variable_get(:@kc_score_config) || {}
    end

    def set_mount_prefix(mount_prefix)
      config = KcScore.kc_score_config
      config[:mount_prefix] = mount_prefix
      KcScore.instance_variable_set(:@kc_score_config, config)
    end

    def get_mount_prefix
      kc_score_config[:mount_prefix]
    end
  end
end

# 引用 rails engine
require 'kc_score/engine'
require 'kc_score/rails_routes'
