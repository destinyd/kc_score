require 'rails_helper'

class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include KcScore::Concerns::Targetable
end

class Course2
  include Mongoid::Document
  include Mongoid::Timestamps
end

class User2
  include Mongoid::Document
  include Mongoid::Timestamps
  include KcScore::Concerns::Sourceable
  act_as_score_sourceable :course2 => nil
end


RSpec.describe KcScore::Concerns::Targetable, type: :module do
  describe Photo, type: :model do
    before do
      @photo = Photo.create
      @user = create(:user)
    end

    it "relationships" do
      expect(@photo.respond_to?(:scores)).to be true
    end

    describe "methods" do
      it "#score_of" do
        expect(@photo.respond_to?(:score_of)).to be true

        # 因为没有评价，所以分值统计为0
        expect(@photo.score_of('user')).to eq 0
      end

      it "#score_by" do
        expect(@photo.respond_to?(:score_by)).to be true

        # 因为没有，返回nil
        expect(@photo.score_by(@user)).to be_nil
      end
    end
  end

  describe Course2, type: :model do
    before do
      @user1 = User2.create
      @user2 = User2.create
      @course = Course2.create
    end

    describe "methods" do
      it "#score_of" do
        expect(@course.respond_to?(:score_of)).to be true

        @score1 = 1
        @score2 = 2

        expect(@course.score_of('user2')).to eq 0

        @user1.score_it(@course, @score1)
        expect(@course.score_of('User2')).to eq 1

        @user2.score_it(@course, @score2, '你好')
        expect(@course.score_of('user2')).to eq @score1 + @score2
      end

      it "#score_by" do
        @score1 = 1
        @text = '测试'
        expect(@course.score_by(@user1)).to be_nil

        @user1.score_it(@course, @score1, @text)

        @score = @course.score_by(@user1)
        expect(@score).to_not be_nil
        expect(@score.score).to eq @score1
        expect(@score.text).to eq @text
      end
    end
  end
end
