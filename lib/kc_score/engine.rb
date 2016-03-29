module KcScore
  class Engine < ::Rails::Engine
    isolate_namespace KcScore
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper

      Dir.glob(Rails.root + "app/decorators/kc_score/**/*_decorator.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
