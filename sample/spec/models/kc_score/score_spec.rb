require 'rails_helper'

RSpec.describe KcScore::Score, type: :model do
  it { should validate_presence_of :score }

  it "基础字段" do
    @score = create(:score)
    expect(@score.respond_to?(:score)).to be true
    expect(@score.respond_to?(:text)).to be true

    expect(@score.respond_to?(:score_sourceable_id)).to be true
    expect(@score.respond_to?(:score_sourceable_type)).to be true
    expect(@score.respond_to?(:score_targetable_id)).to be true
    expect(@score.respond_to?(:score_targetable_type)).to be true
  end

  it "关系" do
    @score = create(:score)
    expect(@score.respond_to?(:score_sourceable)).to be true
    expect(@score.respond_to?(:score_targetable)).to be true
  end

  #describe "scopes" do
  #end
end
