require 'rails_helper'

class User1
  include Mongoid::Document
  include Mongoid::Timestamps
  include KcScore::Concerns::Sourceable
  act_as_score_sourceable :course => nil
end


RSpec.describe KcScore::Concerns::Sourceable, type: :module do
  describe User, type: :model do
    before do
      @user = User1.create
    end

    it "relationships" do
      expect(@user.respond_to?(:scores)).to be true
    end

    describe "methods" do
      it "#score_it" do
        expect(@user.respond_to?(:score_it)).to be true

        @course = create(:course)
        expect(@user.score_it(@course, 1)).to be_valid
        expect(@user.score_it(@course, 1)).to_not be_valid

        @course1 = create(:course)

        @course1 = create(:course)
        expect(@user.score_it(@course1, 1, '测试')).to be_valid
      end
    end
  end
end
