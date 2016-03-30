require 'rails_helper'

class Course1
  include Mongoid::Document
  include Mongoid::Timestamps
end

class User1
  include Mongoid::Document
  include Mongoid::Timestamps
  include KcScore::Concerns::Sourceable
  act_as_score_sourceable :course1 => nil
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

        @score1 = 1
        @score2 = 3

        @course = Course1.create
        expect(@user.score_it(@course, @score1)).to be_valid
        expect(@user.score_it(@course, @score1)).to_not be_valid

        @course1 = Course1.create
        expect(@user.score_it(@course1, @score2, '测试')).to be_valid

        # 对象直接include
        expect(@course1.score_of('user1')).to eq @score2
      end

      it "#scored?" do
        expect(@user.respond_to?(:score_it)).to be true

        @course = create(:course)
        expect(@user.scored?(@course)).to be false
        @user.score_it(@course, 1)
        expect(@user.scored?(@course)).to be true
      end
    end
  end
end
