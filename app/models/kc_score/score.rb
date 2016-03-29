module KcScore
  class Score
    include Mongoid::Document
    include Mongoid::Timestamps

    field :score, :type => Integer
    field :text, :type => String

    belongs_to :sourceable, polymorphic: true
    belongs_to :targetable, polymorphic: true

    validates :score, presence: true
  end
end

