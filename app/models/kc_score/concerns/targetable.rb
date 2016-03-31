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

      # 被具体某个来源评价数据
      # 无 则返回 nil
      # 可以通过返回数据 obj.score 查看评分
      # 可以通过返回数据 obj.text 查看评价的评论内容
      def score_by sourceable
        scores.where(score_sourceable: sourceable).first
      end

      module ClassMethods
      end
    end
  end
end
