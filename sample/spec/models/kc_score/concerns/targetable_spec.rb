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
    end
  end
end
