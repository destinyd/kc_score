require 'rails_helper'

class User2
  include Mongoid::Document
  include Mongoid::Timestamps
  include KcScore::Concerns::Sourceable
  act_as_score_sourceable :photo => nil
end

class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include KcScore::Concerns::Targetable
end


RSpec.describe KcScore::Concerns::Targetable, type: :module do
  describe User, type: :model do
    before do
      @user1 = User2.create
      @user2 = User2.create
      @photo = Photo.create
    end

    it "relationships" do
      expect(@photo.respond_to?(:scores)).to be true
    end

    describe "methods" do
      it "#score_of" do
        expect(@photo.respond_to?(:score_of)).to be true

        expect(@photo.score_of('user2')).to eq 0

        @user1.score_it(@photo, 1)
        expect(@photo.score_of('User2')).to eq 1

        @user2.score_it(@photo, 5, '你好')
        expect(@photo.score_of('user2')).to eq 6
      end
    end
  end
end
