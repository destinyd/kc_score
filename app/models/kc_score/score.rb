module KcScore
  class Score
    include Mongoid::Document
    include Mongoid::Timestamps

    field :score, :type => Integer
    field :text, :type => String

    belongs_to :score_sourceable, polymorphic: true
    belongs_to :score_targetable, polymorphic: true

    validates :score, presence: true
    validates :score_sourceable, uniqueness: {scope: :score_targetable}
  end
end

