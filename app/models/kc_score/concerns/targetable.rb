module KcScore
  module Concerns
    module Targetable
      extend ActiveSupport::Concern

      included do
        has_many :scores, as: :score_targetable, class_name: 'KcScore::Score'

        #cattr_accessor :targetable_collect
      end

      def score_of source_class_name
        scores.where(score_sourceable_type: source_class_name.camelize).sum(:score)
      end

      module ClassMethods
      end
    end
  end
end
