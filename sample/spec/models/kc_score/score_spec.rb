require 'rails_helper'

RSpec.describe KcScore::Score, type: :model do
  before do
    @user = create(:user)
    @course = create(:course)
    @score = create(:score, score_sourceable: @user, score_targetable: @course)
  end

  it { should validate_presence_of :score }

  it "基础字段" do
    expect(@score.respond_to?(:score_sourceable_id)).to be true
    expect(@score.respond_to?(:score_sourceable_type)).to be true
    expect(@score.respond_to?(:score_targetable_id)).to be true
    expect(@score.respond_to?(:score_targetable_type)).to be true
  end

  it "关系" do
    expect(@score.respond_to?(:score_sourceable)).to be true
    expect(@score.respond_to?(:score_targetable)).to be true
  end

  #describe "scopes" do
  #end
end
